//
//  SearchFilter.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 16/11/24.
//

import Foundation

struct SearchFilter: Codable {
    var account: String
    var filterSearchNation: [String]
    var filterSearchCategory: [String]
    var filterSearchPriceRange: [String]
    var indexPathSearchNation: [IndexPath]
    var indexPathSearchCategory: [IndexPath]
    var indexPathSearchPriceRange: [IndexPath]
}
