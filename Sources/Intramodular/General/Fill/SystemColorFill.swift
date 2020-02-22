//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

public struct SystemColorFill: View {
    @Environment(\.systemFill) var systemFill
    @Environment(\.secondarySystemFill) var secondarySystemFill
    @Environment(\.tertiarySystemFill) var tertiarySystemFill
    @Environment(\.quaternarySystemFill) var quaternarySystemFill
    
    private let rank: SystemColorRank
    
    public init(rank: SystemColorRank) {
        self.rank = rank
    }
    
    public var body: some View {
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
    }
}
