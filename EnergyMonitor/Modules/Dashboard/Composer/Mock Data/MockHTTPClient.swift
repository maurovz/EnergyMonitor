import EnergyDataFeature

/**
In order to mock the JSON response without modifying the
EnergyDataFeature's  networking infra, we'll inject a MockHTTPClient
Similarly as it's done in the Unit Tests
 */
final class MockHTTPClient: HTTPClient {
  let filePath: String

  init(filePath: String) {
    self.filePath = filePath
  }

  private struct Task: HTTPClientTask {
    let callback: () -> Void
    func cancel() { callback() }
  }

  private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
  private(set) var cancelledURLs = [URL]()

  func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
    let fileData = LocalFiles.loadJSON(path: filePath)

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
  static func loadJSON(path: String) -> Data? {
    guard
      let url = Bundle.main.url(forResource: path, withExtension: "json"),
      let data = try? Data(contentsOf: url)
    else {
      return nil
    }

    return data
  }
}
