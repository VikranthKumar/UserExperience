//
// Copyright (c) Vatsal Manot
//

import Merge
import SwiftUIX

#if os(iOS) || targetEnvironment(macCatalyst)

public struct SystemBottomSheetContent<Content: View>: View {
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content.padding().background(
            Color.white
                .cornerRadius([.topLeft, .topRight], .defaultSystemCornerRadius)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

extension DynamicViewPresenter {
    @_optimize(none)
    public func presentSystemBottomSheet<Content: View>(
        @ViewBuilder content: () -> Content
    ) {
        presentOnTop(
            SystemBottomSheetContent {
                content()
            },
            presentationStyle: .align(source: .bottom)
        )
    }
}

#endif
