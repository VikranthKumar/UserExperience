//
// Copyright (c) Vatsal Manot
//

import Merge
import Foundation
import SwiftUIX

public struct URLRemoteImage: ViewModifier {
    let url: URL
    let cacheInUserDefaults: Bool
    
    @State var image: Image?
    
    var userDefaultsKey: String {
        "URLImageLoader.\(self.url.absoluteString)"
    }
    
    public init(url: URL, cacheInUserDefaults: Bool) {
        self.url = url
        self.cacheInUserDefaults = cacheInUserDefaults
    }
    
    public func body(content: Content) -> some View {
        image.ifSome { image in
            image.resizable()
        }.else {
            content.onReceive(
                URLSession.shared
                    .dataTaskPublisher(for: url)
                    .receiveOnMainQueue()
                    .toResultPublisher()
            ) { result in
                if case let .success(value) = result {
                    self.image = Image(data: value.data)
                    
                    UserDefaults.standard.set(value.data, forKey: self.userDefaultsKey)
                }
            }.onAppear {
                if let data = UserDefaults.standard.data(forKey: self.userDefaultsKey) {
                    self.image = Image(data: data)
                }
            }
        }
    }
}

// MARK: - Helpers -

extension View {
    public func remoteImage(
        from url: URL,
        cacheInUserDefaults: Bool = true
    ) -> some View {
        modifier(URLRemoteImage(url: url, cacheInUserDefaults: cacheInUserDefaults))
    }
}
