//
//  ListMealByCategory.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 25/10/24.
//

import Foundation

final class TheMealDB: Codable {
    let nameMeal: String
    let imageMeal: String
    let idMeal: String
//    var category: String
//    var area: String
//    var instructions: String
//    var urlMealThumbnail: String
//    var tags: String
//    var urlVideoMeal: String?
//    var ingredientArray: [String] = []
//    var measureArray: [String] = []
//    var sourceLink: String?

    private enum CodingKeys: String, CodingKey {
        case nameMeal = "strMeal"
        case imageMeal = "strMealThumb"
        case idMeal = "idMeal"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nameMeal = try container.decode(String.self, forKey: .nameMeal)
        self.imageMeal = try container.decode(String.self, forKey: .imageMeal)
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
    }
    
    init(nameMeal: String, imageMeal: String, idMeal: String) {
        self.nameMeal = nameMeal
        self.imageMeal = imageMeal
        self.idMeal = idMeal
    }
}

struct dummyMealByCategory {
    static let mealByCate: [TheMealDB] = 
    [
        TheMealDB(nameMeal: "Baked salmon with fennel & tomatoes", imageMeal: "https://www.themealdb.com/images/media/meals/1548772327.jpg", idMeal: "52959"),
        TheMealDB(nameMeal: "Cajun spiced fish tacos", imageMeal: "https://www.themealdb.com/images/media/meals/uvuyxu1503067369.jpg", idMeal: "52819"),
        TheMealDB(nameMeal: "Escovitch Fish", imageMeal: "https://www.themealdb.com/images/media/meals/1520084413.jpg", idMeal: "52944"),
        TheMealDB(nameMeal: "Fish fofos", imageMeal: "https://www.themealdb.com/images/media/meals/a15wsa1614349126.jpg", idMeal: "53043"),
        TheMealDB(nameMeal: "Fish pie", imageMeal: "https://www.themealdb.com/images/media/meals/ysxwuq1487323065.jpg", idMeal: "52802"),
        TheMealDB(nameMeal: "Fish Soup (Ukha)", imageMeal: "https://www.themealdb.com/images/media/meals/7n8su21699013057.jpg", idMeal: "53079"),
        TheMealDB(nameMeal: "Fish Stew with Rouille", imageMeal: "https://www.themealdb.com/images/media/meals/vptqpw1511798500.jpg", idMeal: "52918"),
        TheMealDB(nameMeal: "Garides Saganaki", imageMeal: "https://www.themealdb.com/images/media/meals/wuvryu1468232995.jpg", idMeal: "52764"),
        TheMealDB(nameMeal: "Grilled Portuguese sardines", imageMeal: "https://www.themealdb.com/images/media/meals/lpd4wy1614347943.jpg", idMeal: "53041"),
        TheMealDB(nameMeal: "Honey Teriyaki Salmon", imageMeal: "https://www.themealdb.com/images/media/meals/xxyupu1468262513.jpg", idMeal: "52773"),
        TheMealDB(nameMeal: "Kedgeree", imageMeal: "https://www.themealdb.com/images/media/meals/utxqpt1511639216.jpg", idMeal: "52887"),
    ]
}
