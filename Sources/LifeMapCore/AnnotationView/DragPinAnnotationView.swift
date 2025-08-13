//
//  DragPinAnnotationView.swift
//  LifeMapCore
//
//  Created by sun on 13/8/25.
//

import MapKit

class DragPinAnnotationView: MKMarkerAnnotationView {
    
    init(annotation: (any MKAnnotation)?) {
        super.init(annotation: annotation, reuseIdentifier: "DragPin")
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        isDraggable = true
        canShowCallout = true
        markerTintColor = .systemPurple
    }
}
