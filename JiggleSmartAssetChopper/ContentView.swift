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
            
            //let nameSquare = ImportName(partial: "shrunk_arrow_tiny_right", replace: "framed_arrow_test_right", type: .framed)
            //let nameCheck = ImportName(partial: "shrunk_arrow_tiny_left", replace: "framed_arrow_test_left", type: .framed)

            /*
            var names = [ImportName]()
            
            names.append(.init(partial: "mini_lock", replace: "accessory_lock", type: .accessory))
            
            names.append(.init(partial: "mini_lock_uncolored", replace: "accessory_uncolored_lock", type: .accessory))
            */
            

            

            /*
            names.append(.init(partial: "shrunk_arrow_tiny_right", replace: "framed_test_arrow_right", type: .framed))
            names.append(.init(partial: "shrunk_arrow_tiny_left", replace: "framed_test_arrow_left", type: .framed))
            
            names.append(.init(partial: "shrunk_arrow_tiny_right", replace: "loose_test_arrow_right", type: .loose))
            names.append(.init(partial: "shrunk_arrow_tiny_left", replace: "loose_test_arrow_left", type: .loose))
            */
             
            //Tool.generateAll(names: names, scaled: true)
            
            /*
            if let frameSquare = Tool.getFrame(name: nameSquare) {
                Tool.generateAll(name: nameSquare, scaled: true, frame: frameSquare)
                Tool.generateAll(name: nameCheck, scaled: true, frame: frameSquare)
            }
            */
            
            //framed_guides_dark_disabled.png
            //framed_guides_dark.png
            //framed_guides_light_disabled.png
            //framed_guides_light.png
            
            
            var names = [ImportName]()
            
            names.append(.init(partial: "framed_guides", replace: "framed_guides", type: .framed))
            
            /*
            names.append(.init(partial: "mini_framed_menu_a", replace: "framed_menu_a", type: .framed))
            names.append(.init(partial: "mini_framed_menu_b", replace: "framed_menu_b", type: .framed))
            names.append(.init(partial: "mini_framed_menu_c", replace: "framed_menu_c", type: .framed))
            
            names.append(.init(partial: "mini_loose_menu_a", replace: "loose_menu_a", type: .loose))
            names.append(.init(partial: "mini_loose_menu_b", replace: "loose_menu_b", type: .loose))
            names.append(.init(partial: "mini_loose_menu_c", replace: "loose_menu_c", type: .loose))
            */
            
            
            Tool.generateAll(names: names, scaled: true)
            
            
        }
    }
}

#Preview {
    ContentView()
}
