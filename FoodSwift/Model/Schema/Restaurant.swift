//
//  Restaurant.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 14/10/24.
//

import Foundation

struct Restaurant: Codable {
    let image: String
    let name: String
    let branch1: String
    let branch2: String
    let typeFood: String
    let rating: String
    let numberRating: String
    let time: String
    let feeDelivery: String
    let averagePrice: Double
    let id: String
}

struct dummyRestaurant {
    static let listAllRes: [Restaurant] =
    [
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/Noma-Copenhagen-Denmark.jpg?w=1136&ssl=1", name: "Noma, Copenhagen, Denmark", branch1: "Chinese", branch2: "American", typeFood: "Deshi Food", rating: "4.3", numberRating: "200+ Ratings", time: "10 Min", feeDelivery: "Free", averagePrice: 42, id: "1"),
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/El-Celler-de-Can-Roca-Girona-Spain.jpg?w=1172&ssl=1", name: "El Celler de Can Roca, Girona, Spain", branch1: "France", branch2: "Spain", typeFood: "Vegec Food", rating: "5.0", numberRating: "210+ Ratings", time: "14 Min", feeDelivery: "2$", averagePrice: 50, id: "2"),
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/Mirazur-Menton-France.jpg?w=1200&ssl=1", name: "Osteria Francescana, Modena", branch1: "Italian", branch2: "Russian", typeFood: "Fast Food", rating: "5.0", numberRating: "500+ Ratings", time: "12 Min", feeDelivery: "2$", averagePrice: 42, id: "3"),
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/Steirereck-Vienna-Austria.jpg?w=1024&ssl=1", name: "Steirereck, Vienna", branch1: "Austria", branch2: "American", typeFood: "Drink Food", rating: "3.3", numberRating: "120+ Ratings", time: "20 Min", feeDelivery: "Free", averagePrice: 50, id: "4"),
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/Restaurant-Gordon-Ramsay-London-UK.jpg?w=1200&ssl=1", name: "Restaurant Gordon Ramsay", branch1: "Canada", branch2: "American", typeFood: "Food", rating: "4.8", numberRating: "400+ Ratings", time: "14 Min", feeDelivery: "4$", averagePrice: 100, id: "5"),
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/Narisawa-Tokyo-Japan.jpg?w=1000&ssl=1", name: "Narisawa, Tokyo, Japan", branch1: "Tokyo", branch2: "Asian", typeFood: "Soil Soup’ and ‘Water Salad", rating: "4.3", numberRating: "210+ Ratings", time: "20 Min", feeDelivery: "Free", averagePrice: 102, id: "6"),
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/Indian-Accent-New-Delhi-India.jpg?w=1200&ssl=1", name: "Indian Accent", branch1: "India", branch2: "Singapo", typeFood: "Foie Gras Stuffed Galawat", rating: "3.3", numberRating: "140+ Ratings", time: "8 Min", feeDelivery: "5$", averagePrice: 96, id: "7"),
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/Karavalli-Bangalore-India.jpg?w=1024&ssl=1", name: "Karavalli, Bangalore", branch1: "India", branch2: "Thailand", typeFood: "Black Pomfret in Green Masala", rating: "2.3", numberRating: "20+ Ratings", time: "10 Min", feeDelivery: "Free", averagePrice: 69, id: "8"),
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/Singapore-Flyer-Sky-Dining-Singapore.jpg?w=1200&ssl=1", name: "Singapore Flyer Sky Dining", branch1: "Singapore", branch2: "Singapore", typeFood: "Deshi Food", rating: "2.3", numberRating: "200+ Ratings", time: "10 Min", feeDelivery: "Free", averagePrice: 33, id: "9"),
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/Ithaa-Undersea-Restaurant-Maldives.jpg?w=960&ssl=1", name: "Ithaa Undersea Restaurant, Maldives", branch1: "VietNam", branch2: "Lao", typeFood: "Food and CockTail", rating: "5.0", numberRating: "800+ Ratings", time: "30 Min", feeDelivery: "3$", averagePrice: 55, id: "10"),
        Restaurant(image: "https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2023/07/Soneva-Kiri-Treepod-Dining-Thailand.jpg?w=1200&ssl=1", name: "Soneva Kiri Treepod Dining", branch1: "ThaiLand", branch2: "Myammar", typeFood: "Fast Food", rating: "4.3", numberRating: "200+ Ratings", time: "10 Min", feeDelivery: "Free", averagePrice: 77, id: "11"),
    ]
}
