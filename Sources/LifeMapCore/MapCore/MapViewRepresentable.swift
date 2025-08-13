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
    public let locationFocus: CLLocationCoordinate2D?
    public let storageMapItemList: [StorageMapItemViewData]
    public let searchMapItemList: [SearchMapItemViewData]
    let mapCoordinatorParam: MapCoordinator.Param
    
    public init(
        isPin: Bool,
        locationFocus: CLLocationCoordinate2D?,
        storageMapItemList: [StorageMapItemViewData],
        searchMapItemList: [SearchMapItemViewData],
        mapCoordinatorParam: MapCoordinator.Param
    ) {
        self.isPin = isPin
        self.locationFocus = locationFocus
        self.storageMapItemList = storageMapItemList
        self.searchMapItemList = searchMapItemList
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
        setupSearchMapItem(uiView: uiView)
        setupStorageMapItem(uiView: uiView)
        setupDragPin(uiView)
        setRegion(uiView: uiView)
    }
    
    private func setupSearchMapItem(uiView: UIViewType) {
        uiView.addAnnotations(searchMapItemList)
    }
    
    private func setRegion(uiView: UIViewType) {
        if let locationFocus {
            let region = MKCoordinateRegion(center: locationFocus, span: .medium)
            uiView.setRegion(region, animated: true)
        }
    }
    
    private func setupStorageMapItem(uiView: UIViewType) {
        removeAllAnnotation(uiView: uiView)
        uiView.addAnnotations(storageMapItemList)
    }
    
    private func removeAllAnnotation(uiView: UIViewType) {
        let allAnnotations = uiView.annotations
        uiView.removeAnnotations(allAnnotations)
    }
    
    private func setupDragPin(_ uiView: MKMapView) {
        let existingDragPin = uiView.annotations.first { $0 is DragPin } as? DragPin
        if isPin {
            if existingDragPin == nil {
                let dragPin = DragPin(coordinate: uiView.region.center)
                uiView.addAnnotation(dragPin)
            }
        } else {
            if let existingDragPin {
                uiView.removeAnnotation(existingDragPin)
            }
        }
    }
}
