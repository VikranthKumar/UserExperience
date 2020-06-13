//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

public struct SystemButtonStyle: ButtonStyle {
    @usableFromInline
    let tintColor: Color?
    
    @inlinable
    public init(tintColor: Color? = nil) {
        self.tintColor = tintColor
    }
    
    @inlinable
    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            Spacer()
            configuration.label.font(.headline)
            Spacer()
        }
        .contentShape(Rectangle())
        .background(tintColor ?? Color.secondarySystemFill)
        .frame(minHeight: 44, idealHeight: 52)
        .clipShape(SystemRoundedShape())
    }
}
