//
//  GIFFavGrid.swift
//  FreshWorks
//
//  Created by AftabAhmed on 30/06/22.
//

import SwiftUI

/// This view loads the favorites in Grid style
struct GIFFavGrid: View {
    
    var rows: Int
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<rows, id: \.self) { row in
                    if row % 2 == 0 {
                        GridEvenRow(row: row)
                    } else {
                        GridOddRow(row: row)
                    }
                }
            }
        }.padding([.leading, .trailing], 20)
    }
}
