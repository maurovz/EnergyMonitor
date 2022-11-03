import Foundation
import EnergyDataFeature

struct DashboardComposer {
  static func createModule() -> DashboardView {
    let coreDataService = CoreDataServices()

    let remoteHistoryLoader = RemoteHistoricDataLoader(
      url: URL(string: "historic_data")!,
      client: MockHTTPClient(
        filePath: "historic_data"),
      cache: coreDataService)

    let remoteLiveDataLoader = RemoteLiveDataLoader(
      url: URL(string: "live-data")!,
      client: MockHTTPClient(
        filePath: "live_data"),
      cache: coreDataService)

    return DashboardView(
      viewModel: DashboardViewModel(
        historyLoader: remoteHistoryLoader,
        liveDataViewModel: LiveDataViewModel(liveDataLoader: remoteLiveDataLoader)
      )
    )
  }
}
