public final class HistoryMapper {
  public enum Error: Swift.Error {
    case invalidData
  }

  private struct Root: Decodable {
    private let building_active_power: Decimal
    private let grid_active_power: Decimal
    private let pv_active_power: Decimal
    private let quasars_active_power: Decimal
    private let timestamp: String
  }

  private static func toModel(_ data: [HistoryMapper.Root]) -> [History]? {
    return nil
  }

  public static func map(data: Data) throws -> [History] {
    do {
      let root = try JSONDecoder().decode([Root].self, from: data)
      guard let mappedHistory = toModel(root) else {
        throw Error.invalidData
      }

      return mappedHistory

    } catch {
      throw error
    }
  }
}
