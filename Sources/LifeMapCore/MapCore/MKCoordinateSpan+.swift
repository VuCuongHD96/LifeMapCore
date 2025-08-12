//
//  MKCoordinateSpan+.swift
//  LifeMapCore
//
//  Created by sun on 13/8/25.
//

import MapKit

extension MKCoordinateSpan {
   
    static var medium: Self {
        .init(latitudeDelta: 0.05, longitudeDelta: 0.05)
    }
    
    static var closed: Self {
        .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
    }
}
