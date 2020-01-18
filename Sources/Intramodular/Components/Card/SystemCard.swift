//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

public struct SystemCard<Content: View>: View {
    @Environment(\.quaternarySystemFill) var quaternarySystemFill
    
    public let content: Content
    
    public init(content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding()
            .background(self.quaternarySystemFill)
            .systemCornerRadius()
    }
}

#endif
