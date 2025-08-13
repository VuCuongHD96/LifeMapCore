//
//  SearchMapAnnotationView.swift
//  LifeMapCore
//
//  Created by sun on 13/8/25.
//

import MapKit

class SearchMapAnnotationView: MKMarkerAnnotationView {
    init(annotation: (any MKAnnotation)?) {
        super.init(annotation: annotation, reuseIdentifier: "SearchMapItem")
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        isDraggable = false
        canShowCallout = true
        markerTintColor = .systemRed
    }
}
