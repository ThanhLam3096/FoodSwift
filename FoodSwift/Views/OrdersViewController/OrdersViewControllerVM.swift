//
//  OrdersViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/12/24.
//

import Foundation

final class OrdersViewControllerVM {
    
    var upComingOrder: [OrderMeal] = []
    var passOrder: [OrderMeal] = []
    var isUpComingOrdersEmpty: Bool = false
    var isHistoryOrdersEmpty: Bool = false
    
    private(set) var email: String?
    
    init() {
        setUpEmail()
    }
    
    func setUpEmail() {
        email = UserDefaults.standard.string(forKey: UserDefaultsKeys.emailLogin)
    }
    
    enum YourOrder: Int, CaseIterable  {
        case upComingOrders
        case pastOrders
        
        var title: String {
            switch self {
            case .upComingOrders:
                return "UPCOMING ORDERS"
            case .pastOrders:
                return "PAST ORDERS"
            }
        }
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
        return HeaderOrdersTableViewVM(titleHeader: type.title)
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
    
    func getDataOrderMealByEmail(dbCollection: String) async -> Result<Bool, OrderError> {
        // Clear existing data
        if dbCollection == "orderMeal" {
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
                if dbCollection == "orderMeal" {
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
