import Foundation
import EnergyDataFeature
import Combine

final class DashboardViewModel: ObservableObject {
  private let historyLoader: HistoryLoader

  @Published var historicData: [HistoricDataViewModel] = []
  @Published var liveDataViewModel: LiveDataViewModel
  @Published var totalChargedPower: Double = 0
  @Published var totalDischargedPower: Double = 0

  init(historyLoader: HistoryLoader, liveDataViewModel: LiveDataViewModel) {
    self.historyLoader = historyLoader
    self.liveDataViewModel = liveDataViewModel
    fetchData()
  }

  func fetchData() {
    liveDataViewModel.fetch { _ in }
    fetchHistoricData { _ in }
  }

  public func fetchHistoricData(completion: @escaping (Bool) -> Void) {
    historyLoader.load { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let data):
        self.historicData = data.map { HistoricDataViewModel(historicData: $0) }
        self.setupView()
        completion(true)

      case .failure:
        completion(false)
      }
    }
  }

  private func setupView() {
    totalChargedPower = getTotalChargedPower()
    totalDischargedPower = getTotalDisChargedPower()
  }

  private func getTotalChargedPower() -> Double {
    let value = historicData.filter { $0.quasarsPower > 0 }.map { $0.quasarsPower }.reduce(0, +)
    return Double(truncating: value as NSNumber)
  }

  private func getTotalDisChargedPower() -> Double {
    let value = historicData.filter { $0.quasarsPower < 0 }.map { $0.quasarsPower }.reduce(0, +)
    return Double(truncating: value as NSNumber)
  }
}
