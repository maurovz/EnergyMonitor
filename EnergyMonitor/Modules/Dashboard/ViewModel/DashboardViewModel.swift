import Foundation
import EnergyDataFeature
import Combine

final class DashboardViewModel: ObservableObject {
  private let historyLoader: HistoryLoader

  @Published var historicData: [HistoricDataViewModel] = []
  @Published var liveDataViewModel: LiveDataViewModel
  @Published var totalChargedPower: Double = 0
  @Published var totalDischargedPower: Double = 0
  @Published var appError: ErrorType?
  @Published var showError = false

  init(historyLoader: HistoryLoader, liveDataViewModel: LiveDataViewModel) {
    self.historyLoader = historyLoader
    self.liveDataViewModel = liveDataViewModel
    fetchData()
  }

  private func fetchData() {
    fetchHistoricData { _ in }

    liveDataViewModel.fetch {[weak self] result in
      guard let self = self else { return }

      switch result {
      case .failure:
        self.appError = .init(error: AppError.networkError)
        self.showError = true
      default:
        return
      }
    }
  }

  private func fetchHistoricData(completion: @escaping (Result<[HistoricDataViewModel], AppError>) -> Void) {
    historyLoader.load { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let data):
        self.historicData = data.map { HistoricDataViewModel(historicData: $0) }
        self.setupView()
        completion(.success(self.historicData))

      case .failure:
        self.appError = .init(error: AppError.networkError)
        completion(.failure(AppError.networkError))
      }
    }
  }
}

private extension DashboardViewModel {
  func setupView() {
    totalChargedPower = getTotalChargedPower()
    totalDischargedPower = getTotalDisChargedPower()
  }

  func getTotalChargedPower() -> Double {
    let value = historicData.filter { $0.quasarsPower > 0 }.map { $0.quasarsPower }.reduce(0, +)
    return Double(truncating: value as NSNumber)
  }

  func getTotalDisChargedPower() -> Double {
    let value = historicData.filter { $0.quasarsPower < 0 }.map { $0.quasarsPower }.reduce(0, +)
    return Double(truncating: value as NSNumber)
  }
}
