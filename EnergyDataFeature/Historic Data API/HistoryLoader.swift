import Foundation

public protocol HistoryLoader {
  typealias Result = Swift.Result<[History], EnergyDataError>

  func load(completion: @escaping (Result) -> Void)
}
