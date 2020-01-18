//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

public struct ForegroundColorEnvironmentKeys {
    public struct Primary: EnvironmentKey {
        public static var defaultValue: Color = .primary
    }
    
    public struct Secondary: EnvironmentKey {
        public static var defaultValue: Color = .secondary
    }
    
    public struct Action: EnvironmentKey {
        public static var defaultValue: Color = .primary
    }
}

extension EnvironmentValues {
    public var primaryForegroundColor: Color {
        get {
            self[ForegroundColorEnvironmentKeys.Primary]
        } set {
            self[ForegroundColorEnvironmentKeys.Primary] = newValue
        }
    }
    
    public var secondaryForegroundColor: Color {
        get {
            self[ForegroundColorEnvironmentKeys.Secondary]
        } set {
            self[ForegroundColorEnvironmentKeys.Secondary] = newValue
        }
    }
    
    public var actionForegroundColor: Color {
        get {
            self[ForegroundColorEnvironmentKeys.Action]
        } set {
            self[ForegroundColorEnvironmentKeys.Action] = newValue
        }
    }
}

extension View {
    public func primaryForegroundColor(_ color: Color) -> some View {
        environment(\.primaryForegroundColor, color)
    }
    
    public func secondaryForegroundColor(_ color: Color) -> some View {
        environment(\.secondaryForegroundColor, color)
    }
    
    public func actionForegroundColor(_ color: Color) -> some View {
        environment(\.actionForegroundColor, color)
    }
}
