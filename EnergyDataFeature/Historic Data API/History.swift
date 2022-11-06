public struct History: Equatable {
  public let buildingPower: Double
  public let gridPower: Double
  public let pvPower: Double
  public let quasarsPower: Double
  public let timeStamp: Date

  public init(
    buildingPower: Double,
    gridPower: Double,
    pvPower: Double,
    quasarsPower: Double,
    timeStamp: Date) {
      self.buildingPower = buildingPower
      self.gridPower = gridPower
      self.pvPower = pvPower
      self.quasarsPower = quasarsPower
      self.timeStamp = timeStamp
    }
}
