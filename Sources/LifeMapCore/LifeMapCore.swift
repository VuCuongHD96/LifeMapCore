// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct ContentView: View {
    
    let input: LifeMapCoreViewModel.Input = .init()
    @State var output: LifeMapCoreViewModel.Output = .init()
    let cancelBag = CancelBag()
    
    var body: some View {
        MapViewRepresentable()
            .ignoresSafeArea()
            .onAppear {
                let viewModel = LifeMapCoreViewModel()
                output = viewModel.transform(input, cancelBag: cancelBag)
            }
    }
}

#Preview {
    ContentView()
}
