//
//  GIFFavView.swift
//  FreshWorks
//
//  Created by AftabAhmed on 25/06/22.
//

import SwiftUI

struct GIFFavGrid: View {
    
    @EnvironmentObject var viewModel: GIFViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<viewModel.numberOfRowsForFavoriteGrid(), id: \.self) { row in
                    if row % 2 == 0 {
                        GridEvenRow(row: row)
                    } else {
                        GridOddRow(row: row)
                    }
                }
            }
        }
        .padding([.leading, .trailing], 20)
    }
}

struct GIFFavView: View {
    
    @State private var style = 0
    
    @EnvironmentObject var viewModel: GIFViewModel
    
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
                    GIFFavGrid()
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
