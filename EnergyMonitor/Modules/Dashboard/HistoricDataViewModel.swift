import Foundation
import EnergyDataFeature

public final class HistoricDataViewModel: Identifiable, ObservableObject {
  private let historyLoader: HistoryLoader
  private var historicData: [History] = []

  init(historyLoader: HistoryLoader) {
    self.historyLoader = historyLoader
  }

  public func fetch(completion: @escaping (Bool) -> Void) {
    historyLoader.load { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let data):
        self.historicData = data
        completion(true)

      case .failure:
        completion(false)
      }
    }
  }
}
