//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

public struct SystemFill: View {
    public var body: some View {
        GeometryReader { geometry in
            if geometry.size.minimumDimensionLength < 1 {
                Color.systemFill
            } else {
                Color.systemFill
            }
        }
    }
}
