//
// Copyright (c) Vatsal Manot
//

import Merge
import Foundation
import SwiftUIX

public final class URLImageLoader: ObservableObject {
    let url: URL
    let cacheInUserDefaults: Bool
    
    @Published var image: Image? = nil
    
    public var objectWillChange: AnyPublisher<Image?, Never> = Publishers.Sequence<[Image?], Never>(sequence: []).eraseToAnyPublisher()
    
    var cancellable: AnyCancellable? = nil
    
    public var userDefaultsKey: String {
        return "URLImageLoader.\(url.absoluteString)"
    }
    init(
        url: URL,
        cacheInUserDefaults: Bool
    ) {
        self.url = url
        self.cacheInUserDefaults = cacheInUserDefaults
        
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey), cacheInUserDefaults {
            self.image = Image(data: data)
        } else {
            self.objectWillChange = $image
                .handleEvents(
                    receiveSubscription: { [weak self] _ in
                        self?.fetchImage()
                    }, receiveCancel: { [weak self] in
                        self?.cancellable?.cancel()
                    }
            ).eraseToAnyPublisher()
            
            UserDefaults.standard.set(nil, forKey: userDefaultsKey)
        }
    }
    
    private func fetchImage() {
        if image != nil {
            return
        }
                
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .receiveOnMainQueue()
            .map({
                self.image = Image(data: $0.data)
                
                UserDefaults.standard.set($0.data, forKey: "URLImageLoader.\(self.url.absoluteString)")
            })
            .sink()
    }
}
