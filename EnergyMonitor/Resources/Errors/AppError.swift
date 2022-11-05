import Foundation

enum AppError: Error, LocalizedError {
  case decodeError
  case networkError
  case databaseError

  var errorDescription: String? {
    switch self {
    case .decodeError:
      return LocalizedConstants.decodingError
    case .networkError:
      return LocalizedConstants.networkError
    case .databaseError:
      return LocalizedConstants.databaseError
    }
  }
}

struct ErrorType: Identifiable {
  let id = UUID()
  let error: AppError
}
