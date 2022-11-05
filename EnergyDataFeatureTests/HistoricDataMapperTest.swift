import XCTest
import EnergyDataFeature

class HistoricDataMapperTest: XCTestCase {
  func test_map_throwsErrorWithInvalidJSON() throws {
    let invalidJSON = Data("invalid json".utf8)

    XCTAssertThrowsError(try HistoryMapper.map(data: invalidJSON))
  }

  func test_map_deliversHistoricDataWithValidJSON() throws {
    let value = makeHistoricData(
      buildingPower: 300,
      gridPower: 200,
      pvPower: 30,
      quasarsPower: 70,
      timeStamp: "2021-09-27T16:06:00+00:00")

    let result = try HistoryMapper.map(data: makeJSON(value.json))

    XCTAssertEqual(result, value.model)
  }
}
