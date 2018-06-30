import Foundation

public enum BackendEnvironment: String {
    case live
    case development

    func getBaseUrlString() -> String {
        switch self {
        case .live:
            return "https://api.healthapp.tenlabs.io"
        case .development:
            return "http://localhost:3000"
        }
    }

    public static func current() -> BackendEnvironment {
        #if Release
            return .live
        #endif
        return .development
    }
}
