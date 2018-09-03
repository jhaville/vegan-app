import Foundation

enum BackendEnvironment: String {
  case live
  case development
  
  func getBaseUrlString() -> String {
    switch self {
    case .live:
      return "https://wellnessapp.tenlabs.io"
    case .development:
      return "http://localhost:3000"
    }
  }
  
  static func current() -> BackendEnvironment {
    #if Release
      return .live
    #endif
    return .development
  }
}
