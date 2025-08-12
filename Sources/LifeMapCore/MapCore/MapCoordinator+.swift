//
//  MapCoordinator+.swift
//  LifeMapCore
//
//  Created by sun on 12/8/25.
//

extension MapCoordinator {
    
    public struct Param {
        let dragPinHander: DragPinHandler?
        let centerCoordinateHandler: CoordinateHandler?
        
        public init(
            dragPinHander: DragPinHandler? = nil,
            centerCoordinateHandler: CoordinateHandler? = nil
        ) {
            self.dragPinHander = dragPinHander
            self.centerCoordinateHandler = centerCoordinateHandler
        }
    }
}
