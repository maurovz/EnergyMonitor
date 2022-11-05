import XCTest
import EnergyDataFeature

class LoadHistoricDataFromRemoteUseCaseTests: XCTestCase {
  func test_init_doesNotRequestURL() {
    let (_, client) = makeSUT()

    XCTAssertEqual(client.requestedURLs, [], "Client should not request url on init")
  }

  func test_load_requestsDataFromURL() {
    let url = URL(string: "http://any-url.com")!
    let (sut, client) = makeSUT(with: url)

    sut.load { _ in }

    XCTAssertEqual(client.requestedURLs, [url])
  }

  func test_load_deliversErrorOnClientError() {
    let (sut, client) = makeSUT()
    let clientError = EnergyDataError.networkError

    expect(sut, completesWith: .failure(clientError), when: {
      client.complete(with: clientError)
    })
  }

  func test_load_deliversInvalidDataErrorOnSuccessfulRespondeWithInvalidData() {
    let (sut, client) = makeSUT()

    expect(sut, completesWith: .failure(.decodeError), when: {
      client.complete(withStatusCode: 200, data: Data("invalid json".utf8))
    })
  }

  func test_load_deliversHistoricDataOnClientSuccessfulResponse() {
    let (sut, client) = makeSUT()
    let value = makeHistoricData(
      buildingPower: 300,
      gridPower: 200,
      pvPower: 30,
      quasarsPower: 70,
      timeStamp: "2021-09-27T16:06:00+00:00")

    expect(sut, completesWith: .success(value.model), when: {
      let json = makeArrayJSON(value.json)
      client.complete(withStatusCode: 200, data: json)
    })
  }

  // MARK: - Helpers

  private func makeSUT(with url: URL = URL(string: "http://any-url.com")!,
                       file: StaticString = #file,
                       line: UInt = #line) -> (sut: RemoteHistoricDataLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let cache = CoreDataServices()
    _ = cache.deleteEntityFromCoreData(entity: "HistoryEntity")

    let sut = RemoteHistoricDataLoader(url: url, client: client, cache: cache)

    return (sut, client)
  }

  private func expect(_ sut: RemoteHistoricDataLoader,
                      completesWith expectedResult: RemoteHistoricDataLoader.Result,
                      when action: () -> Void) {
    let exp = expectation(description: "Wait for completion")

    sut.load { receivedResult in
      switch (receivedResult, expectedResult) {
      case let (.success(receivedItem), .success(expectedItem)):
        XCTAssertEqual(receivedItem, expectedItem)

      case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
        XCTAssertEqual(receivedError, expectedError)

      default:
        XCTFail("Expected result \(expectedResult) got \(receivedResult) instead")
      }

      exp.fulfill()
    }

    action()

    wait(for: [exp], timeout: 0.1)
  }
}
