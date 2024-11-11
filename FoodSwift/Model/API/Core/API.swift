//
//  API.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 15/10/24.
//

import Foundation

enum APIError: Error {
    case error(String)
    case errorURL
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .errorURL:
            return "URL String is error."
        }
    }
}

final class Api {
    struct Path {
        static let pathURL = "https://www.themealdb.com/api/json/v1/1/"
        static let apiListCategory = "\(pathURL)categories.php"
        static let apiMealCategoryAndArea = "\(pathURL)filter.php?"
        static let apiListArea = "\(pathURL)list.php?a=list"
        static let apiDetailMeal = "\(pathURL)lookup.php?"
        static let apiRandomMeal = "\(pathURL)random.php"
        static let apiSearchFirstLetter = "\(pathURL)search.php?f="
        static let apiSearchByName = "\(pathURL)search.php?s="
        static let apiFeaturedParners = "https://api.mockfly.dev/mocks/aa0c8076-dde6-4033-9b08-d650fb314417/featuredPartnersMeal"
        static let apiNationFoodVietNam = "https://api.mockfly.dev/mocks/aa0c8076-dde6-4033-9b08-d650fb314417/VietNamMeal"
        static let apiListRestaurant = "https://api.mockfly.dev/mocks/aa0c8076-dde6-4033-9b08-d650fb314417/famousRestaurant"
    }
}
