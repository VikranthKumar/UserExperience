//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import MapKit
import SwiftUIX
import UIKit

public struct MKLocalSearchBar: View {
    class _Delegate: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
        @Binding var results: Result<[MKLocalSearchCompletion], Error>?
        
        public init(results: Binding<Result<[MKLocalSearchCompletion], Error>?>) {
            _results = results
            
            super.init()
        }
        func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            results = .success(completer.results)
        }
        
        func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
            results = .failure(error)
        }
    }
    
    @State var text: String = ""
    
    @ObservedObject var searchCompleterDelegate: _Delegate
    
    let searchCompleter: MKLocalSearchCompleter
    
    init(results: Binding<Result<[MKLocalSearchCompletion], Error>?>) {
        searchCompleterDelegate = .init(results: results)
        
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter.delegate = searchCompleterDelegate
        searchCompleter.resultTypes = [.address, .query]
    }
    
    public var body: some View {
        SearchBar(text: $text, onEditingChanged: { _ in
            if self.text.isEmpty {
                self.searchCompleter.cancel()
                self.searchCompleterDelegate.results = .success([])
            } else {
                self.searchCompleter.queryFragment = self.text
            }
        })
    }
}

#endif
