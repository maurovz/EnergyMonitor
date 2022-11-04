import Foundation
import EnergyDataFeature

extension Double {
    var truncate: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

public final class LiveDataViewModel: Identifiable, ObservableObject {
  private let liveDataLoader: LiveDataLoader

  private var liveData: LiveData?

  lazy var solarPower: String = {
    guard let liveData = liveData else { return "" }
    return "\(String(format: "%.2f", liveData.solarPower))"
  }()

  lazy var quasarPower: String = {
    guard let liveData = liveData else { return "" }
    return "\(String(format: "%.2f", liveData.quasarPower))"
  }()

  lazy var gridPower: String = {
    guard let liveData = liveData else { return "" }
    return "\(String(format: "%.2f", liveData.gridPower))"
  }()

  lazy var buildingDemand: String = {
    guard let liveData = liveData else { return "" }
    return "\(String(format: "%.2f", liveData.buildingDemand))"
  }()

  lazy var systemSoc: String = {
    guard let liveData = liveData else { return "" }
    return "\(String(format: "%.2f", liveData.systemSoc))"
  }()

  lazy var totalEnergy: String = {
    guard let liveData = liveData else { return "" }
    return "\(liveData.totalEnergy.truncate)"
  }()

  lazy var currentEnergy: String = {
    guard let liveData = liveData else { return "" }
    return "\(liveData.currentEnergy.truncate)"
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
