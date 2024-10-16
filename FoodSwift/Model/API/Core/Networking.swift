//
//  Networking.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/10/24.
//

import Foundation

import Foundation
import UIKit

struct FeaturePartnesResult {
    var featurePartnes: [Meal]
}

struct NationFoodResult {
    var nationFood: [Meal]
}

//MARK: Enum
enum APIResult<T> {
    case failure(String)
    case success(T)
}

//MARK: Typealias
typealias APICompletion<T> = (APIResult<T>) -> Void

final class Networking {
    //MARK: - singleton
    private static var sharedNetworking: Networking = {
        let networking = Networking()
        return networking
    }()
    
    class func shared() -> Networking {
        return sharedNetworking
    }
    
    //MARK: - init
    private init() { }
    
    //MARK: - request
    func request(with urlString: String, completion: @escaping (Data?, APIError?) -> Void) {
        guard let url = URL(string: urlString) else {
            let error = APIError.error("URL lỗi")
            completion(nil, error)
            return
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, APIError.error(error.localizedDescription))
                } else {
                    if let data = data {
                        completion(data, nil)
                    } else {
                        completion(nil, APIError.error("Data format is error."))
                    }
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Public Functions Call Data
    func getFeaturePartners(completion: @escaping APICompletion<FeaturePartnesResult>) {
        guard let url = URL(string: Api.Path.apiFeaturedParners) else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(App.String.alertFailedToConnectAPI))
                } else {
                    do {
                        // Parse dữ liệu JSON thành mảng Meal
                        let listMealFeaturePartners = try JSONDecoder().decode([Meal].self, from: data!)
                        let result = FeaturePartnesResult(featurePartnes: listMealFeaturePartners)
                        completion(.success(result))
                    } catch {
                        completion(.failure(App.String.alertFailedToDataAPI))
                    }
                    //                    if let data = data, let arrayJson = data.toArrayJSON() {
                    //                        for json in arrayJson {
                    //                            let featurePartners = json["featurePartners"] as! [JSON]
                    //                            var listMealFeaturePartners: [Meal] = []
                    //                            for item in featurePartners {
                    //                                let mealFeaturePartner = Meal(json: item)
                    //                                listMealFeaturePartners.append(mealFeaturePartner)
                    //                                let result = FeaturePartnesResult(featurePartnes: listMealFeaturePartners)
                    //                                completion(.success(result))
                    //                            }
                    //                        }
                    //                        completion(.success(FeaturePartnesResult(featurePartnes: [])))
                    //                    }
                    //                    else {
                    //                        completion(.failure(App.String.alertFailedToDataAPI))
                    //                    }
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Public Functions Call Data
    func getFoodNation(completion: @escaping APICompletion<NationFoodResult>) {
        guard let url = URL(string: Api.Path.apiNationFoodVietNam) else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(App.String.alertFailedToConnectAPI))
                } else {
                    if let data = data, let json = data.toJSON() {
                        let listNationMeal = json["Meal"] as! [JSON]
                        var nationMeal: [Meal] = []
                        for item in listNationMeal {
                            let mealFeaturePartner = Meal(json: item)
                            nationMeal.append(mealFeaturePartner)
                        }
                        let result = NationFoodResult(nationFood: nationMeal)
                        completion(.success(result))
                    }
                    else {
                        completion(.failure(App.String.alertFailedToDataAPI))
                    }                }
            }
        }
        task.resume()
    }
    
    //MARK: - downloader
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(nil)
                } else {
                    if let data = data {
                        let image = UIImage(data: data)
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        task.resume()
    }
}
