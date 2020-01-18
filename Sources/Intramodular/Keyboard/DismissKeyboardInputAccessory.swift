//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

public struct DismissKeyboardInputAccessory: View {
    @Environment(\.actionForegroundColor) var actionForegroundColor
    
    public let action: () -> ()
    
    public init(action: @escaping () -> () = { }) {
        self.action = action
    }
    
    public var body: some View {
        HStack {
            Spacer()
            
            Button(action: trigger) {
                Image(systemName: .arrowRightCircleFill)
                    .font(.largeTitle)
                    .foregroundColor(actionForegroundColor)
            }
        }
        .padding()
    }
    
    public func trigger() {
        Keyboard.main.dismiss()
        
        action()
    }
}

