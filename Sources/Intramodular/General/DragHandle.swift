//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

public struct DragHandle: View {
    #if os(iOS)
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    #endif
    
    public var body: some View {
        Group {
            #if os(iOS)
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .frame(width: 50, height: 4, alignment: .center)
                .foregroundColor(.primary)
                .opacity(verticalSizeClass == .compact ? 0 : 1)
            #else
            EmptyView()
            #endif
        }
    }
}
