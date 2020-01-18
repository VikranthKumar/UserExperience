//
// Copyright (c) Vatsal Manot
//

import Combine
import Swift
import SwiftUIX

public struct SystemIcon: View {
    @Environment(\.imageScale) var imageScale
    
    private let name: SanFranciscoSymbolName
    
    public init(name: SanFranciscoSymbolName) {
        self.name = name
    }
    
    public var body: some View {
        IntrinsicGeometryReader { geometry in
            Image(systemName: self.name)
                .imageScale(self.imageScale)
                .frame(
                    minWidth: geometry.frame?.maximumDimensionLength,
                    minHeight: geometry.frame?.maximumDimensionLength
            )
                .background(Color.clear)
                .contentShape(Rectangle())
        }
    }
}

// MARK: - Helpers -

extension Image.Scale {
    fileprivate var systemHitArea: CGSize {
        switch self {
            case .small:
                return .init(width: 16, height: 16)
            case .medium:
                return .init(width: 22, height: 22)
            case .large:
                return .init(width: 44, height: 44)
            default:
                return .init(width: 44, height: 44)
        }
    }
}
