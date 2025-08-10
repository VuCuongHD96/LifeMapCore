//
//  DragPin.swift
//  LifeMapCore
//
//  Created by sun on 8/8/25.
//

import MapKit

class DragPin: CoreAnnotation {
    
    let id: String
    var title: String?
  
    init(id: String, title: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        super.init(coordinate: coordinate)
    }
    
    convenience override init(coordinate: CLLocationCoordinate2D) {
        self.init(id: "", title: "", coordinate: coordinate)
    }
}
