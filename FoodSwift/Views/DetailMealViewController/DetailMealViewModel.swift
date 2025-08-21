//
//  DetailMealViewModel.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 21/10/24.
//

import Foundation

final class DetailMealViewModel {
    
    // MARK: - Properties
    var meal: Meal?
    let typeMeal = ["Beef", "Breakfast", "Chicken", "Dessert", "Goat", "Lamb", "Miscellaneous", "Pasta", "Pork", "Seafood", "Side", "Starter", "Vegan", "Vegetarian"]
    
    var listMealByCategory: [TheMealDB] = []
    var mealDetail: TheMealDB?
    
    init() {}
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    init(themeMealDetail: TheMealDB) {
        self.mealDetail = themeMealDetail
    }
    
    
    // MARK: - Enum
    enum CollectionType: Int {
        case featuredItem = 0
        case typeFood
    }
    
    // MARK: - Data CollectionView
    func numberOfSectionsCollectionView(type: CollectionType) -> Int {
        switch type {
        case .featuredItem:
            return dummyMealFeaturePartnes.featurePartnesMeal.count
        default:
            return typeMeal.count
        }
    }
    
    func cellForRowAtSectionFeaturedItem(indexPath: IndexPath) -> FeaturedItemCollectionCellVM {
        let item = dummyMealFeaturePartnes.featurePartnesMeal[indexPath.row]
        let model = FeaturedItemCollectionCellVM(meal: item)
        return model
    }
    
    func cellForRowAtSectionTypeMeal(indexPath: IndexPath) -> TypeMealCollectionCellVM {
        let item = typeMeal[indexPath.row]
        let model = TypeMealCollectionCellVM(typeMealTitle: item, indexPath: indexPath.row)
        return model
    }
    
    // MARK: - Data TableView
    func numberOfSectionsTableView() -> Int {
        return listMealByCategory.count
    }
    
    func cellForRowAtSectionMealForCategory(indexPath: IndexPath) -> ListMealForTypeTableViewCellVM {
        let item = listMealByCategory[indexPath.row]
        let model = ListMealForTypeTableViewCellVM(mealByCategory: item)
        return model
    }
    
    func heightForCellTableView() -> CGFloat {
        return ScreenSize.scaleHeight(151)
    }
    
    func getAPIListMealByCategory(categoryName: String, listMealByCategoryCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getListMealByCategory(categoryName: categoryName) { [weak self] (mealResult) in
            guard let this = self else { return }
            switch mealResult {
            case .failure(let error):
                listMealByCategoryCompletion(false, error)
            case .success(let result):
                this.listMealByCategory.removeAll()
                for item in result.meals {
                    this.listMealByCategory.append(item)
                }
                listMealByCategoryCompletion(true, App.String.loadSuccess)
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
                    this.mealDetail = item
                }
                detailMealCompletion(true, App.String.loadSuccess)
            }
        }
    }
}
