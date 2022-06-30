//
//  GIFView.swift
//  FreshWorks
//
//  Created by AftabAhmed on 25/06/22.
//

import UIKit
import SwiftUI

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
    
    func loadImages() {
        if searchText.isEmpty {
            viewModel.fetch()
        } else {
            viewModel.search(searchText)
        }
    }
    
}
