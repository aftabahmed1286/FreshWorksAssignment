//
//  GIFURLImage.swift
//  FreshWorks
//
//  Created by AftabAhmed on 28/06/22.
//

import SwiftUI

class GIFImageLoader: ObservableObject {
    
    var gifImageData: GIFImageData?
    
    @Published var image: Data?
    @Published var isFav = false
    
    @Published var err: Error?
    
    @Environment(\.imageLoader) private var imageLoader
    
    func fetch() {
        Task {
            [weak self] in
            guard let self = self else {
                return
            }
            if let url = gifImageData?.url, let id = gifImageData?.id {
                do {
                    let imageFetched = try await imageLoader.fetch(url, id)
                    DispatchQueue.main.async {
                        self.image = imageFetched
                        self.isFav = DefaultsHelper.isFavoriteFor(id)
                    }
                    print("Image Loaded - \(id)")
                } catch {
                    err = error
                    print(error)
                }
                
            } else {
                err = GIFErrors.wrongUrl
            }
        }
    }
}

import WebKit

struct GIFImage: UIViewRepresentable {
    
    private var data: Data
    
    init(_ dat: Data) {
        self.data = dat
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: NSURL() as URL
        )
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
}


struct GIFURLImage: View {
    
    @EnvironmentObject var viewModel: GIFViewModel
    
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
                        if let id = urlImageviewModel.id {
                            isFavSelected = DefaultsHelper.isFavoriteFor(id)
                        }
                    }
                
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
