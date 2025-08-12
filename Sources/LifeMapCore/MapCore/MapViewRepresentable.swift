//
//  MapViewRepresentable.swift
//  LifeMapCore
//
//  Created by sun on 8/8/25.
//

import MapKit
import SwiftUI

public struct MapViewRepresentable: UIViewRepresentable {
    
    public typealias UIViewType = MKMapView
    
    public let isPin: Bool
    public let storageMapItemList: [LocationAnnotation]
    public let mapCoordinatorParam: MapCoordinator.Param
    
    public init(
        isPin: Bool,
        storageMapItemList: [LocationAnnotation],
        mapCoordinatorParam: MapCoordinator.Param
    ) {
        self.isPin = isPin
        self.storageMapItemList = storageMapItemList
        self.mapCoordinatorParam = mapCoordinatorParam
    }
    
    public func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    public func makeCoordinator() -> MapCoordinator {
        return .init(param: mapCoordinatorParam)
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        setupStorageMapItem(uiView: uiView)
        setupDragPin(uiView)
    }
    
    private func setupStorageMapItem(uiView: UIViewType) {
        uiView.addAnnotations(storageMapItemList)
    }
    
    private func setupDragPin(_ uiView: MKMapView) {
        let existingDragPin = uiView.annotations.first { $0 is DragPin } as? DragPin
        if isPin {
            if existingDragPin == nil {
                let dragPin = DragPin(coordinate: uiView.centerCoordinate)
                uiView.addAnnotation(dragPin)
            }
        } else {
            if let existingDragPin {
                uiView.removeAnnotation(existingDragPin)
            }
        }
    }
}
