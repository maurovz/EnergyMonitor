import Foundation
import EnergyDataFeature

public final class LiveDataViewModel: Identifiable, ObservableObject {
  private let liveDataLoader: LiveDataLoader

  private var liveData: LiveData?

  lazy var solarPower: String = {
    guard let liveData = liveData else { return "" }
    return "\(String(format: "%.2f", liveData.solarPower))"
  }()

  lazy var quasarPower: String = {
    guard let liveData = liveData else { return "" }
    return "\(String(format: "%.2f", abs(liveData.quasarPower)))"
  }()

  lazy var gridPower: String = {
    guard let liveData = liveData else { return "" }
    return "\(String(format: "%.2f", liveData.gridPower))"
  }()

  lazy var buildingDemand: String = {
    guard let liveData = liveData else { return "" }
    return "\(String(format: "%.2f", liveData.buildingDemand))"
  }()

  lazy var solarPowerPercent: String = {
    guard let liveData = liveData else { return "" }

    let totalPower = liveData.solarPower / liveData.buildingDemand * 100
    return "\(String(format: "%.2f", totalPower))"
  }()
//
  lazy var quasarPowerPercent: String = {
    guard let liveData = liveData else { return "" }

    let totalPower = abs(liveData.quasarPower) / liveData.buildingDemand * 100
    return "\(String(format: "%.2f", totalPower))"
  }()

  lazy var gridPowerPercent: String = {
    guard let liveData = liveData else { return "" }

    let totalPower = liveData.gridPower / liveData.buildingDemand * 100
    return "\(String(format: "%.2f", totalPower))"
  }()

  lazy var systemSoc: String = {
    guard let liveData = liveData else { return "" }
    return "\(String(format: "%.2f", liveData.systemSoc))"
  }()

  lazy var totalEnergy: String = {
    guard let liveData = liveData else { return "" }
    return "\(liveData.totalEnergy)"
  }()

  lazy var currentEnergy: String = {
    guard let liveData = liveData else { return "" }
    return "\(liveData.currentEnergy)"
  }()

  public init(liveDataLoader: LiveDataLoader) {
    self.liveDataLoader = liveDataLoader
  }

  public func fetch(completion: @escaping (Result<LiveData, EnergyDataError>) -> Void) {
    liveDataLoader.load {[weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let data):
        self.liveData = data
        completion(result)

      case .failure:
        completion(result)
      }
    }
  }
}
