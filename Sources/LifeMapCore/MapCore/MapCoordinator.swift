//
//  MapCoordinator.swift
//  LifeMapCore
//
//  Created by sun on 9/8/25.
//

import MapKit

public class MapCoordinator: NSObject, MKMapViewDelegate {
    
    let param: Param
    
    public init(param: Param) {
        self.param = param
    }
    
    let locationUseCase = LocationUseCase()
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? LocationAnnotation else {
            return
        }
        if annotation is DragPin {
            return
        }
        param.mapItemHandler?(annotation)
    }
    
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
            self.param.dragPinHander?(updatedPin)
        }
    }
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        param.centerCoordinateHandler?(mapView.centerCoordinate)
    }
}
