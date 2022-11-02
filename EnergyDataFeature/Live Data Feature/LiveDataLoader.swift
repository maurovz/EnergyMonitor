import Foundation

public protocol LiveDataLoader {
  typealias Result = Swift.Result<[LiveData], Swift.Error>

  func load(completion: @escaping (Result) -> Void)
}

