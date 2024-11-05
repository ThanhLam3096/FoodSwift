//
//  HeaderChoiceMealTableViewVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 3/11/24.
//

import Foundation

final class HeaderChoiceMealTableViewVM {
    let section: Int
    let title: String
    let data: String
    
    init(section: Int, title: String, data: String) {
        self.section = section
        self.title = title
        self.data = data
    }
}
