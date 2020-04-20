//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

public enum ContainerType {
    case collection(CollectionViewLayout = CollectionViewFlowLayout())
    case list
    case stack(Axis3D)
}

public struct ContainerInfo: Hashable {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static let defaultValue: [ContainerInfo] = []
        
        static func reduce(value: inout [ContainerInfo], nextValue: () -> [ContainerInfo]) {
            value += nextValue()
        }
    }
    
    public var children: [ContainerInfo]
    
    public var depth: Int {
        children.lazy.map({ $0.depth }).max().map({ $0 + 1 }) ?? 0
    }
}

public struct Container<Content: View>: View {
    @State fileprivate var children: [ContainerInfo] = []
    
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var info: ContainerInfo {
        ContainerInfo(children: children)
    }
    
    public var body: some View {
        content.onPreferenceChange(ContainerInfo.PreferenceKey.self) { containers in
            self.children = containers
        }
        .preference(
            key: ContainerInfo.PreferenceKey.self,
            value: [info]
        )
    }
}
