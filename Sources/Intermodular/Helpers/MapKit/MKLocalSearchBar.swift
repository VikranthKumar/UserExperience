//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import CoreLocation
import MapKit
import SwiftUIX
import UIKit

public struct MKLocalSearchBar: View {
    @State var text: String = ""
    
    let searchController: MKLocalSearchController
    
    init(results: Binding<Result<[MKLocalSearchCompletion], Error>?>) {
        searchController = .init(results: results)
    }
    
    public var body: some View {
        SearchBar(text: $text, onEditingChanged: { _ in
            if self.text.isEmpty {
                self.searchController.cancel()
                self.searchController.results = .success([])
            } else {
                self.searchController.queryFragment = self.text
            }
        })
    }
}

#endif
