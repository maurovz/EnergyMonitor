public struct LiveData {
  public let solarPower: Decimal
  public let quasarPower: Decimal
  public let gridPower: Decimal
  public let buildingDemand: Decimal
  public let systemSoc: Decimal
  public let totalEnergy: Decimal
  public let currentEnergy: Decimal

  public init(
    solarPower: Decimal,
    quasarPower: Decimal,
    gridPower: Decimal,
    buildingDemand: Decimal,
    systemSoc: Decimal,
    totalEnergy: Decimal,
    currentEnergy: Decimal) {
      self.solarPower = solarPower
      self.quasarPower = quasarPower
      self.gridPower = gridPower
      self.buildingDemand = buildingDemand
      self.systemSoc = systemSoc
      self.totalEnergy = totalEnergy
      self.currentEnergy = currentEnergy
  }
}
