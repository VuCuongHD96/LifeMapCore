// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct LifeMapCore: View {
        
    @State private var isPin: Bool = true
    @ObservedObject var input: LifeMapCoreViewModel.Input
    @ObservedObject var output: LifeMapCoreViewModel.Output
    let cancelBag = CancelBag()
    
    public init() {
        let input: LifeMapCoreViewModel.Input = .init()
        let viewModel = LifeMapCoreViewModel()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    public var body: some View {
        MapViewRepresentable(
            isPin: output.isPin
        )
        .ignoresSafeArea()
        .setupMapCoreScopeModifier(
            param: .init(
                isPin: output.isPin,
                pinAction: {
                    input.pinAction.send(.pin)
                },
                unpinAction: {
                    input.pinAction.send(.unPin)
                }
            )
        )
    }
}

#Preview {
    LifeMapCore()
}
