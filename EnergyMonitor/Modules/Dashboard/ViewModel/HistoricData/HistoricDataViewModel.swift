import Foundation
import EnergyDataFeature

public final class HistoricDataViewModel: Identifiable, ObservableObject {
  private var historicData: History

  lazy var buildingPower = {
    historicData.buildingPower
  }()

  lazy var gridPower = {
    historicData.gridPower
  }()

  lazy var pvPower = {
    historicData.pvPower
  }()

  lazy var quasarsPower = {
    historicData.quasarsPower
  }()

  lazy var timeStamp = {
    historicData.timeStamp
  }()

  init(historicData: History) {
    self.historicData = historicData
  }
}
