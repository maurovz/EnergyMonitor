import Foundation
import EnergyDataFeature

func makeHistoricData(
  buildingPower: Decimal,
  gridPower: Decimal,
  pvPower: Decimal,
  quasarsPower: Decimal,
  timeStamp: String
) -> (model: [History], json: [String: Any]) {

  let json: [String: Any] = [
    "building_active_power": buildingPower,
    "grid_active_power": gridPower,
    "pv_active_power": pvPower,
    "quasars_active_power": quasarsPower,
    "timestamp": timeStamp
  ]

  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"

  let date = formatter.date(from: timeStamp)!

  let model = History(
    buildingPower: buildingPower,
    gridPower: gridPower,
    pvPower: pvPower,
    quasarsPower: quasarsPower,
    timeStamp: date)

  return ([model], json)
}

func makeJSON(_ data: [String: Any]) -> Data {
  let root = [data]
  return try! JSONSerialization.data(withJSONObject: root)
}
