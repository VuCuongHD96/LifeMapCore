//
//  CoreAnnotation.swift
//  LifeMapCore
//
//  Created by sun on 8/8/25.
//

import MapKit

class CoreAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
