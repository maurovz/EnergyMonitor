import Foundation

struct DetailGraphComposer {
  static func createModule(historicData: [HistoricDataViewModel]) -> DetailGraphView {
    DetailGraphView(historicData: historicData)
  }
}
