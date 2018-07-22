import Foundation

public enum BackendEnvironment: String {
    case live
    case development

    func getBaseUrlString() -> String {
        switch self {
        case .live:
            return "https://wellnessapp.tenlabs.io"
        case .development:
            return "https://afraid-wolverine-66.localtunnel.me"
        }
    }

    public static func current() -> BackendEnvironment {
        #if Release
            return .live
        #endif
        return .development
    }
}
