//
//  ContentView.swift
//  JiggleSmartAssetChopper
//
//  Created by Nicky Taylor on 10/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            
            var names = [ImportName]()
            names.append(.init(partial: "shrunk_delete", replace: "delete", type: .button))
            names.append(.init(partial: "shrunk_guide_points", replace: "guide_points", type: .checkbox))
            names.append(.init(partial: "shrunk_guides", replace: "guides", type: .checkbox))
            names.append(.init(partial: "shrunk_jiggle_points", replace: "jiggle_points", type: .checkbox))
            names.append(.init(partial: "shrunk_delete", replace: "delete", type: .checkbox))
            names.append(.init(partial: "shrunk_jiggles", replace: "jiggles", type: .checkbox))
            
            Tool.generateAll(names: names)
        }
    }
}

#Preview {
    ContentView()
}
