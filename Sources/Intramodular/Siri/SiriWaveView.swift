//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUIX

public struct SiriWaveView: View {
    var siriWave: SiriWave = .init(waveCount: 3, power: 0.0)
    var _colors: [Color] = [
        Color(red: (173 / 255), green: (57 / 255), blue: (76 / 255)),
        Color(red: (48 / 255), green: (220 / 255), blue: (155 / 255)),
        Color(red: (25 / 255), green: (122 / 255), blue: (255 / 255))
    ]
    var _baselineColor: Color = .white
    var _power: Double = 0.0
    
    public init() {
        
    }
    
    public var body: some View {
        ZStack {
            SiriWaveBaseline(color: _baselineColor)
            
            ForEach(0..<_colors.count, id: \.self) { i in
                SiriWaveShape(self.siriWave.waves[i])
                    .fill(self._colors[i])
                    .animation(.linear(duration: 0.3))
            }
        }
        .blendMode(.lighten)
        .drawingGroup()
    }
}

extension SiriWaveView {
    public func colors(colors: [Color]) -> Self {
        then {
            if _colors.count != colors.count {
                $0.siriWave = .init(waveCount: colors.count, power: $0._power)
            }
            
            $0._colors = colors
        }
    }
    
    public func power(power: Double) -> Self {
        then({ $0.siriWave = .init(waveCount: _colors.count, power: power) })
    }
    
    public func baselineColor(color: Color) -> Self {
        then({ $0._baselineColor = color })
    }
}
