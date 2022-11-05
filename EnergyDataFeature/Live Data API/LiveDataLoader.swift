import Foundation

public protocol LiveDataLoader {
  typealias Result = Swift.Result<LiveData, EnergyDataError>

  func load(completion: @escaping (Result) -> Void)
}
