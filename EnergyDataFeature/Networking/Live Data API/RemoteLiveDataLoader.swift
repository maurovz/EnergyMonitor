import Foundation

public final class RemoteLiveDataLoader: LiveDataLoader {
  private let url: URL
  private let client: HTTPClient
  private let cache: CoreDataServices

  public init(url: URL, client: HTTPClient, cache: CoreDataServices) {
    self.url = url
    self.client = client
    self.cache = cache
  }

  public typealias Result = LiveDataLoader.Result

  public func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { result in
      switch result {
      case .success((let data, _)):
        guard let mappedLiveData = try? LiveDataMapper.map(data: data) else {
          completion(.failure(EnergyDataError.decodeError))
          return
        }

        self.setCache(data: mappedLiveData)
        completion(.success(mappedLiveData))

      case .failure:
        let cachedLiveData = self.cache.loadLiveDataFromCoreData()
        guard let liveData = cachedLiveData else {
        completion(.failure(.networkError))
          return
        }

        completion(.success(liveData))
      }
    }
  }

  private func setCache(data: LiveData) {
    cache.deleteHistoryEntityFromCoreData()
    cache.saveLiveDataToCache(data: data)
  }
}
