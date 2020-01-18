//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

open class ContextualErrorsPreferenceKey: PreferenceKey {
    public typealias Value = ContextualErrors
    
    public static var defaultValue: Value {
        return .init()
    }
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value.value.append(contentsOf: nextValue().value)
    }
}

public final class ContextualErrorsEnvironmentKey: EnvironmentKey {
    public static let defaultValue: ContextualErrors = .init([])
}

public struct ContextualErrors: Equatable {
    public var value: [Error]
    
    public init(_ value: [Error]) {
        self.value = value
    }
    
    public init() {
        self.init([])
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.value.count != rhs.value.count {
            return false
        }
        
        for index in 0..<lhs.value.count {
            if String(describing: lhs.value[index]) != String(describing: rhs.value[index]) {
                return false
            }
        }
        
        return true
    }
}

extension EnvironmentValues {
    public var contextualErrors: ContextualErrors {
        get {
            self[ContextualErrorsEnvironmentKey]
        } set {
            self[ContextualErrorsEnvironmentKey] = newValue
        }
    }
}

public struct ErrorContextView<Content: View>: View {
    private let content: Content
    
    @State var errors = ContextualErrors()
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content.onPreferenceChange(ContextualErrorsPreferenceKey.self) {
            self.errors = $0
        }
        .preference(key: ContextualErrorsPreferenceKey.self, value: .init())
        .environment(\.contextualErrors, errors)
    }
}

extension View {
    public func addErrorContext() -> ErrorContextView<Self> {
        .init {
            self
        }
    }
}

public struct TryButton<Label: View>: View {
    private let action: () throws -> ()
    private let label: Label
    
    @State var error: Error?
    
    public init(action: @escaping () throws -> Void, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        Button(action: trigger) {
            label
        }
        .preference(
            key: ContextualErrorsPreferenceKey.self,
            value: error.map({ .init([$0]) }) ?? .init()
        )
    }
    
    public func trigger() {
        error = nil
        
        do {
            try action()
        } catch {
            self.error = error
        }
    }
}
