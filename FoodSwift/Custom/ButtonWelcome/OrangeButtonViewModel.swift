//
//  OrangeButtonViewModel.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/11/24.
//

import Foundation

final class OrangeButtonViewModel {
    let title: String
    var totalPriceMeal: Double?
    let isEnableButton: Bool
    
    init(title: String, totalPriceMeal: Double? = nil, isEnableButton: Bool = true) {
        self.title = title
        self.totalPriceMeal = totalPriceMeal
        self.isEnableButton = isEnableButton
    }
}
