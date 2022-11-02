import Foundation
import EnergyDataFeature
import Combine

final class DashboardViewModel: ObservableObject {
  private let historyLoader: HistoryLoader

  var delegate: DashboardProtocol?

  @Published var liveDataViewModel: LiveDataViewModel

  public init(
    historyLoader: HistoryLoader,
    liveDataViewModel: LiveDataViewModel) {
      self.historyLoader = historyLoader
      self.liveDataViewModel = liveDataViewModel
    }
}
