//
//  FeaturePartnersViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 20/10/24.
//

import Foundation

final class FeaturePartnersViewControllerVM {
    var listFeatureMeal: [Meal] = []
    var title: String = ""
    
    init() {}
    
    init(listFeatureMeal: [Meal], title: String) {
        self.listFeatureMeal = listFeatureMeal
        self.title = title
    }
    
    // MARK: - Data CollectionView
    func numberOfSections() -> Int {
        return listFeatureMeal.count
    }
    
    func cellForRowAtSection(indexPath: IndexPath) -> ListCollectionDetailVM {
        let item = listFeatureMeal[indexPath.row]
        let model = ListCollectionDetailVM(meal: item)
        return model
    }
}
