//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import CoreLocation
import MapKit
import SwiftUIX
import UIKit

public class MKLocalSearchController: NSObject, ObservableObject {
    let locationManager: CLLocationManager
    let searchCompleter: MKLocalSearchCompleter
    
    @Binding var results: Result<[MKLocalSearchCompletion], Error>?
    
    public init(results: Binding<Result<[MKLocalSearchCompletion], Error>?>) {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter.resultTypes = [.address, .query]
        
        _results = results
        
        super.init()
        
        locationManager.delegate = self
        searchCompleter.delegate = self
    }
}

extension MKLocalSearchController {
    var queryFragment: String {
        get {
            searchCompleter.queryFragment
        } set {
            searchCompleter.queryFragment = newValue
        }
    }
    
    public func cancel() {
        searchCompleter.cancel()
    }
}

// MARK: - Protocol Implementations -

extension MKLocalSearchController: MKLocalSearchCompleterDelegate {
    public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = .success(completer.results)
    }
    
    public func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        results = .failure(error)
    }
}

extension MKLocalSearchController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            let wasSearching = searchCompleter.isSearching
            
            if wasSearching {
                searchCompleter.cancel()
            }
            
            searchCompleter.region.center = coordinate
            searchCompleter.region.span = .init(latitudeDelta: 2, longitudeDelta: 2)
            
            if wasSearching {
                searchCompleter.queryFragment = searchCompleter.queryFragment
            }
        }
    }
}

#endif
