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
    let dragPinHander: DragPinHandler?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func makeCoordinator() -> MapCoordinator {
        return .init(dragPinHander: dragPinHander)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        setupDragPin(uiView)
    }
    
    func setupDragPin(_ uiView: MKMapView) {
        let existingDragPin = uiView.annotations.first { $0 is DragPin } as? DragPin
        if isPin {
            if existingDragPin == nil {
                let dragPin = DragPin(coordinate: uiView.region.center)
                uiView.addAnnotation(dragPin)
            }
        } else {
            if let existingDragPin {
                uiView.removeAnnotation(existingDragPin)
            }
        }
    }
}
