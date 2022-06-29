//
//  GIFViewModel.swift
//  FreshWorks
//
//  Created by AftabAhmed on 28/06/22.
//

import SwiftUI

class GIFViewModel: ObservableObject {
    
    @Published var gifImageData: [GIFImageData] = []
    @Published var favGifImageData: [GIFImageData] = []
    
    func fetch() {
        Task { [weak self] in
            guard let self = self else {return}
            let fetcher = GIFFetcher()
            do {
                let gImageData = try await fetcher.fetchGIF() ?? []
                DispatchQueue.main.async {
                    self.gifImageData = gImageData
                    self.loadFavoriteGIFImageData()
                }
            } catch {
                gifImageData = []
                print("Error", error)
            }
        }
    }
    
    func search(_ txt: String) {
        Task { [weak self] in
            guard let self = self else {return}
            let search = GIFSearch()
            do {
                let gImageData = try await search.searchGIF(txt) ?? []
                DispatchQueue.main.async {
                    self.gifImageData = gImageData
                    self.loadFavoriteGIFImageData()
                }
            } catch {
                gifImageData = []
                print("Error", error)
            }
        }
    }
    
    func loadFavoriteGIFImageData() {
        favGifImageData = gifImageData.compactMap{
            DefaultsHelper.isFavoriteFor($0.id ?? "") ? $0 : nil
        }
    }
    
    func numberOfRowsForFavoriteGrid() -> Int {
        let total = favGifImageData.count
        
        //3+2 = 5 items for 2 rows
        var num = total/5 * 2
        
        //Remainder
        let rem = total % 5
        
        if rem > 3 {
            num += 2
        } else if rem > 0{
            num += 1
        }
        
        return num
    }
    
    func itemWidthForCol(_ col: Int, row: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        
        let threeColItemWidth = (screenWidth - 80)/3.0      //20 + Item + 20 + Item + 20 + Item + 20
        let twoColItemWidth = threeColItemWidth * 2 + 20    //Doundle above + 20
        
        if row % 2 == 0 {
            return threeColItemWidth
        } else {
            if row % 4 == 1 {
                if col == 0 {
                    return twoColItemWidth
                } else {
                    return threeColItemWidth
                }
            } else {
                if col == 1 {
                    return twoColItemWidth
                } else {
                    return threeColItemWidth
                }
            }
        }
    }
}
