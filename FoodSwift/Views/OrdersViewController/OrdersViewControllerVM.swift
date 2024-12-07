//
//  OrdersViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/12/24.
//

import Foundation
import FirebaseFirestore

final class OrdersViewControllerVM {
    
    var upComingOrder: [OrderMeal] = []
    var passOrder: [OrderMeal] = []
    var isUpComingOrdersEmpty: Bool = false
    var isHistoryOrdersEmpty: Bool = false
    
    private var upComingOrderListener: ListenerRegistration?
    private var pastOrderListener: ListenerRegistration?
    
    private(set) var email: String?
    
    init() {
        setUpEmail()
    }
    
    func setUpEmail() {
        email = UserDefaults.standard.string(forKey: UserDefaultsKeys.emailLogin)
    }
    
    func numberOfSections() -> Int {
        return YourOrder.allCases.count
    }
    
    func numberOfItemInSections(type: YourOrder) -> Int {
        switch type {
        case .upComingOrders:
            if upComingOrder.count == 0 {
                return 1
            } else {
                return upComingOrder.count
            }
        case .pastOrders:
            if passOrder.count == 0 {
                return 1
            } else {
                return passOrder.count
            }
        }
    }
    
    func cellForRowAtItemsInSection(indexPath: IndexPath, type: YourOrder) -> OrdersTableViewCellVM {
        switch type {
        case .upComingOrders:
            let item = upComingOrder[indexPath.row]
            return OrdersTableViewCellVM(orders: item)
        case .pastOrders:
            let item = passOrder[indexPath.row]
            return OrdersTableViewCellVM(orders: item)
        }
    }
    
    func cellForHeaderSections(type: YourOrder) -> HeaderOrdersTableViewVM {
        return HeaderOrdersTableViewVM(type: type)
    }
    
    func heightForRowItem(type: YourOrder) -> CGFloat {
        switch type {
        case .upComingOrders:
            if upComingOrder.count == 0 {
                return ScreenSize.scaleHeight(230)
            } else {
                return ScreenSize.scaleHeight(130)
            }
        case .pastOrders:
            if passOrder.count == 0 {
                return ScreenSize.scaleHeight(230)
            } else {
                return ScreenSize.scaleHeight(130)
            }
        }
        
    }
    
    func heightOfHeader() -> CGFloat {
        return ScreenSize.scaleHeight(44)
    }
    
    private func fetchDataOrderByEmail(email: String, dbCollection: String) async -> Result<[[String: Any]], OrderError> {
        do {
            let snapshot = try await db.collection(dbCollection)
                .whereField(App.String.collectionDBAccount, isEqualTo: email)
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
    
    func getDataOrderMealByEmail(dbCollection: String) async -> Result<Bool, OrderError> {
        // Clear existing data
        if dbCollection == App.String.collectionDBOrder{
            upComingOrder.removeAll()
            isUpComingOrdersEmpty = false
        } else {
            isHistoryOrdersEmpty = false
            passOrder.removeAll()
        }
        
        guard let email = email else {
            return .failure(.emailNotFound)
        }
        
        let result = await fetchDataOrderByEmail(email: email, dbCollection: dbCollection)
        
        switch result {
        case .success(let orderMeals):
            for item in orderMeals {
                guard let meal = parseMealData(from: item),
                      let orderMeal = parseOrderMealData(from: item, meal: meal) else {
                    return .failure(.parseError)
                }
                if dbCollection == App.String.collectionDBOrder{
                    upComingOrder.append(orderMeal)
                } else {
                    passOrder.append(orderMeal)
                }
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
}

extension OrdersViewControllerVM {
    func clearOrderMeal(collectionDB: String) async -> Result<Bool, OrderError> {
        do {
            guard let email = email else {
                return .failure(.emailNotFound)
            }
            
            let snapshot = try await db.collection(collectionDB)
                .whereField(App.String.collectionDBAccount, isEqualTo: email)
                .getDocuments()
            
            if snapshot.documents.isEmpty {
                return .failure(.noDataFound(email: email))
            }
            
            for document in snapshot.documents {
                try await document.reference.delete()
            }
            if collectionDB == App.String.collectionDBOrder{
                upComingOrder.removeAll()
                isUpComingOrdersEmpty = true
            } else {
                isHistoryOrdersEmpty = true
                passOrder.removeAll()
            }
            return .success(true)
        } catch {
            return .failure(.saveHistoryError(error))
        }
    }
}

extension OrdersViewControllerVM {
    func listenToOrderChanges(dbCollection: String, completion: @escaping (Result<Bool, OrderError>) -> Void) {
        guard let email = email else {
            completion(.failure(.emailNotFound))
            return
        }
        
        let listener = db.collection(dbCollection)
            .whereField(App.String.collectionDBAccount, isEqualTo: email)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    completion(.failure(.fetchError(error)))
                    return
                }
                
                guard let snapshot = snapshot else {
                    completion(.failure(.noDataFound(email: email)))
                    return
                }
                
                // Clear existing data
                if dbCollection == App.String.collectionDBOrder {
                    self.upComingOrder.removeAll()
                    self.isUpComingOrdersEmpty = snapshot.documents.isEmpty
                } else {
                    self.passOrder.removeAll()
                    self.isHistoryOrdersEmpty = snapshot.documents.isEmpty
                }
                
                // Parse new data
                for document in snapshot.documents {
                    let data = document.data()
                    if let meal = self.parseMealData(from: data),
                       let orderMeal = self.parseOrderMealData(from: data, meal: meal) {
                        if dbCollection == App.String.collectionDBOrder {
                            self.upComingOrder.append(orderMeal)
                        } else {
                            self.passOrder.append(orderMeal)
                        }
                    }
                }
                
                completion(.success(true))
            }
        
        // Lưu listener
        if dbCollection == App.String.collectionDBOrder {
            upComingOrderListener = listener
        } else {
            pastOrderListener = listener
        }
    }
    
    // Thêm method để remove listeners khi không cần thiết
    func removeListeners() {
        upComingOrderListener?.remove()
        pastOrderListener?.remove()
        upComingOrderListener = nil
        pastOrderListener = nil
    }
}
