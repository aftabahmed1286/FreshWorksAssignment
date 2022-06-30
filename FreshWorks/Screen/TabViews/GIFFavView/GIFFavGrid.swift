//
//  GIFFavGrid.swift
//  FreshWorks
//
//  Created by AftabAhmed on 30/06/22.
//

import SwiftUI

struct GIFFavGrid: View {
    
    var gifImageData: [GIFImageData]
    var rows: Int
    
    @State var shouldRefresh = false
    
    var body: some View {
        if shouldRefresh == true || shouldRefresh == false {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<rows, id: \.self) { row in
                    if row % 2 == 0 {
                        GridEvenRow(row: row, shouldRefresh: $shouldRefresh)
                    } else {
                        GridOddRow(row: row)
                    }
                }
            }
        }
        .padding([.leading, .trailing], 20)
        }
        
    }
}
