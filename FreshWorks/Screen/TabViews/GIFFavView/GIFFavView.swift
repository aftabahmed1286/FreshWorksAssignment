//
//  GIFFavView.swift
//  FreshWorks
//
//  Created by AftabAhmed on 25/06/22.
//

import SwiftUI

/// This view is the 2nd Tab view showing just the favorites in 2 styles - Grid and List
struct GIFFavView: View {
    
    @State private var style = 0
    
    @EnvironmentObject var viewModel: TabGIFViewModel
    
    var body: some View {
        NavigationView {
            
            VStack {
                Picker("", selection: $style) {
                    Text("Grid").tag(0)
                    Text("List").tag(1)
                }
                .padding([.leading, .trailing], 20)
                .pickerStyle(.segmented)
                
                if style == 0 {
                    GIFFavGrid(gifImageData: viewModel.favGifImageData)
                } else {
                    GIFList(gifImageData: viewModel.favGifImageData)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                viewModel.loadFavoriteGIFImageData()
            }
        }
    }
    
}
