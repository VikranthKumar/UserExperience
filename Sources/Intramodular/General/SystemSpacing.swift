//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

extension ContentSizeCategory {
    public var systemPaddingLength: CGFloat {
        switch self {
            case .extraSmall:
                return 4
            case .small:
                return 8
            case .medium:
                return 16
            case .large:
                return 22
            case .extraLarge:
                return 44
            case .extraExtraLarge:
                return 88
            case .extraExtraExtraLarge:
                return 88
            case .accessibilityMedium:
                return Self.medium.systemPaddingLength
            case .accessibilityLarge:
                return Self.large.systemPaddingLength
            case .accessibilityExtraLarge:
                return Self.extraLarge.systemPaddingLength
            case .accessibilityExtraExtraLarge:
                return Self.extraExtraLarge.systemPaddingLength
            case .accessibilityExtraExtraExtraLarge:
                return Self.extraExtraExtraLarge.systemPaddingLength
            @unknown default:
                return 16
        }
    }
}

extension View {
    @inlinable
    public func padding(for category: ContentSizeCategory) -> some View {
        padding(category.systemPaddingLength)
    }
    
    @inlinable
    public func padding(_ edges: Edge.Set = .all, for category: ContentSizeCategory) -> some View {
        padding(edges, category.systemPaddingLength)
    }
}
