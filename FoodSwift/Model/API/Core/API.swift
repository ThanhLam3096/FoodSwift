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
        static let apiCategory = "\(pathURL)list.php?c=list"
        static let apiFeaturedParners = "https://script.googleusercontent.com/macros/echo?user_content_key=P046I1YW3atsqChF1XhzWoTqIgF1BXkXNfuLtLY_uSUhGt24qjyZn_A7Wx40rDDLcjPb8lHxJfxLDxoYpS1SeQClh-7m9R8tm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnON9VSLTvdLpcIG9dMI2L1tyOesJinI-z8-vsE-8oxQGR8OIZr9M7ITwW4GESKFyT-E4rGBA0YVCT2ogLOi-aEBO-mJ-qnSFFNz9Jw9Md8uu&lib=MGkmMVj97Ih2t4r2Gme6j89nrfDW60jj6"
        static let apiNationFoodVietNam = "https://script.googleusercontent.com/macros/echo?user_content_key=XEJeUrmOYjrV1j5hLI2uvX_zdQdclb-gYg0yyWHsItbpIPrzI0f5qG696Y3AGxDhv0jPJ-WF6DRwet77YozEA-oZTqchylGOm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnIaJpPGaMQGBCc3GKfvIW1zm_NslFuyZTofQFpGPUTtdh9fXsFUF6ldvDZnJiDtj7hT7cQiaw-85Vkrj_Mi6N8rTVqIu-xo5U9z9Jw9Md8uu&lib=MGkmMVj97Ih2t4r2Gme6j89nrfDW60jj6"
        static let apiListRestaurant = "https://script.googleusercontent.com/macros/echo?user_content_key=kgK1TG7O6XjSBcylbl7NRENE2v243fzY58WdKhmj4Uflycws1Pf_w7f48qSGtL-4Obcz1adqb-yR10RN0AXebRd7wc3P7Viam5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnEN8auk81tUBggPxOBsieWcN7qxeXBz0v5FR_F91w4Zf1iu77No0kMI9S_h97Q40c4sqHHl2ftKW9eheW2hLi2RTdNsk-sm5Dtz9Jw9Md8uu&lib=MGkmMVj97Ih2t4r2Gme6j89nrfDW60jj6"
    }
}
