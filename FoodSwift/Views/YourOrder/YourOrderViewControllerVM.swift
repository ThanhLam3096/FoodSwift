//
//  YourOrderViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/11/24.
//

import Foundation

final class YourOrderViewControllerVM {
    let listMealOrder: [Order] = dummyOrderMeal.orderMeal
    var yourOrderTotalPrice: Double = 0
    var feeShip: Double = 0
    
    func numberOfItemsInSection() -> Int {
        return listMealOrder.count
    }
    
    func cellForRowAtSection(indexPath: IndexPath) -> ListTableOrderMealTableViewCellVM {
        let item = listMealOrder[indexPath.row]
        let model = ListTableOrderMealTableViewCellVM(listOrder: item, indexID: indexPath.row + 1)
        return model
    }
    
    func yourOrderTotalPrice(isHaveFeeShip: Bool) -> Double {
        listMealOrder.forEach { order in
            yourOrderTotalPrice = yourOrderTotalPrice + (order.priceMeal * Double(order.totalNumberMeal))
        }
        return isHaveFeeShip == true ? yourOrderTotalPrice + feeShip : yourOrderTotalPrice
    }
}
