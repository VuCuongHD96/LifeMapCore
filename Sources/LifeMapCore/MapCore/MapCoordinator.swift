//
//  MapCoordinator.swift
//  LifeMapCore
//
//  Created by sun on 9/8/25.
//

import MapKit

class MapCoordinator: NSObject, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let markerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DragPin")
        markerAnnotationView.isDraggable = true
        return markerAnnotationView
    }
}
