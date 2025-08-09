//
//  MapViewRepresentable.swift
//  LifeMapCore
//
//  Created by sun on 8/8/25.
//

import MapKit
import SwiftUI

struct MapViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    let isPin: Bool
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func makeCoordinator() -> MapCoordinator {
        return .init()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        setupAnnotation(uiView)
    }
    
    func setupAnnotation(_ uiView: MKMapView) {
        let coordinate = uiView.region.center
        uiView.removeAnnotations(uiView.annotations)
        if isPin {
            let dragPin = DragPin(coordinate: coordinate)
            uiView.addAnnotation(dragPin)
        }
    }
}
