public struct History: Equatable {
  public let buildingPower: Decimal
  public let gridPower: Decimal
  public let pvPower: Decimal
  public let quasarsPower: Decimal
  public let timeStamp: Date

  public init(
    buildingPower: Decimal,
    gridPower: Decimal,
    pvPower: Decimal,
    quasarsPower: Decimal,
    timeStamp: Date) {
      self.buildingPower = buildingPower
      self.gridPower = gridPower
      self.pvPower = pvPower
      self.quasarsPower = quasarsPower
      self.timeStamp = timeStamp
    }
}
