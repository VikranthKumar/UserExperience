//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

public struct PrimarySystemColorEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Color {
        return .primary
    }
}

public struct SecondarySystemColorEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Color {
        return .secondary
    }
}

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

public struct SystemFillEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Color {
        return .systemFill
    }
}

public struct SecondarySystemFillEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Color {
        return .secondarySystemFill
    }
}

public struct TertiarySystemFillEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Color {
        return .tertiarySystemFill
    }
}

public struct QuaternarySystemFillEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Color {
        return .quaternaryLabel
    }
}

#endif

// MARK: - Helpers -

extension EnvironmentValues {
    public var primarySystemColor: Color {
        self[PrimarySystemColorEnvironmentKey.self]
    }
    
    public var secondarySystemColor: Color {
        self[SecondarySystemColorEnvironmentKey.self]
    }
}

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

extension EnvironmentValues {
    public var systemFill: Color {
        get {
            self[SystemFillEnvironmentKey.self]
        } set {
            self[SystemFillEnvironmentKey.self] = newValue
        }
    }
    
    public var secondarySystemFill: Color {
        get {
            self[SecondarySystemFillEnvironmentKey.self]
        } set {
            self[SecondarySystemFillEnvironmentKey.self] = newValue
        }
    }
    
    public var tertiarySystemFill: Color {
        get {
            self[TertiarySystemFillEnvironmentKey.self]
        } set {
            self[TertiarySystemFillEnvironmentKey.self] = newValue
        }
    }
    
    public var quaternarySystemFill: Color {
        get {
            self[QuaternarySystemFillEnvironmentKey.self]
        } set {
            self[QuaternarySystemFillEnvironmentKey.self] = newValue
        }
    }
}

extension View {
    public func systemFill(_ fill: Color) -> some View {
        environment(\.systemFill, fill)
    }
    
    public func secondarySystemFill(_ fill: Color) -> some View {
        environment(\.secondarySystemFill, fill)
    }
    
    public func tertiarySystemFill(_ fill: Color) -> some View {
        environment(\.tertiarySystemFill, fill)
    }

    public func quaternarySystemFill(_ fill: Color) -> some View {
        environment(\.quaternarySystemFill, fill)
    }
}

#endif
