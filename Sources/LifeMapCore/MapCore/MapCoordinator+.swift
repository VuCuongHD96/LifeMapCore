//
//  MapCoordinator+.swift
//  LifeMapCore
//
//  Created by sun on 13/8/25.
//

extension MapCoordinator {
    
    public struct Param {

        let dragPinHander: DragPinHandler?
        let mapItemHandler: LocationAnnotationHandler?
        let centerCoordinateHandler: CoordinateHandler?

        public init(
            dragPinHander: DragPinHandler?,
            mapItemHandler: LocationAnnotationHandler?,
            centerCoordinateHandler: CoordinateHandler? = nil
        ) {
            self.dragPinHander = dragPinHander
            self.mapItemHandler = mapItemHandler
            self.centerCoordinateHandler = centerCoordinateHandler
        }
    }
}
