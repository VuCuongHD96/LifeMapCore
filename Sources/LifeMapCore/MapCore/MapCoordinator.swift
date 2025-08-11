//
//  MapCoordinator.swift
//  LifeMapCore
//
//  Created by sun on 9/8/25.
//

import MapKit

public class MapCoordinator: NSObject, MKMapViewDelegate {
    
    let dragPinHander: DragPinHandler?
    
    init(dragPinHander: DragPinHandler?) {
        self.dragPinHander = dragPinHander
    }
    
    let locationUseCase = LocationUseCase()
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if annotation is DragPin {
            return setupDragPin(mapView: mapView, annotation: annotation)
        }
        return nil
    }
    
    private func setupDragPin(mapView: MKMapView, annotation: any MKAnnotation) -> MKAnnotationView? {
        let markerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DragPin")
        markerAnnotationView.isDraggable = true
        markerAnnotationView.canShowCallout = true
        markerAnnotationView.markerTintColor = .systemPurple
        return markerAnnotationView
    }
    
    public func mapView(
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
    
    public func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
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
            self.dragPinHander?(updatedPin)
        }
    }
}
