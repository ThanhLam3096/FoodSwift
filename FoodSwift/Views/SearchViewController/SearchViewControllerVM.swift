//
//  SearchViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 13/11/24.
//

import Foundation

final class SearchViewControllerVM {
    var listResultSearchMealByName: [TheMealDB] = []
    
    
    // MARK: - Data CollectionView
    func numberOfSections() -> Int {
        return listResultSearchMealByName.count
    }
    
    func cellForRowAtSection(indexPath: IndexPath) -> SearchCollectionCellVM {
        let item = listResultSearchMealByName[indexPath.row]
        let model = SearchCollectionCellVM(meal: item)
        return model
    }
    
    func getAPISearchMealDB(name: String, detailMealCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealByName(nameMeal: name) { [weak self] (mealSearchResult) in
            guard let this = self else { return }
            switch mealSearchResult {
            case .failure(let error):
                detailMealCompletion(false, error)
            case .success(let result):
                let items = result.meals
                this.listResultSearchMealByName = items
                detailMealCompletion(true, App.String.loadSuccess)
            }
        }
    }
}   
