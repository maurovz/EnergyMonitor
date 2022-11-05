import Foundation

enum AppError: Error, LocalizedError {
  case decodeError
  case networkError
  case databaseError

  var errorDescription: String? {
    switch self {
    case .decodeError:
      return Constants.decodingError
    case .networkError:
      return Constants.networkError
    case .databaseError:
      return Constants.databaseError
    }
  }
}

struct ErrorType: Identifiable {
  let id = UUID()
  let error: AppError
}
