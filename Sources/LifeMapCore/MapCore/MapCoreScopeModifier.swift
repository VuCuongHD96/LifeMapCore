//
//  MapCoreScopeModifier.swift
//  ToDoLife
//
//  Created by sun on 19/7/25.
//

import SwiftUI
import MapKit

public struct MapCoreScopeModifier: ViewModifier {
    
    public let param: Param
    
    public func body(content: Content) -> some View {
        content
            .overlay(alignment: .topTrailing) {
                mapScopeButtonList
            }
    }
    
    private var mapScopeButtonList: some View {
        VStack {
            mapScorePinControlButton
            zoomButton
        }
        .buttonBorderShape(.circle)
        .padding(8)
    }
    
    private var zoomButton: some View {
        Group {
            if param.isZoomIn {
                zoomOutButton
            } else {
                zoomInButton
            }
        }
        .frame(width: 44, height: 44)
        .background(.blue)
        .clipShape(.circle)
    }
    
    private var zoomOutButton: some View {
        Image("zoom_out", bundle: .module)
            .onTapGesture {
                param.zoomAction?(.zoomOut)
            }
    }
    
    private var zoomInButton: some View {
        Image("zoom_in", bundle: .module)
            .onTapGesture {
                param.zoomAction?(.zoomIn)
            }
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
    
    public func setupMapCoreScopeModifier(param: MapCoreScopeModifier.Param) -> some View {
        self.modifier(
            MapCoreScopeModifier(param: param)
        )
    }
}
