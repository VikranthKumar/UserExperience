//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

public struct DragHandle: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 2, style: .continuous)
            .frame(width: 50, height: 4, alignment: .center)
            .foregroundColor(.primary)
            .opacity(verticalSizeClass == .compact ? 0 : 1)
}
