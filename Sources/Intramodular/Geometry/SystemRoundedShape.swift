//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

public struct SystemRoundedShape: Shape {
    @inlinable
    public init() {
        
    }
    
    @inlinable
    public func path(in rect: CGRect) -> Path {
        RoundedRectangle(
            cornerRadius: 13,
            style: .continuous
        ).path(in: rect)
    }
}
