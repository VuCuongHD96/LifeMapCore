// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct LifeMapCore: View {
    
    @State private var isPin: Bool = true
    @ObservedObject var input: LifeMapCoreViewModel.Input
    @State var output: LifeMapCoreViewModel.Output
    let cancelBag = CancelBag()
    
    public init() {
        let input: LifeMapCoreViewModel.Input = .init()
        let viewModel = LifeMapCoreViewModel()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        input.loadTrigger.send()
    }
    
    public var body: some View {
        MapViewRepresentable(
            isPin: output.isPin,
            storageMapItemList: output.storageMapItemList,
            dragPinHander: {
                input.dragPinTrigger.send($0)
            }
        )
        .ignoresSafeArea()
        .setupMapCoreScopeModifier(
            param: .init(
                isPin: output.isPin,
                pinAction: {
                    input.pinAction.send($0)
                },
                isZoomIn: output.isZoomIn,
                zoomAction: {
                    input.zoomTrigger.send($0)
                }
            )
        )
    }
}

#Preview {
    LifeMapCore()
}
