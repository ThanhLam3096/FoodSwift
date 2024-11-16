//
//  HeaderFilterCollectionViewCellVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 15/11/24.
//

import Foundation

final class HeaderFilterCollectionViewCellVM {
    let title: String
    let headerType: HeaderFilterType
    
    init(title: String, headerType: HeaderFilterType) {
        self.title = title
        self.headerType = headerType
    }
}
