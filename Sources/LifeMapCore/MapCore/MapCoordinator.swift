//
//  MapCoordinator.swift
//  LifeMapCore
//
//  Created by sun on 9/8/25.
//

import MapKit

class MapCoordinator: NSObject, MKMapViewDelegate {
    
    let locationUseCase = LocationUseCase()
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let markerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DragPin")
        markerAnnotationView.isDraggable = true
        markerAnnotationView.canShowCallout = true
        return markerAnnotationView
    }
    
    func mapView(
        _ mapView: MKMapView,
        annotationView view: MKAnnotationView,
        didChange newState: MKAnnotationView.DragState,
        fromOldState oldState: MKAnnotationView.DragState
    ) {
        if newState == .ending {
            if let dragPin = view.annotation as? DragPin {
                updateDragPin(mapView: mapView, dragPin: dragPin)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        guard let dragPinView = views.first(where: { $0.annotation is DragPin }),
              let dragPin = dragPinView.annotation as? DragPin else {
            return
        }
        
        if let title = dragPin.title, title.isEmpty {
            updateDragPin(mapView: mapView, dragPin: dragPin)
        }
    }
    
    private func updateDragPin(mapView: MKMapView, dragPin: DragPin) {
        locationUseCase.findMapItem(coordinate: dragPin.coordinate) { updatedPin in
            mapView.removeAnnotation(dragPin)
            mapView.addAnnotation(updatedPin)
            mapView.selectAnnotation(updatedPin, animated: true)
        }
    }
}
