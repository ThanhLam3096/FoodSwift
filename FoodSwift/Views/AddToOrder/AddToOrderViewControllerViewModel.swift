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
    enum SectionType: Int {
        case top = 0
        case bottom
    }
    var sections: [SectionType] = [.top, .bottom]
    
    let listChoice = ["Chocolate Chip",
                      "Cookies and Cream",
                      "Funfetti",
                      "M and M",
                      "Red Velvet",
                      "Peanut Butter",
                      "Snickerdoodle",
                      "White Chocolate Macadamia"
                    ]
    
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
    
    func numberOfItemsInSection() -> Int {
        return listChoice.count
    }
    
    func cellForRowAtSection(indexPath: IndexPath) -> ChoiceCustomMealTableViewCellVM {
        let item = listChoice[indexPath.row]
        let model = ChoiceCustomMealTableViewCellVM(infoCustomMeal: item)
        return model
    }
}
