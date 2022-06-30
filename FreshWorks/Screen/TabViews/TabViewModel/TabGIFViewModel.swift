//
//  GIFViewModel.swift
//  FreshWorks
//
//  Created by AftabAhmed on 28/06/22.
//

import SwiftUI

/// This class is the sole view model for the 2 Tabs
class TabGIFViewModel: ObservableObject {
    
    @Published var gifImageData: [GIFImageData] = []
    @Published var favGifImageData: [GIFImageData] = []
    
    /// This method fetches the gif image data from filesystem. If it doesnt exist there, then from network. It also stores the value in the filesystem if it fetches it from the network.
    func fetch() {
        Task { [weak self] in
            guard let self = self else {return}
            let fetcher = GIFFetcher()
            do {
                let gImageData = try await fetcher.fetchGIF() ?? []
                self.loadGIFImageData(gImageData)
            } catch {
                gifImageData = []
                print("Error", error)
            }
        }
    }
    
    /// This method fetches the gif image data for the input tsearch text, from filesystem. If it doesnt exist there, then from network. It also stores the value in the filesystem if it fetches it from the network.
    /// - Parameter txt: String
    func search(_ txt: String) {
        Task { [weak self] in
            guard let self = self else {return}
            let search = GIFSearch()
            do {
                let gImageData = try await search.searchGIF(txt) ?? []
                self.loadGIFImageData(gImageData)
            } catch {
                gifImageData = []
                print("Error", error)
            }
        }
    }
}

extension TabGIFViewModel {
    
    /// This is a helper method to load GIF Image Data into the published variables
    /// - Parameter gImageData: [GIFImageData]
    private func loadGIFImageData(_ gImageData: [GIFImageData]) {
        DispatchQueue.main.async {
            self.gifImageData = gImageData
            self.loadFavoriteGIFImageData()
        }
    }
    
    /// This is a helper method to load the favorites after checking against the user defaults.
    func loadFavoriteGIFImageData() {
        favGifImageData = gifImageData.compactMap{
            DefaultsHelper.isFavoriteFor($0.id ?? "") ? $0 : nil
        }
    }
}

extension TabGIFViewModel {
    
    /// This method calculates the number of rows required for the grid layout based on 3,2,3.. rows pattern
    /// - Returns: Int
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
    
    /// This method calculates the grid item width based on the column and row inputs
    /// - Parameters:
    ///   - col: Int
    ///   - row: Int
    /// - Returns: CGFloat
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
