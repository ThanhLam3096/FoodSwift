//
//  CreditCardTableViewCellVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 20/11/24.
//

import Foundation

final class CreditCardTableViewCellVM {
    let typeCard: CreditCardType
    let isDefault: Bool
    
    init(typeCard: CreditCardType, isDefault: Bool) {
        self.typeCard = typeCard
        self.isDefault = isDefault
    }
}
