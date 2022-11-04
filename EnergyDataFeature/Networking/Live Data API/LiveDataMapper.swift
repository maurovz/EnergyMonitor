public final class LiveDataMapper {
  public enum Error: Swift.Error {
    case invalidData
  }

  private struct Root: Decodable {
    let solarPower: Double
    let quasarsPower: Double
    let gridPower: Double
    let buildingDemand: Double
    let systemSoc: Double
    let totalEnergy: Double
    let currentEnergy: Double

    var toModel: LiveData? {
      return LiveData(
        solarPower: solarPower,
        quasarPower: quasarsPower,
        gridPower: gridPower,
        buildingDemand: buildingDemand,
        systemSoc: systemSoc,
        totalEnergy: totalEnergy,
        currentEnergy: currentEnergy)
    }
  }

  public static func map(data: Data) throws -> LiveData {
    do {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase

      let root = try decoder.decode(Root.self, from: data)
      guard let mappedLiveData = root.toModel else {
        throw Error.invalidData
      }

      return mappedLiveData

    } catch {
      throw error
    }
  }
}
