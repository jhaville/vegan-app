import Foundation

public enum BackendEnvironment: String {
    case live
    case development

    func getBaseUrlString() -> String {
        switch self {
        case .live:
            return "http://wellnessapp.tenlabs.io"
        case .development:
            return "https://old-turtle-23.localtunnel.me"
        }
    }

    public static func current() -> BackendEnvironment {
        #if Release
            return .live
        #endif
        return .development
    }
}
