import Foundation
import EnergyDataFeature

func makeHistoricData(
  buildingPower: Double,
  gridPower: Double,
  pvPower: Double,
  quasarsPower: Double,
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

// swiftlint:disable function_parameter_count
func makeLiveData(
  solarPower: Double,
  quasarPower: Double,
  gridPower: Double,
  buildingDemand: Double,
  systemSoc: Double,
  totalEnergy: Double,
  currentEnergy: Double
) -> (model: LiveData, json: [String: Any]) {

  let json: [String: Any] = [
    "solar_power": solarPower,
    "quasars_power": quasarPower,
    "grid_power": gridPower,
    "building_demand": buildingDemand,
    "system_soc": systemSoc,
    "total_energy": totalEnergy,
    "current_energy": currentEnergy
  ]

  let model = LiveData(
    solarPower: solarPower,
    quasarPower: quasarPower,
    gridPower: gridPower,
    buildingDemand: buildingDemand,
    systemSoc: systemSoc,
    totalEnergy: totalEnergy,
    currentEnergy: currentEnergy)

  return (model, json)
}

// swiftlint:disable force_try
func makeArrayJSON(_ data: [String: Any]) -> Data {
  try! JSONSerialization.data(withJSONObject: [data])
}

func makeJSON(_ data: [String: Any]) -> Data {
  try! JSONSerialization.data(withJSONObject: data)
}
