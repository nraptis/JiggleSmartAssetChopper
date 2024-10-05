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
            
            names.append(.init(partial: "mini_framed_menu_a", replace: "framed_menu_a", type: .framed))
            names.append(.init(partial: "mini_framed_menu_b", replace: "framed_menu_b", type: .framed))
            names.append(.init(partial: "mini_framed_menu_c", replace: "framed_menu_c", type: .framed))
            
            names.append(.init(partial: "mini_loose_menu_a", replace: "loose_menu_a", type: .loose))
            names.append(.init(partial: "mini_loose_menu_b", replace: "loose_menu_b", type: .loose))
            names.append(.init(partial: "mini_loose_menu_c", replace: "loose_menu_c", type: .loose))
            
            
            Tool.generateAll(names: names, scaled: true)
        }
    }
}

#Preview {
    ContentView()
}
