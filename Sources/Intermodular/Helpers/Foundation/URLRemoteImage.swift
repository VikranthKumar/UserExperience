//
// Copyright (c) Vatsal Manot
//

import Merge
import Foundation
import SwiftUIX

public struct URLRemoteImage: ViewModifier {
    @ObservedObject var loader: URLImageLoader
    
    public init(loader: URLImageLoader) {
        self.loader = loader
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            loader.image.map({ $0.resizable() }) ?? content
        }
    }
}

// MARK: - Helpers -

extension View {
    public func remoteImage(
        from url: URL,
        cacheInUserDefaults: Bool = true
    ) -> some View {
        modifier(URLRemoteImage(
            loader: .init(
                url: url,
                cacheInUserDefaults: cacheInUserDefaults
            )
        ))
    }
}
