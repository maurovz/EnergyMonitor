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
          completion(.failure(LiveDataMapper.Error.invalidData))
          return
        }

        self.setCache(data: mappedLiveData)
        completion(.success(mappedLiveData))

      case .failure(let error):
//        let cacheHistory = self.cache.loadLiveDataFromCoreData()
//        guard !cacheHistory.isEmpty else {
          completion(.failure(error))
//          return
//        }
//
//        completion(.success(cacheHistory))
      }
    }
  }

  private func setCache(data: LiveData) {
//    cache.deleteHistoryEntityFromCoreData()
//    cache.saveHistoricDataToCache(data: data)
  }
}
