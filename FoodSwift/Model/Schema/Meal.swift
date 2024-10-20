//
//  Meal.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/10/24.
//

import Foundation

final class Meal: Codable {
    var image: String
    var name: String
    var address: String
    var nation1: String
    var nation2: String
    var time: String
    var rating: String
    var fee: Double
    var idMeal: String
    
    init(json: JSON) {
        self.image = json["image"] as! String
        self.name = json["name"] as! String
        self.address = json["address"] as! String
        self.nation1 = json["nation1"] as! String
        self.nation2 = json["nation2"] as! String
        self.time = json["time"] as! String
        self.rating = json["rating"] as! String
        self.fee = json["fee"] as! Double
        self.idMeal = json["idMeal"] as! String
    }
}
