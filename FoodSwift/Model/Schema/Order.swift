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
    var bottomCustom: String
    var quantity: Int
    let email: String
    
    var toFirestoreData: [String: Any] {
        return [
            "account": email,
            "idMeal": meal.idMeal,
            "image": meal.image,
            "name": meal.name,
            "typeFood": meal.typeFood,
            "quantity": quantity,
            "price": meal.price,
            "address": meal.address,
            "nation1": meal.nation1,
            "nation2": meal.nation2,
            "time": meal.time,
            "rating": meal.rating,
            "totalVote": meal.totalVote,
            "feeShip": meal.feeShip,
            "topCustom": topCustom,
            "bottomCustom": bottomCustom
        ]
    }
}
