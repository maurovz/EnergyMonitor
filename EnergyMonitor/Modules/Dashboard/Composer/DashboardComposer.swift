import Foundation
import EnergyDataFeature

struct DashboardComposer {
  static func createModule() -> DashboardView {
    DashboardView(
      viewModel:
        DashboardViewModel(
          historyLoader: RemoteHistoricDataLoader(
            url: URL(fileURLWithPath: "data.json"),
            client: MockHTTPClient(),
            cache: CoreDataServices())))
  }
}

/**
In order to mock the JSON response without modifying the
EnergyDataFeature's  networking infra, we'll inject a HTTPClientSpy
Similarly as it's done in the Unit Tests
 */
final class MockHTTPClient: HTTPClient {
  private struct Task: HTTPClientTask {
    let callback: () -> Void
    func cancel() { callback() }
  }

  private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
  private(set) var cancelledURLs = [URL]()

  var requestedURLs: [URL] {
    return messages.map { $0.url }
  }

  func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
    let fileData = LocalFiles.loadJSON(fileName: url.path)

    guard let data = fileData else {
      return Task { [weak self] in
        self?.cancelledURLs.append(url)
      }
    }
    messages.append((url, completion))
    complete(url: url, withStatusCode: 200, data: data)

    return Task { [weak self] in
      self?.cancelledURLs.append(url)
    }
  }

  func complete(with error: Error, at index: Int = 0) {
    messages[index].completion(.failure(error))
  }

  func complete(url: URL, withStatusCode code: Int, data: Data, at index: Int = 0) {
    let response = HTTPURLResponse(
      url: url,
      statusCode: code,
      httpVersion: nil,
      headerFields: nil
    )!
    messages[index].completion(.success((data, response)))
  }
}

struct LocalFiles {
  static func loadJSON(fileName: String) -> Data? {
    guard
      let url = Bundle.main.url(forResource: "historic_data", withExtension: "json"),
      let data = try? Data(contentsOf: url)
    else {
      return nil
    }

    return data
  }
}
