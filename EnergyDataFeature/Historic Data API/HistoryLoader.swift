import Foundation

public protocol HistoryLoader {
  typealias Result = Swift.Result<[History], Swift.Error>

  func load(completion: @escaping (Result) -> Void)
}
