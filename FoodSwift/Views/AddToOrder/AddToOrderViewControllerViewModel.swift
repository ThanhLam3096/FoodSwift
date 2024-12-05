//
//  AddToOrderViewControllerViewModel.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 3/11/24.
//

import Foundation

final class AddToOrderViewControllerViewModel {
    
    // MARK: Properties
    var meal: Meal?
    
    var numberOfMeals = 1
    var infoTopCustomMeal = ""
    var infoBottomCustomMeal = ""
    var addIntructionMealOrder = ""
    var topCustomMealIndexPatch: IndexPath?
    var bottomCustomMealIndexPatch: IndexPath?
    var allInfoCustomMealOrder = ""
    private(set) var email: String?
    
    init() {
        setUpEmail()
    }
    
    init(meal: Meal) {
        self.meal = meal
        setUpEmail()
    }
    
    enum SectionType: Int {
        case top = 0
        case bottom
        case addInstruction
    }
    var sections: [SectionType] = [.top, .bottom, .addInstruction]
    
    let listChoice = ["Chocolate Chip",
                      "Cookies and Cream",
                      "Funfetti",
                      "M and M",
                      "Red Velvet",
                      "Peanut Butter",
                      "Snickerdoodle",
                      "White Chocolate Macadamia"
                    ]
    func updateOrderInfoMeal() -> String {
        allInfoCustomMealOrder = "Top : \(infoTopCustomMeal) \nBottom : \(infoBottomCustomMeal) \n\(addIntructionMealOrder)"
        return allInfoCustomMealOrder
    }
    
    func updateNumberOfMeals(numberOfMeals: Int) -> String {
        return String(format: "%02d", numberOfMeals)
    }
    
    func minusAction() {
        if numberOfMeals > 1 {
            numberOfMeals = numberOfMeals - 1
        } else {
            numberOfMeals = 1
        }
    }
    
    func plusAction() {
        numberOfMeals = numberOfMeals + 1
    }
    
    func totalOfPriceMeal() -> Double {
        var totalPrice: Double = 0
        if let meal = meal {
            totalPrice = meal.price * Double(numberOfMeals)
        }
        return totalPrice
    }
    
    func numberOfSection() -> Int {
        return sections.count
    }
    
    func numberOfItemsInSection(section: SectionType) -> Int {
        switch section {
        case .top, .bottom:
            return listChoice.count
        default:
            return 1
        }
    }
    
    func cellForRowAtSection(indexPath: IndexPath) -> ChoiceCustomMealTableViewCellVM {
        let item = listChoice[indexPath.row]
        let model = ChoiceCustomMealTableViewCellVM(infoCustomMeal: item)
        return model
    }
    
    func cellForHeader(sectionType: SectionType) -> HeaderChoiceMealTableViewVM {
        switch sectionType {
        case .top:
            let model = HeaderChoiceMealTableViewVM(section: sectionType.rawValue, title: "Choice of Top Cookie", data: infoTopCustomMeal)
            return model
        default:
            let model = HeaderChoiceMealTableViewVM(section: sectionType.rawValue, title: "Choice of Bottom Cookie", data: infoBottomCustomMeal)
            return model
        }
    }
    
    func setUpEmail() {
        email = UserDefaults.standard.string(forKey: UserDefaultsKeys.emailLogin)
    }
    
    func addOrderMealFireStore(meal: Meal, infoTopCustomMeal: String, infoBottomCustomMeal: String, totalMealOrder: Int, completion: @escaping (Bool, String) -> Void) {
        guard let email = email else {
            completion(false, "Error Order")
            return
        }
        let data: [String: Any] = [
                "account": email,
                "idMeal": meal.idMeal,
                "image": meal.image,
                "name": meal.name,
                "typeFood": meal.typeFood,
                "total": totalMealOrder,
                "price": meal.price,
                "address": meal.address,
                "nation1": meal.nation1,
                "nation2": meal.nation2,
                "time": meal.time,
                "rating": meal.rating,
                "totalVote": meal.totalVote,
                "feeShip": meal.feeShip,
                "topCustom": infoTopCustomMeal,
                "botCustom": infoBottomCustomMeal
            ]
        
        db.collection("orderMeal")
            .whereField("account", isEqualTo: email)
            .whereField("idMeal", isEqualTo: meal.idMeal)
            .whereField("topCustom", isEqualTo: infoTopCustomMeal)
            .whereField("botCustom", isEqualTo: infoBottomCustomMeal)
            .getDocuments { querySnapshot, error in
            if let error = error {
                completion(false, "Error fetching data: \(error.localizedDescription)")
                return
            }
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                // Tài liệu tồn tại, cập nhật total
                let document = documents.first
                if let total = document?.data()["total"] as? Int {
                    document?.reference.updateData(["total": total + totalMealOrder]) { error in
                        if let error = error {
                            completion(false, "Error updating total: \(error.localizedDescription)")
                        } else {
                            completion(true, "Total updated successfully!")
                        }
                    }
                } else {
                    completion(false, "Total field is missing.")
                }
            } else {
                db.collection("orderMeal").addDocument(data: data) { error in
                    if let error = error {
                        completion(false, "Error adding document: \(error.localizedDescription)")
                    } else {
                        completion(true, "OrderMeal added successfully!")
                    }
            }

            }
        }
    }
}
