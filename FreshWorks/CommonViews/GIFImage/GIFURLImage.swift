//
//  GIFURLImageView.swift
//  FreshWorks
//
//  Created by AftabAhmed on 28/06/22.
//

import SwiftUI

/// This view shows the downloaded/fetched from file storage
struct GIFURLImageView: View {
    
    @EnvironmentObject var viewModel: TabGIFViewModel
    
    @StateObject var urlImageviewModel: URLImageViewModel
    
    @State var isFavSelected: Bool = false
    
    var body: some View {
        ZStack {
            if let image = urlImageviewModel.data
                {
                GIFImage(image)
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            favTapped()
                        } label: {
                            Image(systemName: isFavSelected ? "heart.circle.fill" : "heart.slash")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(10)
                        }.buttonStyle(.plain)
                    }
                    Spacer()
                }
                
            }else {
                Image("")
                    .resizable()
                    .background(.gray)
                    .onAppear{
                        urlImageviewModel.fetch()
                    }
                
            }
        }.onAppear{
            if let id = urlImageviewModel.id {
                isFavSelected = DefaultsHelper.isFavoriteFor(id)
            }
        }
    }
    
    /// When Favorite tapped the corresponding id is stored in the userdefaults
    func favTapped() {
        if let id = urlImageviewModel.id {
            let isFav = DefaultsHelper.isFavoriteFor(id)
            DefaultsHelper.shouldfavoriteFor(id, shouldFav: !isFav)
            if DefaultsHelper.isFavoriteFor(id) != isFavSelected {
                isFavSelected.toggle()
            }
        }
        viewModel.loadFavoriteGIFImageData()
        
    }
}
