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
        var pinAction = PassthroughSubject<PinCase, Never>()
        let dragPinTrigger = PassthroughSubject<DragPin, Never>()
        let zoomTrigger = PassthroughSubject<ZoomCase, Never>()
    }
    
    @Observable
    class Output {
         var isPin = false
         var isZoomIn = true
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
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
               return $0 == .pin
            }
            .sink {
                output.isPin = $0
            }
            .store(in: cancelBag)
        
        return output
    }
}
