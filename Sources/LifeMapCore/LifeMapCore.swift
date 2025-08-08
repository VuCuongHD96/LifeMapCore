// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct LifeMapCore: View {
    
    @State private var isPin = true
    
    let input: LifeMapCoreViewModel.Input
    @State var output: LifeMapCoreViewModel.Output
    let cancelBag = CancelBag()
    
    public init() {
        let input: LifeMapCoreViewModel.Input = .init()
        let viewModel = LifeMapCoreViewModel()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    public var body: some View {
        MapViewRepresentable()
            .ignoresSafeArea()
            .setupMapCoreScopeModifier(
                param: .init(
                    isPin: isPin,
                    pinAction: {
                        isPin = false
                    },
                    unpinAction: {
                        isPin = true
                    }
                )
            )
    }
}

#Preview {
    LifeMapCore()
}
