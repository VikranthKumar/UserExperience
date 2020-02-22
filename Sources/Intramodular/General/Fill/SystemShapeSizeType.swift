//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

public enum SystemShapeSizeType {
    case thinOrSmall
    case medium
    case large
    case largeAndComplex
    
    public var systemFillRank: SystemColorRank {
        switch self {
            case .thinOrSmall:
                return .primary
            case .medium:
                return .secondary
            case .large:
                return .tertiary
            case .largeAndComplex:
                return .quaternary
        }
    }
}

extension CGSize {
    public var approximateSystemShapeSizeType: SystemShapeSizeType {
        switch minimumDimensionLength {
            case 0..<44:
                return .thinOrSmall
            case 44..<72:
                return .medium
            default:
                return .large
        }
    }
}
