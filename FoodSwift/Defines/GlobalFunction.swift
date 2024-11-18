//
//  GlobalFunction.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/10/24.
//

import Foundation
import UIKit
import SDWebImage

func displayNumber(_ number: Double) -> String {
    // Kiểm tra nếu phần thập phân không bằng 0 (số lẻ dạng Double)
    if number.truncatingRemainder(dividingBy: 1) != 0 {
        return String(number)
    } else {
        return String(Int(number))
    }
}

struct GlobalVariables {
    static var indexNumber = 0
    static var selectedIndexPath: IndexPath? = IndexPath(item: 0, section: 0)
}

enum HeaderFilterType {
    case nationHeader
    case categoryHeader
    case priceRangeHeader
}

struct DetailFollowThemeMealDB {
    
    private func randomPriceMeal() -> Double {
        let decimalArray = Array(stride(from: 1.0, through: 100.0, by: 0.1))
        if let randomtPrice = decimalArray.randomElement() {
            return randomtPrice.rounded(toPlaces: 1)
        }
        return 0.0
    }
    
    private func randomTimeShip() -> String {
        let decimalArray = Array(stride(from: 1, through: 30, by: 1))
        if let randomtTime = decimalArray.randomElement() {
            return "\(randomtTime) Minutes"
        }
        return "1 Minutes"
    }
    
    private func randomRating() -> String {
        let decimalArray = Array(stride(from: 1.0, through: 5.0, by: 0.1))
        if let randomtRating = decimalArray.randomElement() {
            return "\(randomtRating.rounded(toPlaces: 1))"
        }
        return "5"
    }
    
    private func randomTotalVote() -> Int {
        let decimalArray = Array(stride(from: 1, through: 1000, by: 1))
        if let randomTotalVote = decimalArray.randomElement() {
            return randomTotalVote
        }
        return 12345
    }
    
    private func randomFeeShip() -> Double {
        let decimalArray = Array(stride(from: 1.0, through: 10.0, by: 0.1))
        if let randomFeeShip = decimalArray.randomElement() {
            return randomFeeShip.rounded(toPlaces: 1)
        }
        return 96.69
    }
    
    func setDetailDataForThemeMealDB(themeMealDB: TheMealDB) -> Meal {
        let meal = Meal(image: themeMealDB.imageMeal, name: themeMealDB.nameMeal, typeFood: themeMealDB.category, price: randomPriceMeal(), address: themeMealDB.area, nation1: themeMealDB.area, nation2: themeMealDB.area, time: randomTimeShip(), rating: randomRating(), totalVote: randomTotalVote(), fee: randomFeeShip(), idMeal: Int(themeMealDB.idMeal) ?? 69)
        
        return meal
    }
}



