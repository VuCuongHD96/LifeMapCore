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
        switch annotation {
        case let annotation as DragPin:
            return DragPinAnnotationView(annotation: annotation)
        case let annotation as StorageMapItemViewData:
            return StorageMapAnnotationView(annotation: annotation)
        case let annotation as SearchMapItemViewData:
            return SearchMapAnnotationView(annotation: annotation)
        default:
            return nil
        }
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
