//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import MapKit
import SwiftUIX
import UIKit

public struct MapCoordinateRegionView: UIViewRepresentable {
    public typealias UIViewType = MKMapView
    
    public let center: CLLocationCoordinate2D
    public let span: MKCoordinateSpan
    
    public init(
        center: CLLocationCoordinate2D,
        span: MKCoordinateSpan = .init(latitudeDelta: 2.0, longitudeDelta: 2.0)
    ) {
        self.center = center
        self.span = span
    }
    
    public func makeUIView(context: Context) -> UIViewType {
        MKMapView(frame: .zero)
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
    }
}

#endif
