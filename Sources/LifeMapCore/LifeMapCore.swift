// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        MapViewRepresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
