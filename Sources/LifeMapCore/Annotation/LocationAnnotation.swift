//
//  LocationAnnotation.swift
//  LifeMapCore
//
//  Created by sun on 11/8/25.
//

import CoreLocation

open class LocationAnnotation: CoreAnnotation {
    
    public let id: String
    public let title: String?
    
    public required init(id: String, title: String?, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        super.init(coordinate: coordinate)
    }
}
