//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

public struct SystemRoundedRectangle: Shape {
    public init() {
        
    }
    
    public func path(in rect: CGRect) -> Path {
        RoundedRectangle(
            cornerRadius: rect.minimumDimensionLength * (10 / 57),
            style: .continuous
        ).path(in: rect)
    }
}

public struct SystemCornerRadiusModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content.clipShape(SystemRoundedRectangle())
    }
}

// MARK: - Helpers -

extension View {
    public func systemCornerRadius() -> some View {
        modifier(SystemCornerRadiusModifier())
    }
}
