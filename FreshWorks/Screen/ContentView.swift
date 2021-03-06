//
//  ContentView.swift
//  FreshWorks
//
//  Created by AftabAhmed on 24/06/22.
//

import SwiftUI

/// Starting Point where the app is in a Tab Bar
struct ContentView: View {
    
    init() {
       UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var viewModel = TabGIFViewModel()
    
    var body: some View {
        TabView {
            GIFView()
                .tabItem{
                    Label("", systemImage: "photo.on.rectangle")
                }
            GIFFavView()
                .tabItem{
                    Label("", systemImage: "heart.fill")
                }
        }.environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
