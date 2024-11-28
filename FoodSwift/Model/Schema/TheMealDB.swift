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
    var category: String
    var area: String
    var instructions: String
    var tags: String
    var urlVideoMeal: String?
    var ingredientArray: [String] = []
    var measureArray: [String] = []
    var sourceLink: String?

    private enum CodingKeys: String, CodingKey {
        case nameMeal = "strMeal"
        case imageMeal = "strMealThumb"
        case idMeal = "idMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case tags = "strTags"
        case urlVideoMeal = "strYoutube"
        case sourceLink = "strSource"
    }
    
    private struct MutiCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let container2 = try decoder.container(keyedBy: MutiCodingKeys.self)
        var ingredientsArray: [String] = []
        var measureArray: [String] = []
        
//        self.nameMeal = try container.decode(String.self, forKey: .nameMeal)
        self.nameMeal = (try container.decodeIfPresent(String.self, forKey: .nameMeal)?.isEmpty == false) ? try container.decode(String.self, forKey: .nameMeal) : ""
//        self.imageMeal = try container.decode(String.self, forKey: .imageMeal)
        self.imageMeal = (try container.decodeIfPresent(String.self, forKey: .imageMeal)?.isEmpty == false) ? try container.decode(String.self, forKey: .imageMeal) : ""
//        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.idMeal = (try container.decodeIfPresent(String.self, forKey: .idMeal)?.isEmpty == false) ? try container.decode(String.self, forKey: .idMeal) : ""
        self.category = (try container.decodeIfPresent(String.self, forKey: .category)?.isEmpty == false) ? try container.decode(String.self, forKey: .category) : ""
        self.area = (try container.decodeIfPresent(String.self, forKey: .area)?.isEmpty == false) ? try container.decode(String.self, forKey: .area) : ""
        self.instructions = (try container.decodeIfPresent(String.self, forKey: .instructions)?.isEmpty == false) ? try container.decode(String.self, forKey: .instructions) : ""
        self.tags = (try container.decodeIfPresent(String.self, forKey: .tags)?.isEmpty == false) ? try container.decode(String.self, forKey: .tags) : ""
        self.urlVideoMeal = (try container.decodeIfPresent(String.self, forKey: .urlVideoMeal)?.isEmpty == false) ? try container.decode(String.self, forKey: .urlVideoMeal) : "https://youtube.com"
        
        self.sourceLink = (try container.decodeIfPresent(String.self, forKey: .sourceLink)?.isEmpty == false) ?
        try container.decode(String.self, forKey: .sourceLink) : "https://youtube.com"
        
        for index in 1...20 {
            guard let key = MutiCodingKeys(stringValue: "strIngredient\(index)") else { continue }
            if let ingredient = try container2.decodeIfPresent(String.self, forKey: key), !ingredient.isEmpty {
                ingredientsArray.append(ingredient)
            }
        }
        self.ingredientArray = ingredientsArray
        
        for index in 1...20 {
            guard let key = MutiCodingKeys(stringValue: "strMeasure\(index)") else { continue }
            if let measure = try container2.decodeIfPresent(String.self, forKey: key), !measure.isEmpty {
                measureArray.append(measure)
            }
        }
        self.measureArray = measureArray
    }
}
