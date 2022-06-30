//
//  GIFView.swift
//  FreshWorks
//
//  Created by AftabAhmed on 25/06/22.
//

import UIKit
import SwiftUI

/// This view is the first Tab view which shows either fetched or searched GIF images
struct GIFView: View {
    
    @EnvironmentObject var viewModel: TabGIFViewModel
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            GIFList(gifImageData: viewModel.gifImageData)
                .searchable(text: $searchText)
                .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            loadImages()
        }.onChange(of: searchText) {
            _ in
            loadImages()
        }
    }
    
    /// This method loads images based on the search text
    func loadImages() {
        if searchText.isEmpty {
            viewModel.fetch()
        } else {
            viewModel.search(searchText)
        }
    }
    
}
