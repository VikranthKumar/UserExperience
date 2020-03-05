//
// Copyright (c) Vatsal Manot
//

import Merge
import Foundation
import SwiftUIX

public struct URLRemoteImage<Placeholder: View>: View {
    let placeholder: Placeholder
    let url: URL?
    let urlSession: URLSession = .images
    
    @State private var image: Image?
    
    public init(url: URL?, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.placeholder = placeholder()
    }
    
    private func dataPublisher() -> AnyPublisher<Data?, Never> {
        if let url = url {
            return urlSession
                .dataTaskPublisher(for: url)
                .map { $0.data }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } else {
            return Just(nil)
                .eraseToAnyPublisher()
        }
    }
    
    public var body: some View {
        image.ifSome { image in
            image.resizable()
        }.else {
            placeholder
                .onReceive(dataPublisher()) { output in
                    self.image = output.flatMap(Image.init(data:))
            }
        }
    }
}

private extension URLSession {
    static let images: URLSession = {
        let cachePath = try? FileManager.default.url(
            for: .cachesDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).absoluteString
        
        let cache = URLCache(memoryCapacity: 1_024 * 1_024 * 8, diskCapacity: 1_024 * 1_024 * 64, diskPath: cachePath)
        let configuration = URLSessionConfiguration.default
        
        configuration.urlCache = cache
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        return URLSession(configuration: configuration)
    }()
}

extension View {
    public func remoteImage(from url: URL?) -> some View {
        URLRemoteImage(url: url) {
            self
        }
    }
}
