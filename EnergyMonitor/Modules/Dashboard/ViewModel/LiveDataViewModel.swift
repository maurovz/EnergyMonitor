import Foundation
import EnergyDataFeature

public final class LiveDataViewModel: Identifiable, ObservableObject {
  private let liveDataLoader: LiveDataLoader

  private var liveData: LiveData?

  lazy var solarPower: String = {
    guard let liveData = liveData else { return "" }
    return "\(liveData.solarPower)"
  }()

  lazy var quasarPower: String = {
    guard let liveData = liveData else { return "" }
    return "\(liveData.quasarPower)"
  }()

  lazy var gridPower: String = {
    guard let liveData = liveData else { return "" }
    return "\(liveData.gridPower)"
  }()

  lazy var buildingDemand: String = {
    guard let liveData = liveData else { return "" }
    return "\(liveData.buildingDemand)"
  }()

  lazy var systemSoc: String = {
    guard let liveData = liveData else { return "" }
    return "\(liveData.systemSoc)"
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

  public func fetch(completion: @escaping (Bool) -> Void) {
    liveDataLoader.load {[weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let data):
        self.liveData = data

      case .failure:
        completion(false)
      }
    }
  }
}
