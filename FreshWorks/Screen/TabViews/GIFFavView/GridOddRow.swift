//
//  GridOddRow.swift
//  FreshWorks
//
//  Created by AftabAhmed on 29/06/22.
//

import SwiftUI

struct GridOddRow: View {

    var row: Int
    var columnsOdd = 2

    @EnvironmentObject var viewModel: TabGIFViewModel
    
    @State var columns: [GIFImageData] = []

    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<columns.count, id: \.self) { col in
                let gid = columns[col]
                VStack{
                    Text(gid.id ?? "")
                    let urlImageviewModel = URLImageViewModel(id: gid.id, url: gid.url)
                    GIFURLImageView(urlImageviewModel: urlImageviewModel)
                        .frame(width: viewModel.itemWidthForCol(col, row: row), height: 150)
                }
                
            }
        }.onAppear{
            loadColumns()
        }
    }
    
    private func loadColumns() {
        let fav = viewModel.favGifImageData
        let index = row/2 * 5 + 3
        columns = (0..<columnsOdd).compactMap{
            col in
            let ind = index + col
            if ind < fav.count {
                return fav[ind]
            } else {
                return nil
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
