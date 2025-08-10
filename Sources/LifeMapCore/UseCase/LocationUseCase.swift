//
//  LocationUseCase.swift
//  LifeMapCore
//
//  Created by sun on 9/8/25.
//

import CoreLocation

struct LocationUseCase {
    
    typealias DragPinHandler = (DragPin) -> Void
    
    func findMapItem(coordinate: CLLocationCoordinate2D, dragPinHandler: @escaping DragPinHandler) {
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()
        
        
        geocoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
            if error != nil {
                return
            }
            
            guard let placemark = placemarks?.first, let name = placemark.name else {
                return
            }

            let mapTitle = placemark.locality ?? placemark.administrativeArea ?? "Unknown location"
            let mapID = "\(name)-\(mapTitle)-\(coordinate.latitude)-\(coordinate.longitude)"
            let dragPin = DragPin(
                id: mapID,
                title: name,
                coordinate: coordinate
            )
            
            dragPinHandler(dragPin)
        })
    }
}
