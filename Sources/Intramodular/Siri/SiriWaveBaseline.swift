//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUIX

struct SiriWaveBaseline: View {
    var color: Color!
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let centerY = geometry.size.height / 2.0
                
                path.move(to: CGPoint(x: 0, y: centerY))
                path.addLines([
                    CGPoint(x: 0, y: centerY),
                    CGPoint(x: geometry.size.width, y: centerY)
                ])
            }
            .stroke(self.color, lineWidth: 2)
            .opacity(0.5)
        }
    }
}
