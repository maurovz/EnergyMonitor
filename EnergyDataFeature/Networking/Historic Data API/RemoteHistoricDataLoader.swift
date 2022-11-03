import Foundation

public final class RemoteHistoricDataLoader: HistoryLoader {
  private let url: URL
  private let client: HTTPClient
  private let cache: CoreDataServices

  public init(url: URL, client: HTTPClient, cache: CoreDataServices) {
    self.url = url
    self.client = client
    self.cache = cache
  }

  public typealias Result = HistoryLoader.Result

  public func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { result in
      switch result {
      case .success((let data, _)):
        guard let mappedHistory = try? HistoryMapper.map(data: data) else {
          completion(.failure(HistoryMapper.Error.invalidData))
          return
        }

        self.setCache(data: mappedHistory)
        completion(.success(mappedHistory))

      case .failure(let error):
        let cacheHistory = self.cache.loadHistoricDataFromCoreData()
        guard !cacheHistory.isEmpty else {
          completion(.failure(error))
          return
        }

        completion(.success(cacheHistory))
      }
    }
  }

  private func setCache(data: [History]) {
//    cache.deleteHistoryEntityFromCoreData()
//    cache.saveHistoricDataToCache(data: data)
  }
}
