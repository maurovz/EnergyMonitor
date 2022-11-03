public final class LiveDataMapper {
  public enum Error: Swift.Error {
    case invalidData
  }

  private struct Root: Decodable {
    let solarPower: Decimal
    let quasarPower: Decimal
    let gridPower: Decimal
    let buildingDemand: Decimal
    let systemSoc: Decimal
    let totalEnergy: Decimal
    let currentEnergy: Decimal

    var toModel: LiveData? {
      return LiveData(
        solarPower: solarPower,
        quasarPower: quasarPower,
        gridPower: gridPower,
        buildingDemand: buildingDemand,
        systemSoc: systemSoc,
        totalEnergy: totalEnergy,
        currentEnergy: currentEnergy)
    }
  }

  public static func map(data: Data) throws -> LiveData {
    do {
      let root = try JSONDecoder().decode(Root.self, from: data)
      guard let mappedLiveData = root.toModel else {
        throw Error.invalidData
      }

      return mappedLiveData

    } catch {
      throw error
    }
  }
}
