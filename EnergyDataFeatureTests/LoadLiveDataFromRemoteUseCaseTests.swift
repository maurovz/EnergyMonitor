import XCTest
import EnergyDataFeature

class LoadLiveDataFromRemoteUseCaseTests: XCTestCase {
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

  func test_load_deliversLiveDataOnClientSuccessfulResponse() {
    let (sut, client) = makeSUT()
    let value = makeLiveData(
      solarPower: 30,
      quasarPower: 80,
      gridPower: 90,
      buildingDemand: 200,
      systemSoc: 300,
      totalEnergy: 400,
      currentEnergy: 300)

    expect(sut, completesWith: .success(value.model), when: {
      let json = makeJSON(value.json)
      client.complete(withStatusCode: 200, data: json)
    })
  }

  // MARK: - Helpers

  private func makeSUT(with url: URL = URL(string: "http://any-url.com")!,
                       file: StaticString = #file,
                       line: UInt = #line) -> (sut: RemoteLiveDataLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let cache = CoreDataServices()
    _ = cache.deleteEntityFromCoreData(entity: "LiveDataEntity")

    let sut = RemoteLiveDataLoader(url: url, client: client, cache: cache)

    return (sut, client)
  }

  private func expect(_ sut: RemoteLiveDataLoader,
                      completesWith expectedResult: RemoteLiveDataLoader.Result,
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
