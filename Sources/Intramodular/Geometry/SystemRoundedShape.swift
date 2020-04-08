//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

public struct SystemRoundedShape: Shape {
    public func path(in rect: CGRect) -> Path {
        RoundedRectangle(
            cornerRadius: 13,
            style: .continuous
        ).path(in: rect)
    }
}
