import Foundation
import EnergyDataFeature
import Combine

final class DashboardViewModel: ObservableObject {
  @Published var liveDataViewModel: LiveDataViewModel
  @Published var historicDataViewModel: HistoricDataViewModel

  init(historicDataViewModel: HistoricDataViewModel, liveDataViewModel: LiveDataViewModel) {
    self.historicDataViewModel = historicDataViewModel
    self.liveDataViewModel = liveDataViewModel
  }

  func fetchData() {
    liveDataViewModel.fetch { _ in }
    historicDataViewModel.fetch { _ in }
  }
}
