//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

public struct SystemColorFill: View {
    #if os(iOS) || targetEnvironment(macCatalyst)
    @Environment(\.systemFill) var systemFill
    @Environment(\.secondarySystemFill) var secondarySystemFill
    @Environment(\.tertiarySystemFill) var tertiarySystemFill
    @Environment(\.quaternarySystemFill) var quaternarySystemFill
    #endif
    
    private let rank: SystemColorRank
    
    public init(rank: SystemColorRank) {
        self.rank = rank
    }
    
    public var body: some View {
        #if os(iOS) || targetEnvironment(macCatalyst)
        switch rank {
            case .primary:
                return systemFill
            case .secondary:
                return secondarySystemFill
            case .tertiary:
                return tertiarySystemFill
            case .quaternary:
                return quaternarySystemFill
        }
        #else
        return EmptyView()
        #endif
    }
}
