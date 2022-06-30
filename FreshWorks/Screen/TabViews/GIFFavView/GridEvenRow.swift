//
//  GridEvenRow.swift
//  FreshWorks
//
//  Created by AftabAhmed on 29/06/22.
//

import SwiftUI

/// This view displas the Even Row in the Grid
struct GridEvenRow: View {

    var row: Int
    var columnsEven = 3

    @EnvironmentObject var viewModel: TabGIFViewModel

    @State var columns: [GIFImageData] = []
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<columns.count, id: \.self) { col in
                let gid = columns[col]
                VStack {
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
    
    /// This method loads columns for the row
    private func loadColumns() {
        let fav = viewModel.favGifImageData
        let index = row/2 * 5
        columns = (0..<columnsEven).compactMap{
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
     0          0...3                   0/2 * 5
     2          5...3                   2/2 * 5
     4          10...3                  4/2 * 5
     6          15...3                  6/2 * 5
     
     Hence, row/2 * 5 + columns(0...3)
     */
}
