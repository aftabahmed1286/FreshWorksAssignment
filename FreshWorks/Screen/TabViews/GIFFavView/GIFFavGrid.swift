//
//  GIFFavGrid.swift
//  FreshWorks
//
//  Created by AftabAhmed on 30/06/22.
//

import SwiftUI

/// This view loads the favorites in Grid style
struct GIFFavGrid: View {
    
    var gifImageData: [GIFImageData]
    
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(gifImageData, id: \.self) { gid in
                    let urlImageviewModel = URLImageViewModel(id: gid.id, url: gid.url)
                    GIFURLImageView(urlImageviewModel: urlImageviewModel)
                        .frame(height: 150)
                }
            }
            .padding(.horizontal)
        }
        
    }
}
