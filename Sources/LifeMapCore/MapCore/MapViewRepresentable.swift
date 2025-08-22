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
    
    let isPin: Bool
    let locationFocus: CLLocationCoordinate2D?
    let storageMapItemList: [LocationAnnotation]
    let searchMapItemList: [LocationAnnotation]
    let polylineDictionary: [MKPolyline: UIColor]
    let mapCoordinatorParam: MapCoordinator.Param
    
    public init(
        isPin: Bool,
        locationFocus: CLLocationCoordinate2D?,
        storageMapItemList: [StorageMapItemViewData],
        searchMapItemList: [SearchMapItemViewData],
        polylineDictionary: [MKPolyline: UIColor],
        mapCoordinatorParam: MapCoordinator.Param
    ) {
        self.isPin = isPin
        self.locationFocus = locationFocus
        self.storageMapItemList = storageMapItemList
        self.searchMapItemList = searchMapItemList
        self.polylineDictionary = polylineDictionary
        self.mapCoordinatorParam = mapCoordinatorParam
    }
    
    public func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsCompass = true
        mapView.showsUserTrackingButton = true
        mapView.showsUserLocation = true
        setupStorageMapItem(uiView: mapView)
        return mapView
    }
    
    public func makeCoordinator() -> MapCoordinator {
        return .init(param: mapCoordinatorParam)
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        setupSearchMapItem(uiView: uiView)
        setupDragPin(uiView)
        setRegion(uiView: uiView)
        setupPolyline(uiView: uiView, context: context)
    }
    
    private func setupPolyline(uiView: UIViewType, context: Context) {
        context.coordinator.polylineDictionary = polylineDictionary
        uiView.removeOverlays(uiView.overlays)
        let polyLineList = polylineDictionary.keys
        polyLineList.forEach {
            uiView.addOverlay($0)
        }
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
        let allAnnotationsFilter = allAnnotations.filter {
            !($0 is DragPin)
        }
        uiView.removeAnnotations(allAnnotationsFilter)
    }
    
    private func setupDragPin(_ uiView: MKMapView) {
        let existingDragPin = uiView.annotations.filter { $0 is DragPin }.first as? DragPin
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
