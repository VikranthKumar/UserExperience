//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import SwiftUIX

public struct SystemRoundedLabel<Content: View>: View {
    @Environment(\.secondarySystemFill) var secondarySystemFill
    
    public let content: Content
    
    public init(content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding(forSizeCategory: .small)
            .background(self.secondarySystemFill)
            .clipSystemIconShape()
    }
}

#endif
