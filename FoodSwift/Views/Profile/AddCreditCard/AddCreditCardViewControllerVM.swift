//
//  AddCreditCardViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 20/11/24.
//

import Foundation

final class AddCreditCardViewControllerVM {
    var isHaveCard: Bool?
    var dummyListDefaultCard: [Bool] = [true, false, false]
    
    func numberOfItemInSection() -> Int {
        return CreditCardType.allCases.count
    }
    
    func cellForRowAtItem(indexPath: IndexPath, isDefault: Bool) -> CreditCardTableViewCellVM {
        let cardType = CreditCardType.allCases[indexPath.row]
        let model = CreditCardTableViewCellVM(typeCard: cardType, isDefault: dummyListDefaultCard[indexPath.row])
        return model
    }
    
    func heightForRow() -> CGFloat {
        return ScreenSize.scaleHeight(72)
    }
}
