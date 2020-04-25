//
// Copyright (c) Vatsal Manot
//

import SwiftUI
import Swift

public enum IconScale: Hashable {
    case app
    case spotlight
    case settings
    case notification
    
    var size: CGSize {
        switch self {
            case .app:
                return .init(width: 60, height: 60)
            case .spotlight:
                return .init(width: 40, height: 40)
            case .settings:
                return .init(width: 29, height: 29)
            case .notification:
                return .init(width: 20, height: 20)
        }
    }
}

// MARK: - API -

extension View {
    public func iconScale(_ iconScale: IconScale) -> some View {
        environment(\.iconScale, iconScale)
    }
}

// MARK: - Auxiliary Implementation -

extension IconScale {
    fileprivate struct EnvironmentKey: SwiftUI.EnvironmentKey {
        static let defaultValue: IconScale = .app
    }
}

extension EnvironmentValues {
    public var iconScale: IconScale {
        get {
            self[IconScale.EnvironmentKey]
        } set {
            self[IconScale.EnvironmentKey] = newValue
        }
    }
}
