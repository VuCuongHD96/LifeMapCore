//
//  ViewModelType.swift
//  LifeMapCore
//
//  Created by sun on 8/8/25.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output
}
