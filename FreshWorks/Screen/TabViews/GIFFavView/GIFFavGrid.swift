//
//  GIFFavGrid.swift
//  FreshWorks
//
//  Created by AftabAhmed on 30/06/22.
//

import SwiftUI

struct GIFFavGrid: View {
    
    @EnvironmentObject var viewModel: TabGIFViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<viewModel.numberOfRowsForFavoriteGrid(), id: \.self) { row in
                    if row % 2 == 0 {
                        GridEvenRow(row: row)
                    } else {
                        GridOddRow(row: row)
                    }
                }
            }
        }
        .padding([.leading, .trailing], 20)
    }
}
