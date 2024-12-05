//
//  YourOrderViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/11/24.
//

import Foundation

final class YourOrderViewControllerVM {
    var yourOrderTotalPrice: Double = 0
    var totalPrice: Double = 0
    var feeShip: Double = 0
    var listOrderMeals: [OrderMeal] = []
    private(set) var email: String?
    
    init() {
        setUpEmail()
    }
    
    func setUpEmail() {
        email = UserDefaults.standard.string(forKey: UserDefaultsKeys.emailLogin)
    }
    
    func numberOfItemsInSection() -> Int {
        return listOrderMeals.count
    }
    
    func cellForRowAtSection(indexPath: IndexPath) -> ListTableOrderMealTableViewCellVM {
        let item = listOrderMeals[indexPath.row]
        let model = ListTableOrderMealTableViewCellVM(order: item, indexID: indexPath.row + 1)
        return model
    }
    
    func updateYourOrderTotalPrice() {
        listOrderMeals.forEach { order in
            totalPrice = totalPrice + (order.meal.price * Double(order.quantity))
        }
        yourOrderTotalPrice = totalPrice + feeShip
    }
    
    private func fetchDataOrderByEmail(email: String) async -> Result<[[String: Any]], OrderError> {
        do {
            let snapshot = try await db.collection("orderMeal")
                .whereField("account", isEqualTo: email)
                .getDocuments()
            let documents = snapshot.documents
            guard !documents.isEmpty else {
                return .failure(.noDataFound(email: email))
            }
            
            let data = documents.map { $0.data() }
            return .success(data)
        } catch {
            return .failure(.fetchError(error))
        }
    }
    
    func getDataOrderMealByEmail() async -> Result<Bool, OrderError> {
        // Clear existing data
        listOrderMeals.removeAll()
        totalPrice = 0
        feeShip = 0
        yourOrderTotalPrice = 0
        
        guard let email = email else {
            return .failure(.emailNotFound)
        }
        
        let result = await fetchDataOrderByEmail(email: email)
        
        switch result {
        case .success(let orderMeals):
            for item in orderMeals {
                guard let meal = parseMealData(from: item),
                      let orderMeal = parseOrderMealData(from: item, meal: meal) else {
                    return .failure(.parseError)
                }
                listOrderMeals.append(orderMeal)
            }
            return .success(true)
            
        case .failure(let error):
            return .failure(error)
        }
    }

    // Helper methods for parsing
    private func parseMealData(from item: [String: Any]) -> Meal? {
        guard let idMeal = item["idMeal"] as? Int,
              let nameMeal = item["name"] as? String,
              let price = item["price"] as? Double else {
            return nil
        }
        
        let meal = Meal(
            image: item["image"] as? String ?? "",
            name: nameMeal,
            typeFood: item["typeFood"] as? String ?? "",
            price: price,
            address: item["address"] as? String ?? "",
            nation1: item["nation1"] as? String ?? "",
            nation2: item["nation2"] as? String ?? "",
            time: item["time"] as? String ?? "",
            rating: item["rating"] as? String ?? "",
            totalVote: item["totalVote"] as? Int ?? 0,
            fee: item["feeShip"] as? Double ?? 0,
            idMeal: idMeal
        )

        return meal
    }

    private func parseOrderMealData(from item: [String: Any], meal: Meal) -> OrderMeal? {
        guard let email = email else { return nil}
        let orderMeal = OrderMeal(
            meal: meal,
            topCustom: item["topCustom"] as? String ?? "",
            bottomCustom: item["bottomCustom"] as? String ?? "",
            quantity: item["quantity"] as? Int ?? 0, 
            email: email
        )
        return orderMeal
    }
    
//    private func fetchDataOrderByEmail(email: String, completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
//        db.collection("orderMeal").whereField("account", isEqualTo: email).getDocuments { querySnapshot, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
//                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No data order found with Account \(email)"])))
//                return
//            }
//            
//            let data = documents.map { $0.data() }
//                completion(.success(data))
//        }
//    }
//    
//    func getDataOrderMealByEmail(orderCompletion: @escaping (Bool, String) -> Void) {
//        guard let email = email else {
//            orderCompletion(false, "Can't Not Found Your Account")
//            return
//        }
//        fetchDataOrderByEmail(email: email) { [weak self] result in
//            switch result {
//            case .success(let orderMeal):
//                guard let strongSelf = self else { return }
//                var yourOrderMeal: OrderMeal
//                for item in orderMeal {
//                    let idMeal = item["idMeal"] as? Int
//                    let nameMeal = item["name"] as? String
//                    let imageMeal = item["image"] as? String
//                    let typeFood = item["typeFood"] as? String
//                    let price = item["price"] as? Double
//                    let address = item["address"] as? String
//                    let nation1 = item["nation1"] as? String
//                    let nation2 = item["nation2"] as? String
//                    let time = item["time"] as? String
//                    let rating = item["rating"] as? String
//                    let totalVote = item["totalVote"] as? Int
//                    let feeShip = item["feeShip"] as? Double
//                    let topCustom = item["topCustom"] as? String
//                    let botCustom = item["botCustom"] as? String
//                    let total = item["total"] as? Int
//                    let meal = Meal(image: imageMeal ?? "", name: nameMeal ?? "", typeFood: typeFood ?? "", price: price ?? 0, address: address ?? "", nation1: nation1 ?? "", nation2: nation2 ?? "", time: time ?? "", rating: rating ?? "", totalVote: totalVote ?? 0, fee: feeShip ?? 0, idMeal: idMeal ?? 0)
//                    yourOrderMeal = OrderMeal(meal: meal, topCustom: topCustom ?? "", botCustom: botCustom ?? "", total: total ?? 0)
//                    strongSelf.listOrderMeals.append(yourOrderMeal)
//                }
//                orderCompletion(true, "Fetch Order Meal Success")
//            case .failure(let error):
//                orderCompletion(false, "Failed To Fetch Data \(error.localizedDescription)")
//            }
//        }
//    }
}

