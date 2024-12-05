//
//  Order.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/11/24.
//

import Foundation

struct OrderMeal {
    var meal: Meal
    var topCustom: String
    var botCustom: String
    var total: Int
}

final class Order {
    var idMeal: String
    var nameMeal: String
    var totalNumberMeal: Int
    var instructions: String
    var priceMeal: Double
    
    init(idMeal: String, nameMeal: String, totalNumberMeal: Int, instructions: String, priceMeal: Double) {
        self.idMeal = idMeal
        self.nameMeal = nameMeal
        self.totalNumberMeal = totalNumberMeal
        self.instructions = instructions
        self.priceMeal = priceMeal
    }
}

struct dummyOrderMeal {
    static let orderMeal: [Order] =
    [
        Order(idMeal: "1", nameMeal: "Pizza", totalNumberMeal: 3, instructions: "Top : More Salt \nBottom : More Sugar \nPlease Ship Fast ASAP", priceMeal: 15.0),
        Order(idMeal: "2", nameMeal: "Hambuger", totalNumberMeal: 15, instructions: "Top : More Salt \nBottom : More Sugar \nPlease Ship Fast ASAP", priceMeal: 5.0),
        Order(idMeal: "3", nameMeal: "Chicken Fried", totalNumberMeal: 10, instructions: "Top : More Salt \nBottom : More Sugar \nPlease Ship Fast ASAP", priceMeal: 12.4),
        Order(idMeal: "4", nameMeal: "Tromisu", totalNumberMeal: 20, instructions: "Top : More Salt \nBottom : More Sugar \nPlease Ship Fast ASAP", priceMeal: 10.0)
    ]
}
