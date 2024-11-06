//
//  ListTableOrderMealTableViewCellVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/11/24.
//

import Foundation

final class ListTableOrderMealTableViewCellVM {
    let listOrder: Order
    let indexID: Int
    
    init(listOrder: Order, indexID: Int) {
        self.listOrder = listOrder
        self.indexID = indexID
    }
    
    func summaryPriceMeal() -> String {
        return displayNumber(listOrder.priceMeal * Double(listOrder.totalNumberMeal))
    }
}
