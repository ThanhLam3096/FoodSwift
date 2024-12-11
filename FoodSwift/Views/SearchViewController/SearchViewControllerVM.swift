//
//  SearchViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 13/11/24.
//

import Foundation

final class SearchViewControllerVM {
    
    // MARK: Properties
    var listResultSearchMealByName: [TheMealDB] = []
    let flagsNationMeal = ["USA", "British", "Canadian", "China", "Croatian", "Dutch", "Egyptian", "Filipino", "France", "Greek", "Indian", "Irish", "Italian", "Jamaican", "Japan", "Kenyan", "Malaysian", "Mexican", "Moroccan", "Polish", "Portuguese", "Russia", "Spanish", "Thai", "Tunisian", "Turkish", "Ukrainian", "Unknown", "VietNam"]
    let dishTypeMeal = ["Beef", "Breakfast", "Chicken", "Dessert", "Goat", "Lamb", "Miscellaneous", "Pasta", "Pork", "Seafood", "Side", "Starter", "Vegan", "Vegetarian"]
    var titleNationCategoryMeal: [String] = []
    var isNation = true
    var mealDetail: Meal?
    var historySearch: [String] = []
    var sortedHistorySearch: [String] {
        return historySearch.reversed()  // hoặc return Array(historySearch.reversed())
    }
    
    // MARK: - Enum
    enum TypeFilter: Int {
        case searchName = 0
        case nation
    }
    
    // MARK: - Data CollectionView
    func numberOfItemSections(type: TypeFilter) -> Int {
        switch type {
        case .searchName:
            return listResultSearchMealByName.count
        default:
            return titleNationCategoryMeal.count
        }
    }
    
    func cellForRowAtSectionSearchByName(indexPath: IndexPath) -> SearchCollectionCellVM {
        let item = listResultSearchMealByName[indexPath.row]
        let model = SearchCollectionCellVM(meal: item)
        return model
    }
    
    func cellForRowAtSectionNationCategory(indexPath: IndexPath) -> NationAndCategoryCollectionCellVM {
        let image = isNation ? flagsNationMeal[indexPath.row] : dishTypeMeal[indexPath.row]
        let title = titleNationCategoryMeal[indexPath.row]
        let model = NationAndCategoryCollectionCellVM(image: image, title: title)
        return model
    }
    
    func numberOfItemRecentSearch() -> Int {
        return historySearch.count
    }
    
    func cellForRowAtItemRecentSearch(indexPath: IndexPath) -> SearchRecentTableViewCellVM {
        let item = historySearch.reversed()[indexPath.row]
        let model = SearchRecentTableViewCellVM(contentSearch: item)
        return model
    }
    
    func getAPISearchMealDB(name: String, detailMealCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getMealByName(nameMeal: name) { [weak self] (mealSearchResult) in
            guard let this = self else { return }
            switch mealSearchResult {
            case .failure(let error):
                detailMealCompletion(false, error)
            case .success(let result):
                this.listResultSearchMealByName.removeAll()
                let items = result.meals
                this.listResultSearchMealByName = items
                detailMealCompletion(true, App.String.loadSuccess)
            }
        }
    }
    
    func getAPINationMeal(nationMealCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getNationMeal { [weak self] (nationMealResult) in
            guard let this = self else { return }
            this.titleNationCategoryMeal = []
            switch nationMealResult {
            case .failure(let error):
                this.titleNationCategoryMeal = ["Beef", "Breakfast", "Chicken", "Dessert", "Goat", "Lamb", "Miscellaneous", "Pasta", "Pork", "Seafood", "Side", "Starter", "Vegan", "Vegetarian"]
                nationMealCompletion(false, error)
            case .success(let result):
                let items = result.meals
                for item in items {
                    this.titleNationCategoryMeal.append(item.area)
                }
                nationMealCompletion(true, App.String.loadSuccess)
            }
        }
    }
    
    func getAPICategoryMeal(nationMealCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getCategoryMeal { [weak self] (nationMealResult) in
            guard let this = self else { return }
            this.titleNationCategoryMeal = []
            switch nationMealResult {
            case .failure(let error):
                this.titleNationCategoryMeal = ["USA", "British", "Canadian", "China", "Croatian", "Dutch", "Egyptian", "Filipino", "France", "Greek", "Indian", "Irish", "Italian", "Jamaican", "Japan", "Kenyan", "Malaysian", "Mexican", "Moroccan", "Polish", "Portuguese", "Russia", "Spanish", "Thai", "Tunisian", "Turkish", "Ukrainian", "Unknown", "VietNam"]
                nationMealCompletion(false, error)
            case .success(let result):
                let items = result.meals
                for item in items {
                    this.titleNationCategoryMeal.append(item.category)
                }
                nationMealCompletion(true, App.String.loadSuccess)
            }
        }
    }
    
    func getAPIMealByNation(nationName: String, listCategoryNameMealCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getListMealByNation(nationName: nationName) { [weak self] (mealResult) in
            guard let this = self else { return }
            switch mealResult {
            case .failure(let error):
                listCategoryNameMealCompletion(false, error)
            case .success(let result):
                this.listResultSearchMealByName.removeAll()
                for item in result.meals {
                    this.listResultSearchMealByName.append(item)
                }
                listCategoryNameMealCompletion(true, App.String.loadSuccess)
            }
        }
    }
    
    func getAPIMealByCategory(categoryName: String, listCategoryNameMealCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getListMealByCategory(categoryName: categoryName) { [weak self] (mealResult) in
            guard let this = self else { return }
            switch mealResult {
            case .failure(let error):
                listCategoryNameMealCompletion(false, error)
            case .success(let result):
                this.listResultSearchMealByName.removeAll()
                for item in result.meals {
                    this.listResultSearchMealByName.append(item)
                }
                listCategoryNameMealCompletion(true, App.String.loadSuccess)
            }
        }
    }
    
    func getAPIDetailMealDB(idMeal: String, detailMealCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getDetailMeal(idMeal: idMeal) { [weak self] (mealDetailResult) in
            guard let this = self else { return }
            switch mealDetailResult {
            case .failure(let error):
                detailMealCompletion(false, error)
            case .success(let result):
                let items = result.meals
                for item in items{
                    this.mealDetail = DetailFollowThemeMealDB().setDetailDataForThemeMealDB(themeMealDB: item)
                    print("Meal Detail \(String(describing: this.mealDetail?.name))")
                }
                detailMealCompletion(true, App.String.loadSuccess)
            }
        }
    }
    
    func getToHitorySearch() {
        if let hitory = UserDefaults.standard.array(forKey: "historySearch") as? [String] {
            historySearch = hitory
        } else {
            historySearch = []
        }
    }
    
    func saveToHistorySearch(history: String) {
        if !historySearch.contains(history) {
            historySearch.append(history)
            UserDefaults.standard.set(historySearch, forKey: "historySearch")
        }
    }
    
    func clearAllHitorySearch() {
        historySearch.removeAll()
        UserDefaults.standard.set([], forKey: "historySearch")
    }
}
