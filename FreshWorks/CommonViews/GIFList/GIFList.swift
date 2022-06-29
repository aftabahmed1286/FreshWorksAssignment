//
//  GIFList.swift
//  FreshWorks
//
//  Created by AftabAhmed on 29/06/22.
//

import SwiftUI

struct GIFList: View {
    
    var gifImageData: [GIFImageData]
    
    var body: some View {
        List {
            ForEach(gifImageData, id: \.self) { gid in
                ZStack {
                    VStack{
                        Text(gid.id ?? "")
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
