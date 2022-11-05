import Foundation
import EnergyDataFeature

public struct ErrorType: Identifiable {
  public let id = UUID()
  public let error: EnergyDataError

  public var errorDescription: String? {
    switch error {
    case .decodeError:
      return Constants.decodingError
    case .networkError:
      return Constants.networkError
    case .databaseError:
      return Constants.databaseError
    }
  }

  init(error: EnergyDataError) {
    self.error = error
  }
}
