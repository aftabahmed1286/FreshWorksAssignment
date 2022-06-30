//
//  GIFURLImageView.swift
//  FreshWorks
//
//  Created by AftabAhmed on 28/06/22.
//

import SwiftUI

struct GIFURLImageView: View {
    
    @EnvironmentObject var viewModel: TabGIFViewModel
    
    @StateObject var urlImageviewModel: URLImageViewModel = URLImageViewModel(id: nil, url: nil)
    
    @State var isFavSelected: Bool = false
    
    var body: some View {
        ZStack {
            
            if let image = urlImageviewModel.data {
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
    
    func favTapped() {
        if let id = urlImageviewModel.id {
            let isFav = DefaultsHelper.isFavoriteFor(id)
            DefaultsHelper.shouldfavoriteFor(id, shouldFav: !isFav)
            //viewModel.loadFavoriteGIFImageData()
            if DefaultsHelper.isFavoriteFor(id) != isFavSelected {
                isFavSelected.toggle()
            }
        }
        viewModel.loadFavoriteGIFImageData()
        
    }
}
