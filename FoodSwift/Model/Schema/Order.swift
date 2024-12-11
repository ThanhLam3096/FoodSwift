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

let sushiMeal: Meal = Meal(image: "https://www.holidify.com/images/cmsuploads/compressed/c700x420_20181227132950.jpg", name: "Sushi", typeFood: "Sea Food", price: 5, address: "Tokyo, Japan", nation1: "Japan", nation2: "Japan", time: "10min", rating: "5.0", totalVote: 1123, fee: 1, idMeal: 0)
let ramenMeal: Meal = Meal(image: "https://www.holidify.com/images/cmsuploads/compressed/shoyu-ramen_20181227133143.jpg", name: "Ramen",typeFood: "Noodles",price: 5 ,address: "Kyoto, Japan", nation1: "Japan", nation2: "Japan", time: "12min", rating: "5.0", totalVote: 1123, fee: 0, idMeal: 2)

struct DummyOrderData {
    
    static let dummyOrderData: [OrderMeal] =
    [
        OrderMeal(meal: sushiMeal, topCustom: "Need More Fish", bottomCustom: "Need More Fish", quantity: 18, email: "haha@gmail.com"),
        OrderMeal(meal: ramenMeal, topCustom: "No Meat", bottomCustom: "No Eggs", quantity: 10, email: "haha@gmail.com"),
        OrderMeal(meal: ramenMeal, topCustom: "More Meat", bottomCustom: "More Eggs", quantity: 10, email: "haha@gmail.com"),
        OrderMeal(meal: sushiMeal, topCustom: "No Salt", bottomCustom: "No sugar", quantity: 10, email: "haha@gmail.com"),
    ]
}
