//
//  HomeViewVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/10/24.
//

import Foundation

final class HomeViewVM {
    let listLocation: [String] = ["Ha Noi, Viet Nam", "New York, USA", "Parisn, France", "London, England", "Bac Kinh, China", "Tokyo, Japan", "Malina, India", "Kevin, Australia", "Moccow, Russia", "Munich ,Germany", "Madrid, Spanish", "Buenos Aires, Argentina", "Brasília, Brazil"]
    
    let listSliderFoodImage: [String] = ["food1", "food2", "food3", "food4", "food5"]
    
    var listMealFeaturePartners: [Meal] = []
    var listNationFood: [Meal] = []
    var listRestaurants: [Restaurant] = []
    
    // MARK: - Enum
    enum CollectionType: Int {
        case featurePartner = 0
        case nationFood
        case slider
    }
    
    enum TableViewType: Int {
        case locaition = 0
        case restaurant
    }
    
    // MARK: - TableView
    func numberOfRowsInSectionTableView(type: TableViewType) -> Int {
        switch type {
        case .locaition:
            return listLocation.count
        default:
            return listRestaurants.count
        }
    }
    
    func cellForRowAtHeaderView(indexPath: IndexPath) -> LocationListViewModel {
        let itemLocaiton = listLocation[indexPath.row]
        let model = LocationListViewModel(location: itemLocaiton)
        return model
    }
    
    func cellForRowAtListRestaurants(indexPath: IndexPath) -> ListAllResTableViewCellVM {
        let item = listRestaurants[indexPath.row]
        let model = ListAllResTableViewCellVM(restaurant: item)
        return model
    }
    
    func heightForRowAtTableView(type: TableViewType) -> CGFloat {
        switch type {
        case .locaition:
            return ScreenSize.scaleHeight(36)
        default:
            return ScreenSize.scaleHeight(292)
        }
    }
    
    // MARK: - CollectionView Featured Partners Data
    func numberOfRowsInSectionCollectionView(type: CollectionType) -> Int {
        switch type {
        case .featurePartner:
            return listMealFeaturePartners.count
        case .nationFood:
            return listNationFood.count
        default:
            return listSliderFoodImage.count
        }
        
    }
    
    func cellForRowAtCollectionMeal(indexPath: IndexPath, type: CollectionType) -> FeaturedPartnersCollectionViewCellViewModel {
        switch type {
        case .featurePartner:
            let item = listMealFeaturePartners[indexPath.row]
            let model = FeaturedPartnersCollectionViewCellViewModel(meal: item, typeList: .featurePartners)
            return model
        default:
            let item = listNationFood[indexPath.row]
            let model = FeaturedPartnersCollectionViewCellViewModel(meal: item, typeList: .nation)
            return model
        }
        
    }
    
    func cellForRowAtSlider(indexPath: IndexPath) -> SliderImageCollectionViewCellViewModel {
        let item = listSliderFoodImage[indexPath.row]
        let model = SliderImageCollectionViewCellViewModel(image: item)
        return model
    }
    
    // MARK: - PassData to List All Feature Partners
    func transferListFeaturePartNers() -> FeaturePartnersViewControllerVM {
        return FeaturePartnersViewControllerVM(listFeatureMeal: listMealFeaturePartners,title: "Feature Partners")
    }
    
    // MARK: - PassData to List All NationMeal
    func transferListNationMeal() -> FeaturePartnersViewControllerVM {
        return FeaturePartnersViewControllerVM(listFeatureMeal: listNationFood, title: "Nation Food")
    }
    
    // MARK: - Public Function
    func getAPIListFeaturePartners(listFeaturePartnersCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getFeaturePartners { [weak self] (mealResult) in
            guard let this = self else { return }
            switch mealResult {
            case .failure(let error):
                listFeaturePartnersCompletion(false, error)
            case .success(let result):
                for item in result.featurePartnes {
                    this.listMealFeaturePartners.append(item)
                }
                listFeaturePartnersCompletion(true, App.String.loadSuccess)
            }
        }
    }
    
    func getAPIListNationFood(listNationFoodCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getFoodNation { [weak self] (mealResult) in
            guard let this = self else { return }
            switch mealResult {
            case .failure(let error):
                listNationFoodCompletion(false, error)
            case .success(let result):
                for item in result.meals {
                    this.listNationFood.append(item)
                }
                listNationFoodCompletion(true, App.String.loadSuccess)
            }
        }
    }
    
    func getAPIListRestaurant(listRestaurantCompletion: @escaping (Bool, String) -> Void) {
        Networking.shared().getListRestaurant { [weak self] (restaurantResult) in
            guard let this = self else { return }
            switch restaurantResult {
            case .failure(let error):
                listRestaurantCompletion(false, error)
            case .success(let result):
                for item in result.restaurants {
                    this.listRestaurants.append(item)
                }
                listRestaurantCompletion(true, App.String.loadSuccess)
            }
        }
    }
}
