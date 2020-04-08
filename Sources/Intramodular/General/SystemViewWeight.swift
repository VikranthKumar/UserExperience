//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUIX

/// The user-perceptible weight of a view.
public enum SystemViewWeight {
    case none
    case light
    case regular
    case heavy
    
    init() {
        self = .regular
    }
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

// MARK: - Environment -

private struct SystemViewWeightEnvironmentKey: EnvironmentKey {
    static let defaultValue: SystemViewWeight = .regular
}

extension EnvironmentValues {
    public var weight: SystemViewWeight {
        self[SystemViewWeightEnvironmentKey.self]
    }
}
