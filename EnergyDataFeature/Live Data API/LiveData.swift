public struct LiveData {
  public let solarPower: Double
  public let quasarPower: Double
  public let gridPower: Double
  public let buildingDemand: Double
  public let systemSoc: Double
  public let totalEnergy: Double
  public let currentEnergy: Double

  public init(
    solarPower: Double,
    quasarPower: Double,
    gridPower: Double,
    buildingDemand: Double,
    systemSoc: Double,
    totalEnergy: Double,
    currentEnergy: Double) {
      self.solarPower = solarPower
      self.quasarPower = quasarPower
      self.gridPower = gridPower
      self.buildingDemand = buildingDemand
      self.systemSoc = systemSoc
      self.totalEnergy = totalEnergy
      self.currentEnergy = currentEnergy
  }
}
