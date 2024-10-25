//
//  ListMealForTypeTableViewCellVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 25/10/24.
//

import Foundation

final class ListMealForTypeTableViewCellVM {
    let mealByCategory: MealByCategory
    
    init(mealByCategory: MealByCategory) {
        self.mealByCategory = mealByCategory
    }
    
    func randomDecimal() -> Double {
        return Double.random(in: 1.0...10.0).rounded(toPlaces: 1)
    }
}
