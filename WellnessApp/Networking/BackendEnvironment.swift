import Foundation

public enum BackendEnvironment: String {
    case live
    case development

    func getBaseUrlString() -> String {
        switch self {
        case .live:
            return "http://wellnessapp.tenlabs.io"
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
