//
//  Networking.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/10/24.
//

import Foundation
import UIKit
import Alamofire

struct FeaturePartnesResult {
    var featurePartnes: [Meal]
}

struct NationFoodResult: Decodable {
    var meals: [Meal]
    
    enum CodingKeys: String, CodingKey {
        case meals = "Meal"
    }
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
        // Alamofire from version lower than 6
        AF.request(url).validate().responseJSON { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let value):
                    if let json = value as? JSON {
                        let listFeaturePartnersMeal = json["Meal"] as! [JSON]
                        
                        // Chuyển đổi từ JSON sang đối tượng Meal
                        let nationMeal = listFeaturePartnersMeal.compactMap { Meal(json: $0) }
                        let result = FeaturePartnesResult(featurePartnes: nationMeal)
                        completion(.success(result))
                    } else {
                        completion(.failure(App.String.alertFailedToDataAPI))
                    }
                case .failure(_):
                    completion(.failure(App.String.alertFailedToConnectAPI))
                }
            }
        }
    }
    
    // MARK: - Public Functions Call Data
    func getFoodNation(completion: @escaping APICompletion<NationFoodResult>) {
        guard let url = URL(string: Api.Path.apiNationFoodVietNam) else {
            completion(.failure(App.String.alertFailedAPI))
            return
        }
        AF.request(url).validate().responseDecodable(of: NationFoodResult.self) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(_):
                    if let data = response.data,
                       let jsonString = String(data: data, encoding: .utf8) {
                        print("JSON Response: \(jsonString)")
                    }
                    completion(.failure(App.String.alertFailedToConnectAPI))
                }
            }
        }
    }
    
    //MARK: - downloader
    func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: url) else {
            completion(nil)
            return
        }
        AF.request(imageUrl).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
