//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

public struct IconShape: Shape {
    public init() {
        
    }
    
    public func path(in rect: CGRect) -> Path {
        return RoundedRectangle(
            cornerRadius: rect.minimumDimensionLength * 0.2237,
            style: .continuous
        ).path(in: rect)
    }
}
