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
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.image = try container.decode(String.self, forKey: .image)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.address = try container.decode(String.self, forKey: .address)
//        self.nation1 = try container.decode(String.self, forKey: .nation1)
//        self.nation2 = try container.decode(String.self, forKey: .nation2)
//        self.time = try container.decode(String.self, forKey: .time)
//        self.rating = try container.decode(String.self, forKey: .rating)
//        self.fee = try container.decode(Double.self, forKey: .fee)
//        self.idMeal = try container.decode(String.self, forKey: .idMeal)
//    }
   
//    enum CodingKeys: String, CodingKey {
//        case image = "image"
//        case name = "name"
//        case address = "address"
//        case nation1 = "nation1"
//        case nation2 = "nation2"
//        case time = "time"
//        case rating = "rating"
//        case fee = "fee"
//        case idMeal = "idMeal"
//    }
}

struct dummyMealFeaturePartnes {
//    static let featurePartnesMeal: [Meal] = 
//    [
//        Meal(json: <#JSON#>, image: "https://www.holidify.com/images/cmsuploads/compressed/c700x420_20181227132950.jpg", name: "Sushi", address: "Tokyo, Japan", nation1: "Japan", nation2: "Japan", time: "10min", rating: "5.0", fee: 1, idMeal: "0"),
//        Meal(image: "https://www.holidify.com/images/cmsuploads/compressed/8896564-16x9-large_20181227133052.jpg", name: "Rendang", address: "Jakarta, Indonesia", nation1: "Indonesia", nation2: "Malaysia", time: "14min", rating: "4.4", fee: 0.6, idMeal: "1"),
//        Meal(image: "https://www.holidify.com/images/cmsuploads/compressed/shoyu-ramen_20181227133143.jpg", name: "Ramen", address: "Kyoto, Japan", nation1: "Japan", nation2: "Japan", time: "12min", rating: "5.0", fee: 0, idMeal: "2"),
//        Meal(image: "https://www.holidify.com/images/cmsuploads/compressed/R00067_Tom-Yum-Goong_20181227133333.jpg", name: "Tom Yam Goong", address: "Bangkok, ThaiLand", nation1: "ThaiLand", nation2: "Myanmar", time: "14min", rating: "4.2", fee: 1, idMeal: "3"),
//        Meal(image: "https://www.holidify.com/images/cmsuploads/compressed/wmkj5fafebzkxpwhuzg6_20181227133752.jpeg", name: "Phở", address: "Ha noi, Vietnam", nation1: "Viet Nam", nation2: "Viet Nam", time: "12min", rating: "5.0", fee: 0.5, idMeal: "4"),
//        Meal(image: "https://www.holidify.com/images/cmsuploads/compressed/bacon-kebabs-13-2_20181227133457.jpg", name: "Kebab", address: "Turkey", nation1: "Turkey", nation2: "Bugary", time: "10min", rating: "5.0", fee: 0.5, idMeal: "5"),
//        Meal(image: "https://www.holidify.com/images/cmsuploads/compressed/peking-duck-10916-1_20181227133910.jpg", name: "Peking duck", address: "Bac Kinh, China", nation1: "China", nation2: "Chong Ching", time: "5min", rating: "3.0", fee: 0, idMeal: "6"),
//        Meal(image: "https://www.holidify.com/images/cmsuploads/compressed/mixed-seafood-paella_20181227133958.jpeg", name: "Paella", address: "Madrid, Spain", nation1: "Spain", nation2: "Porture", time: "10min", rating: "5.0", fee: 1, idMeal: "7"),
//        Meal(image: "https://www.holidify.com/images/cmsuploads/compressed/steakandkidneypie_73308_16x9_20181227134043.jpg", name: "Steak and Kidney Pie", address: "London, England", nation1: "England", nation2: "France", time: "12min", rating: "5.0", fee: 0, idMeal: "8"),
//        Meal(image: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fpublic-assets.meredithcorp.io%2Ff926647f3c831a8bb7a3024468adfd8f%2F1687043234863Screenshot_20230618_090145_Chrome.jpg&q=60&c=sc&orient=true&poi=auto&h=512", name: "Chicken", address: "New York, USA", nation1: "England", nation2: "America", time: "22min", rating: "3.0", fee: 12, idMeal: "9"),
//        Meal(image: "https://cdn.tgdd.vn/Files/2020/12/26/1316162/cach-lam-pizza-pate-thom-ngon-nuc-mui-ai-an-cung-me-202012261006404180.jpg", name: "Pizza", address: "Roma, Italia", nation1: "America", nation2: "Italia", time: "22min", rating: "4.0", fee: 14, idMeal: "10"),
//        Meal(image: "https://hapinut.com/wp-content/uploads/2022/03/mi-quang-quang-nam.jpg", name: "Mỳ Quảng", address: "Quảng Nam, Việt Nam", nation1: "Việt Nam", nation2: "Việt Nam", time: "20min", rating: "5.0", fee: 20, idMeal: "11"),
//        Meal(image: "https://img-global.cpcdn.com/recipes/da2ad5d76d683cf3/1360x964cq70/bun-ch%E1%BA%A3-ca-da-n%E1%BA%B5ng-recipe-main-photo.webp", name: "Bún Chả Cá", address: "Đà Nẵng, Việt Nam", nation1: "Việt Nam", nation2: "Việt Nam", time: "15min", rating: "5.0", fee: 5, idMeal: "12"),
//        Meal(image: "https://blogdulich.net/wp-content/uploads/2021/12/banh-mi-ba-lan-da-nang-6-1377x1536.jpeg", name: "Bánh Mỳ", address: "Đà Nẵng, Việt Nam", nation1: "Việt Nam", nation2: "Việt Nam", time: "15min", rating: "5.0", fee: 5, idMeal: "13"),
//    ]
}
