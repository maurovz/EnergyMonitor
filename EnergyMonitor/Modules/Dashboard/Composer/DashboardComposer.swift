import Foundation
import EnergyDataFeature

struct DashboardComposer {
  static let historicData = "historic_data"

  static func createModule() -> DashboardView {
    let coreDataService = CoreDataServices()

    let remoteHistoryLoader = RemoteHistoricDataLoader(
      url: URL(string: historicData)!,
      client: MockHTTPClient(
        filePath: historicData),
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
