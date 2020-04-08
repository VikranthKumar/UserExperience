//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

public struct SystemIconShape: Shape {
    public init() {
        
    }
    
    public func path(in rect: CGRect) -> Path {
        RoundedRectangle(
            cornerRadius: rect.minimumDimensionLength * (10 / 57),
            style: .continuous
        ).path(in: rect)
    }
}

// MARK: - API -

extension View {
    public func clipSystemIconShape() -> some View {
        clipShape(SystemIconShape())
    }
}
