//
//  GIFList.swift
//  FreshWorks
//
//  Created by AftabAhmed on 29/06/22.
//

import SwiftUI

/// This view shows the gifs in list format
struct GIFList: View {
    
    var gifImageData: [GIFImageData]
    
    var body: some View {
        List {
            ForEach(gifImageData, id: \.self) { gid in
                ZStack {
                    VStack{
                        GIFURLImageView(urlImageviewModel: URLImageViewModel(id: gid.id, url: gid.url))
                            .frame(height: 200)
                    }
                    
                }.listRowSeparator(.hidden)
            }
            .listRowInsets(EdgeInsets(top: 0,
                                      leading: 0,
                                      bottom: 20,
                                      trailing: 0))
            
        }
    }
}
