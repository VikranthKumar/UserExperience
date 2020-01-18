//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUIX

public enum SystemViewWeight {
    case none
    case light
    case regular
    case heavy
}

// MARK: - Helpers -

extension FeedbackGenerator.ImpactFeedbackStyle {
    public init?(for weight: SystemViewWeight) {
        switch weight {
            case .none:
                return nil
            case .light:
                self = .light
            case .regular:
                self = .medium
            case .heavy:
                self = .heavy
        }
    }
}

public struct SystemViewWeightEnvironmentKey: EnvironmentKey {
    public static var defaultValue: SystemViewWeight {
        return .regular
    }
}

extension EnvironmentValues {
    public var weight: SystemViewWeight {
        self[SystemViewWeightEnvironmentKey.self]
    }
}
