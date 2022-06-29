//
//  GridOddRow.swift
//  FreshWorks
//
//  Created by AftabAhmed on 29/06/22.
//

import SwiftUI

struct GridOddRow: View {

    var row: Int
    var fav: [GIFImageData]

    var columnsOdd = 2

    @EnvironmentObject var viewModel: GIFViewModel

    var body: some View {
        HStack(spacing: 20) {
            let index = row/2 * 5 + 3
            ForEach(0..<columnsOdd, id: \.self) { col in
                let ind = index + col
                if  ind < fav.count, let gid = fav[ind] {
                    VStack{
                        Text(gid.id ?? "")
                        GIFURLImageView(urlImageviewModel: URLImageViewModel(id: gid.id, url: gid.url))
                        .frame(width: viewModel.itemWidthForCol(col, row: row), height: 150)}
                }
            }
        }
    }
    
    /*
     index logic
     Row ---    Possible Indices ---    Formula
     1          3...2                   1/2 * 5 + 3
     3          8...2                   3/2 * 5 + 3
     5          13...2                  5/2 * 5 + 3
     7          18...2                  7/2 * 5 + 3
     
     Hence, row/2 * 5 + 3 + columns(0...2)
     */
}
