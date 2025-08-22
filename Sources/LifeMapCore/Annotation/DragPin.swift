//
//  DragPin.swift
//  LifeMapCore
//
//  Created by sun on 8/8/25.
//

import MapKit

public class DragPin: LocationAnnotation {
    
    public init(coordinate: CLLocationCoordinate2D) {
        super.init(id: "", title: "", coordinate: coordinate)
    }
    
    public required init(id: String, title: String?, coordinate: CLLocationCoordinate2D) {
        super.init(id: id, title: title, coordinate: coordinate)
    }
}
