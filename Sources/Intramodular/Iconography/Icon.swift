//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUIX

public struct Icon: View {
    @Environment(\.iconScale) var iconScale
    @Environment(\.tintColor) var tintColor

    public let name: SanFranciscoSymbolName
    
    public init(_ name: SanFranciscoSymbolName) {
        self.name = name
    }
    
    public var body: some View {
        Image(systemName: name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: iconScale.size.width * 0.64, height: iconScale.size.height * 0.64)
            .frame(iconScale.size)
            .background(tintColor)
            .clipShape(IconShape())
    }
}
