//
//  OrdersTableViewCellVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/12/24.
//

import Foundation

final class OrdersTableViewCellVM {
    let orders: OrderMeal
    
    init(orders: OrderMeal) {
        self.orders = orders
    }
    
    func getTotalPriceMeal() -> String {
        let quantity = orders.quantity
        let price = orders.meal.price
        return "Dollars$\(displayNumber(Double(quantity) * price))"
    }
}
