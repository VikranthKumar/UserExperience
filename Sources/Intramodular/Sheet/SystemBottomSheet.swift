//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

public struct SystemBottomSheet<Content: View>: View {
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content.padding().background(
            SystemFill()
                .cornerRadius([.topLeft, .topRight], .defaultSystemCornerRadius)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

extension DynamicViewPresenter {
    public func presentSystemBottomSheet<Content: View>(
        @ViewBuilder content: () -> Content
    ) {
        presentOnTop(
            SystemBottomSheet {
                content()
            },
            presentationStyle: .align(source: .bottom)
        )
    }
}
