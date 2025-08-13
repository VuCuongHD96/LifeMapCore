//
//  LifeMapCoreViewModel.swift
//  LifeMapCore
//
//  Created by sun on 8/8/25.
//

import CoreLocation
import Combine
import Observation

struct LifeMapCoreViewModel: ViewModelType {
    
    class Input: ObservableObject {
        let loadTrigger = PassthroughSubject<Void, Never>()
        var pinAction = PassthroughSubject<PinCase, Never>()
        let dragPinTrigger = PassthroughSubject<DragPin, Never>()
        let zoomTrigger = PassthroughSubject<ZoomCase, Never>()
        let randomLocationFocusTrigger = PassthroughSubject<Void, Never>()
    }
    
    @Observable
    class Output {
        var isPin = false
        var isZoomIn = true
        var storageMapItemList: [LocationAnnotation] = []
        var locationFocus: CLLocationCoordinate2D?
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.randomLocationFocusTrigger
            .map {
                output.storageMapItemList.randomElement()?.coordinate
            }
            .assign(to: \.locationFocus, on: output)
            .store(in: cancelBag)
        
        input.loadTrigger
            .map {
                let locationAnnotationList: [LocationAnnotation] =   [
                    .init(id: UUID().uuidString,
                          title: "Thanh Xuân",
                          coordinate: .init(latitude: 20.994468, longitude: 105.804509)),
                    .init(id: UUID().uuidString,
                          title: "Thuỵ Khuê",
                          coordinate: .init(latitude: 21.041915, longitude: 105.828957)),
                    .init(id: UUID().uuidString,
                          title: "TP Vinh",
                          coordinate: .init(latitude: 18.699628, longitude: 105.745515))
                ]
                return locationAnnotationList
            }
            .assign(to: \.storageMapItemList, on: output)
            .store(in: cancelBag)
        
        input.zoomTrigger
            .map {
                $0 == .zoomIn
            }
            .assign(to: \.isZoomIn, on: output)
            .store(in: cancelBag)
        
        input.dragPinTrigger
            .sink {
                print("--- debug --- drag pin ", $0)
            }
            .store(in: cancelBag)
        
        input.pinAction
            .map {
                $0 == .pin
            }
            .sink {
                output.isPin = $0
            }
            .store(in: cancelBag)
        
        return output
    }
}
