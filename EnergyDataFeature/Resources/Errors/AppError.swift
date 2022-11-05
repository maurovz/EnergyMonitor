import Foundation

public enum EnergyDataError: Error, LocalizedError {
  case decodeError
  case networkError
  case databaseError
}
