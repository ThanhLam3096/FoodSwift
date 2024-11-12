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
        static let apiFeaturedParners = "https://script.googleusercontent.com/macros/echo?user_content_key=7pqI4LIMMq1wbrG9BD6avdU05Gi-a2NiW5bNS8z5F9gZ8nG4_2V04NtarsghOBDsfVttDH9HxM3EKkEhafgRfG2kciTcdFa6m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnBicm-1L8GQvBXRO6lOYIGcU92wN7DcHffdEBze-Y8a0iYKG0-RGgruFqqMVhRuKOzu3qncCFOo6ntGVCG0niEwb5y643CY0itz9Jw9Md8uu&lib=MGkmMVj97Ih2t4r2Gme6j89nrfDW60jj6"
        static let apiNationFoodVietNam = "https://script.googleusercontent.com/macros/echo?user_content_key=s5mrA8kQKlWmQ4bLsr83NG_kJ7X4U6y7G828-IEwDkiWz-03uI0roNYQ-mqP5fIBiAk9d6ks4zznap5NyBZXuNYwGPNpLYzcm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnJP9Xt2fiW6tKoYsGrqOpUTMqmxQvImK5tf0U3n-wf9KXhcol35qQGc_Y5nL7JvBde9Q7cjnQxAoM7B9dIbEIBD7g6eT26mQ8tz9Jw9Md8uu&lib=MGkmMVj97Ih2t4r2Gme6j89nrfDW60jj6"
        static let apiListRestaurant = "https://script.googleusercontent.com/macros/echo?user_content_key=G6p3C_QcxyudR7YxT57F7Cfzv0-9lVCcYUBvDCsAqtB3H9Q6_wQwbytfUm-RZGb92xe19b6Xnj71MgAgayP9m-irPdOB9r0hm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnBYo8324HnXUdUdsY8LihXEthlDyrMEc5LCnnsy3OyapyFN6abHfb9ad_Bm-K6YeXVAip56__hZls5PBx2WXgCOsPr2_UG_zltz9Jw9Md8uu&lib=MGkmMVj97Ih2t4r2Gme6j89nrfDW60jj6"
    }
}
