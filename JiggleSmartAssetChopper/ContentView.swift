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
            
            /*
            let namePause = ImportName(inputPrefix: "mini",
                                       outputPrefix: "framed",
                                       name: "pause",
                                       type: .framed)
            let namePlay = ImportName(inputPrefix: "mini",
                                       outputPrefix: "framed",
                                       name: "play",
                                       type: .framed)
            
            if let framePause = Tool.getFrame(name: namePause) {
                
                Tool.generateAll(name: namePause, scaled: true, frame: framePause)
                Tool.generateAll(name: namePlay, scaled: true, frame: framePause)
                
            }
            */
            
            

            
            //Tool.generateAll(names: names, scaled: true)

            
            
            //framed_guides_dark_disabled.png
            //framed_guides_dark.png
            //framed_guides_light_disabled.png
            //framed_guides_light.png
            
            
            var names = [ImportName]()
            
            
            names.append(.init(inputPrefix: "mini", outputPrefix: "loose", name: "frame_prev_a", type: .loose))
            names.append(.init(inputPrefix: "mini", outputPrefix: "loose", name: "frame_prev_b", type: .loose))
            names.append(.init(inputPrefix: "mini", outputPrefix: "loose", name: "frame_next_a", type: .loose))
            names.append(.init(inputPrefix: "mini", outputPrefix: "loose", name: "frame_next_b", type: .loose))
            
            
            
            
            //names.append(.init(inputPrefix: "mini", outputPrefix: "framed", name: "guide_centers_b", type: .loose))
            //names.append(.init(inputPrefix: "mini", outputPrefix: "framed", name: "guide_centers_c", type: .loose))
            //names.append(.init(inputPrefix: "mini", outputPrefix: "framed", name: "guide_centers_d", type: .loose))
            
            //names.append(.init(inputPrefix: "mini", outputPrefix: "framed", name: "jiggle_center_b", type: .framed))
            //names.append(.init(inputPrefix: "mini", outputPrefix: "framed", name: "jiggle_center_a", type: .framed))
            

            
            Tool.generateAll(names: names, scaled: true)
            
            
        }
    }
}

#Preview {
    ContentView()
}
