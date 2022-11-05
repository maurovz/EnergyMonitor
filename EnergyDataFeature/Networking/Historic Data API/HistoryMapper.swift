public final class HistoryMapper {
  private struct Root: Decodable {
    let buildingActivePower: Decimal
    let gridActivePower: Decimal
    let pvActivePower: Decimal
    let quasarsActivePower: Decimal
    let timestamp: String
  }

  private static func toModel(_ data: [HistoryMapper.Root]) -> [History]? {
    return data.map {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"

      let date = formatter.date(from: $0.timestamp)

      return History(
      buildingPower: $0.buildingActivePower,
      gridPower: $0.gridActivePower,
      pvPower: $0.pvActivePower,
      quasarsPower: $0.quasarsActivePower,
      timeStamp: date!) }
  }

  public static func map(data: Data) throws -> [History] {
    do {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase

      let root = try decoder.decode([Root].self, from: data)
      guard let mappedHistory = toModel(root) else {
        throw EnergyDataError.decodeError
      }

      return mappedHistory

    } catch {
      throw error
    }
  }
}
