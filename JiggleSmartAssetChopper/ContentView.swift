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
            
            names.append(.init(inputPrefix: "mini", outputPrefix: "loose", name: "rotate_right_a", type: .loose))
            names.append(.init(inputPrefix: "mini", outputPrefix: "loose", name: "rotate_right_b", type: .loose))
            names.append(.init(inputPrefix: "mini", outputPrefix: "loose", name: "rotate_left_a", type: .loose))
            names.append(.init(inputPrefix: "mini", outputPrefix: "loose", name: "rotate_left_b", type: .loose))
            
            //names.append(.init(inputPrefix: "mini", outputPrefix: "framed", name: "jiggle_center_b", type: .framed))
            //names.append(.init(inputPrefix: "mini", outputPrefix: "framed", name: "jiggle_center_a", type: .framed))
            
            
            //names.append(.init(partial: "shrunk_make_guide", replace: "framed_make_guide", type: .framed))
            //names.append(.init(partial: "shrunk_draw_jiggle", replace: "framed_draw_jiggle", type: .framed))
            //names.append(.init(partial: "shrunk_make_jiggle", replace: "framed_make_jiggle", type: .framed))
            
            //names.append(.init(partial: "mini_jiggle_a", replace: "framed_jiggle_a", type: .framed))
            //names.append(.init(partial: "mini_jiggle_b", replace: "framed_jiggle_b", type: .framed))
            
            //names.append(.init(partial: "mini_points_a", replace: "framed_points_a", type: .framed))
            //names.append(.init(partial: "mini_points_b", replace: "framed_points_b", type: .framed))
            
            
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
