//
//  ListTableOrderMealTableViewCellVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/11/24.
//

import Foundation

final class ListTableOrderMealTableViewCellVM {
    let order: OrderMeal
    let indexID: Int
    
    init(order: OrderMeal, indexID: Int) {
        self.order = order
        self.indexID = indexID
    }
    
    func summaryPriceMeal() -> String {
        let total = order.quantity
        let price = order.meal.price
        return displayNumber(Double(total) * price)
    }
}
