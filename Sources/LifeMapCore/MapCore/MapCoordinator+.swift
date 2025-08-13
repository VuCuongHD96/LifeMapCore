//
//  MapCoordinator+.swift
//  LifeMapCore
//
//  Created by sun on 13/8/25.
//

extension MapCoordinator {
    
    public struct Param {
        
        let dragPinHander: DragPinHandler?
        let annotationSelectedHandler: LocationAnnotationHandler?
        
        public init(
            dragPinHander: DragPinHandler?,
            mapItemHandler: LocationAnnotationHandler?
        ) {
            self.dragPinHander = dragPinHander
            self.annotationSelectedHandler = mapItemHandler
        }
    }
}
