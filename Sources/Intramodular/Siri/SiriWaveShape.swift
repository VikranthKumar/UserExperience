//
// Copyright (c) Vatsal Manot
//

import SwiftUI

struct SiriWaveShape: Shape {
    var wave: SiriWave.Wave
    
    var animatableData: SiriWave.Wave.AnimatableData {
        get {
            return wave.animatableData
        } set {
            wave.animatableData = newValue
        }
    }
    
    init(_ wave: SiriWave.Wave) {
        self.wave = wave
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var points = [CGPoint]()
        let origin = CGPoint(x: 0, y: rect.midY)
        
        let xPoints = Array(stride(from: -rect.midX, to: rect.midX, by: 1.0))
        var coordinates = [[Double]](repeating: [0.0, 0.0], count: xPoints.count)
        
        for i in 0..<self.wave.useCurves {
            let A = wave.curves[i].A * Double(rect.midY) * wave.power
            var j = 0
            
            for graphX in xPoints {
                let graphScaledX = graphX / (rect.midX / 9.0)
                let x = rect.midX + graphX
                let y = attn(x: Double(graphScaledX), A: A, k: wave.curves[i].k, t: wave.curves[i].t) + Double(origin.y)
                
                coordinates[j] = [Double(x), max(coordinates[j][1], y)]
                
                j += 1
            }
        }
        
        coordinates += coordinates.map { coord -> [Double] in
            [coord[0], ((coord[1] - Double(rect.midY)) * -1) + Double(rect.midY)]
        }
        
        for coord in coordinates {
            points.append(CGPoint(x: coord[0], y: coord[1]))
        }
        
        path.move(to: origin)
        path.addLines(points)
        
        return path
    }
}

extension SiriWaveShape {
    private func sine(x: Double, A: Double, k: Double, t: Double) -> Double {
        return A * sin((k * x) - t)
    }
    
    private func g(x: Double, t: Double, K: Double, k: Double) -> Double {
        return pow(K / (K + pow((k * x) - t, 2)), K)
    }
    
    private func attn(x: Double, A: Double, k: Double, t: Double) -> Double {
        return abs(sine(x: x, A: A, k: k, t: t) * g(x: x, t: t - (Double.pi / 2), K: 4, k: k))
    }
}
