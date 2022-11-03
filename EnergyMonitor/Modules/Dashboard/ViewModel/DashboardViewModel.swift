import Foundation
import EnergyDataFeature
import Combine

final class DashboardViewModel: ObservableObject {
  private let historyLoader: HistoryLoader

  @Published var historicData: [HistoricDataViewModel] = []
//  @Published var liveDataViewModel: LiveDataViewModel

  init(historyLoader: HistoryLoader) {
    self.historyLoader = historyLoader
//    self.liveDataViewModel = liveDataViewModel
    fetchData()
  }

  func fetchData() {
//    liveDataViewModel.fetch { _ in }
    fetchHistoricData { _ in }
  }

  public func fetchHistoricData(completion: @escaping (Bool) -> Void) {
    historyLoader.load { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let data):
        self.historicData = data.map { HistoricDataViewModel(historicData: $0) }
        completion(true)

      case .failure:
        completion(false)
      }
    }
  }
}
