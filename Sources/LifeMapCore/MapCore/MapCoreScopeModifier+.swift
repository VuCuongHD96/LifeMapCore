//
//  MapCoreScopeModifier+.swift
//  LifeMapCore
//
//  Created by sun on 12/8/25.
//

extension MapCoreScopeModifier {
    
    public struct Param {
        let isPin: Bool
        let pinAction: PinCaseHandler?
        let isZoomIn: Bool
        let zoomAction: ZoomCaseHandler?
        
        public init(
            isPin: Bool,
            pinAction: PinCaseHandler?,
            isZoomIn: Bool,
            zoomAction: ZoomCaseHandler?
        ) {
            self.isPin = isPin
            self.pinAction = pinAction
            self.isZoomIn = isZoomIn
            self.zoomAction = zoomAction
        }
    }
}
