//
//  LifeMapCoreViewModel.swift
//  LifeMapCore
//
//  Created by sun on 8/8/25.
//

import CoreLocation
import Combine

struct LifeMapCoreViewModel: ViewModelType {
    
    class Input: ObservableObject {
        var pinAction = PassthroughSubject<PinCase, Never>()
        let dragPinTrigger = PassthroughSubject<DragPin, Never>()
    }
    
    class Output: ObservableObject {
        @Published var isPin = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
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
