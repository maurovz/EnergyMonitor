import Foundation
import EnergyDataFeature
import Combine

final class DashboardViewModel: ObservableObject {
  private let historyLoader: HistoryLoader

  @Published var historicData: [HistoricDataViewModel] = []
  @Published var liveDataViewModel: LiveDataViewModel
  @Published var totalChargedPower: Double = 0
  @Published var hourlyChargedPower: Double = 0
  @Published var totalDischargedPower: Double = 0
  @Published var hourlyDischargedPower: Double = 0
  @Published var appError: ErrorType?
  @Published var showError = false

  init(historyLoader: HistoryLoader, liveDataViewModel: LiveDataViewModel) {
    self.historyLoader = historyLoader
    self.liveDataViewModel = liveDataViewModel
    fetchData()
  }

  private func fetchData() {
    fetchHistoricData()
    fetchLiveData()
  }
}

private extension DashboardViewModel {
  func fetchHistoricData() {
    historyLoader.load { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let data):
        self.historicData = data.map { HistoricDataViewModel(historicData: $0) }
        self.setupView(
          totalCharged: self.getTotalChargedPower(),
          totalDischarged: self.getTotalDisChargedPower()
        )

      case .failure(let error):
        self.appError = .init(error: error)
        self.showError = true
      }
    }
  }

  func fetchLiveData() {
    liveDataViewModel.fetch {[weak self] result in
      guard let self = self else { return }

      switch result {
      case .failure(let error):
        self.appError = .init(error: error)
        self.showError = true
      default:
        return
      }
    }
  }

  func setupView(totalCharged: Double, totalDischarged: Double) {
    totalChargedPower = totalCharged
    totalDischargedPower = abs(totalDischarged)
  }

  func getTotalChargedPower() -> Double {
    let value = historicData.filter { $0.quasarsPower > 0 }.map { $0.quasarsPower }.reduce(0, +)
    return Double(truncating: value as NSNumber)
  }

  func getConsuptionHourlyAverage() -> Double {
    let groupedDates = Dictionary(grouping: historicData) { value -> DateComponents in
      let date = Calendar.current.dateComponents([.hour], from: (value.timeStamp))
      return date
    }

    return getTotalChargedPower() / Double(groupedDates.count)
  }

  func getTotalDisChargedPower() -> Double {
    let value = historicData.filter { $0.quasarsPower < 0 }.map { $0.quasarsPower }.reduce(0, +)
    return Double(truncating: value as NSNumber)
  }
}
