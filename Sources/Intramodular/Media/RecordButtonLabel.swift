//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

public struct RecordButtonLabel: View {
    public let isActive: Bool
    
    public init(isActive: Bool) {
        self.isActive = isActive
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 64 / 2)
                .stroke(Color.primary, lineWidth: 2)
            
            Rectangle()
                .fill(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: isActive ? 4 : 28, style: .continuous))
                .frame(width: isActive ? 28 : 56, height: isActive ? 28 : 56)
                .animation(.spring())
        }
        .frame(width: 64, height: 64)
    }
}
