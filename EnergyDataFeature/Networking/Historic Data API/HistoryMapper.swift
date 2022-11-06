public final class HistoryMapper {
  private struct Root: Decodable {
    let buildingActivePower: Double
    let gridActivePower: Double
    let pvActivePower: Double
    let quasarsActivePower: Double
    let timestamp: String
  }

  private static func toModel(_ data: [HistoryMapper.Root]) -> [History]? {
    return data.filter { !$0.timestamp.isEmpty }.map {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"

      // Data has already been filtered to make sure the timestamp
      // string is not empty, thus we can safely force unwrap.
      let date = formatter.date(from: $0.timestamp)!

      return History(
      buildingPower: $0.buildingActivePower,
      gridPower: $0.gridActivePower,
      pvPower: $0.pvActivePower,
      quasarsPower: $0.quasarsActivePower,
      timeStamp: date) }
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
