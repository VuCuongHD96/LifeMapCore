//
//  MapCoreScopeModifier.swift
//  ToDoLife
//
//  Created by sun on 19/7/25.
//

import SwiftUI
import MapKit

struct MapCoreScopeModifier: ViewModifier {
    
    struct Param {
        let isPin: Bool
        let pinAction: PinCaseHandler?
    }
    
    var param: Param
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topTrailing) {
                mapScopeButtonList
            }
    }
    
    private var mapScopeButtonList: some View {
        VStack {
            mapScorePinControlButton
        }
        .buttonBorderShape(.circle)
        .padding(8)
    }
    
    private var mapScorePinControlButton: some View {
        Group {
            if param.isPin {
                mapScopeUnPinButton
            } else {
                mapScopePinButton
            }
        }
        .frame(width: 44, height: 44)
    }
    
    private var mapScopePinButton: some View {
        Image(systemName: "mappin.and.ellipse.circle.fill")
            .resizable()
            .foregroundStyle(.purple)
            .onTapGesture {
                param.pinAction?(.pin)
            }
    }
    
    private var mapScopeUnPinButton: some View {
        Image(systemName: "mappin.slash.circle.fill")
            .resizable()
            .foregroundStyle(.purple)
            .onTapGesture {
                param.pinAction?(.unPin)
            }
    }
}

extension View {
    
    func setupMapCoreScopeModifier(param: MapCoreScopeModifier.Param) -> some View {
        self.modifier(
            MapCoreScopeModifier(param: param)
        )
    }
}
