//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

/// A button whose primary action can be modified even after construction.
public struct SystemIconButton: opaque_ActionButton, ActionTriggerView {
    private let name: SanFranciscoSymbolName
    private var action: () -> Void
    
    public init(
        name: SanFranciscoSymbolName,
        action: @escaping () -> ()
    ) {
        self.name = name
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            SystemIcon(name: name)
        }
    }
    
    public func onPrimaryTrigger(perform action: @escaping () -> ()) -> Self {
        then({ $0.action = { self.action(); action() } })
    }
}
