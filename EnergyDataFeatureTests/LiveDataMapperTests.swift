import XCTest
import EnergyDataFeature

class LiveDataMapperTests: XCTestCase {
  func test_map_throwsErrorWithInvalidJSON() throws {
    let invalidJSON = Data("invalid json".utf8)

    XCTAssertThrowsError(try LiveDataMapper.map(data: invalidJSON))
  }

  func test_map_deliversLiveDataWithValidJSON() throws {
    let value = makeLiveData(
      solarPower: 30,
      quasarPower: 80,
      gridPower: 90,
      buildingDemand: 200,
      systemSoc: 300,
      totalEnergy: 400,
      currentEnergy: 300)

    let result = try LiveDataMapper.map(data: makeJSON(value.json))

    XCTAssertEqual(result, value.model)
  }
}
