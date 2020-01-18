//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

public struct PrimarySubheadlineText: View {
    @Environment(\.subheadlineFont) var font
    @Environment(\.primaryForegroundColor) var foregroundColor
    
    private let content: String
    
    public init(_ content: String) {
        self.content = content
    }
    
    public var body: some View {
        Text(content)
            .font(font)
            .foregroundColor(foregroundColor)
    }
}

public struct SecondarySubheadlineText: View {
    @Environment(\.subheadlineFont) var font
    @Environment(\.secondaryForegroundColor) var foregroundColor
    
    private let content: String
    
    public init(_ content: String) {
        self.content = content
    }
    
    public var body: some View {
        Text(content)
            .font(font)
            .foregroundColor(foregroundColor)
    }
}
