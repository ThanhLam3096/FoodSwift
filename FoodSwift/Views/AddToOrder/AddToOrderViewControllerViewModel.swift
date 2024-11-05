//
//  AddToOrderViewControllerViewModel.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 3/11/24.
//

import Foundation

final class AddToOrderViewControllerViewModel {
    
    // MARK: Properties
    var numberOfMeals = 1
    var infoTopCustomMeal = ""
    var infoBottomCustomMeal = ""
    var addIntructionMealOrder = ""
    var topCustomMealIndexPatch: IndexPath?
    var bottomCustomMealIndexPatch: IndexPath?
    var allInfoCustomMealOrder = ""
    var priceMeal = 1
    var totalPriceMeal = 1
    
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
}
