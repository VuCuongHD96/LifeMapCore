//
//  MapViewRepresentable.swift
//  LifeMapCore
//
//  Created by sun on 8/8/25.
//

import MapKit
import SwiftUI

public struct MapViewRepresentable: UIViewRepresentable {
    
    public typealias UIViewType = MKMapView
    
    let isPin: Bool
    let dragPinHander: DragPinHandler?
    
    init(isPin: Bool, dragPinHander: DragPinHandler?) {
        self.isPin = isPin
        self.dragPinHander = dragPinHander
    }
    
    public func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    public func makeCoordinator() -> MapCoordinator {
        return .init(dragPinHander: dragPinHander)
    }
    
    public func updateUIView(_ uiView: MKMapView, context: Context) {
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
