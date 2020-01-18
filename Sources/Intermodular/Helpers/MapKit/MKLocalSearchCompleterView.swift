//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import MapKit
import SwiftUIX
import UIKit

public struct MKLocalSearchCompleterView: View {
    @State var results: Result<[MKLocalSearchCompletion], Error>?
    
    @Binding var selection: MKLocalSearchCompletion?
    
    public init(selection: Binding<MKLocalSearchCompletion?>) {
        _selection = selection
    }
    
    public var body: some View {
        VStack {
            MKLocalSearchBar(results: $results)
            
            ResultView(results ?? .success([]), successView: { results in
                List(results, id: \.hashValue) { result in
                    Button(action: { self.selection = result }) {
                        VStack(alignment: .leading) {
                            Text(result.title)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            Text(result.subtitle)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }, failureView: {
                Text(String(describing: $0))
                    .foregroundColor(.red)
            })
        }
    }
}

#endif
