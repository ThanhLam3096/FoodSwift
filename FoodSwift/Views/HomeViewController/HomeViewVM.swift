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
    // MARK: - TableView HeaderView Data
    func numberOfRowsInSectionHeaderView() -> Int {
        return listLocation.count
    }

    func cellForRowAtHeaderView(indexPath: IndexPath) -> LocationListViewModel {
        let itemLocaiton = listLocation[indexPath.row]
        let model = LocationListViewModel(location: itemLocaiton)
        return model
    }

    func heightForRowAtHeaderView() -> CGFloat {
        return 36
    }
    
    // MARK: - CollectionView Slider Data
    func numberOfRowsInSectionSlider() -> Int {
        return listSliderFoodImage.count
    }

    func cellForRowAtSlider(indexPath: IndexPath) -> SliderImageCollectionViewCellViewModel {
        let item = listSliderFoodImage[indexPath.row]
        let model = SliderImageCollectionViewCellViewModel(image: item)
        return model
    }

    func heightForRowAtSlider() -> CGFloat {
        return 36
    }
    
    // MARK: - CollectionView Featured Partners Data
    func numberOfRowsInSectionFeaturedPartners() -> Int {
        return dummyMealFeaturePartnes.featurePartnesMeal.count
    }

    func cellForRowAtFeaturedPartners(indexPath: IndexPath) -> FeaturedPartnersCollectionViewCellViewModel {
        let item = dummyMealFeaturePartnes.featurePartnesMeal[indexPath.row]
        let model = FeaturedPartnersCollectionViewCellViewModel(meal: item)
        return model
    }

    func heightForRowAtFeaturedPartners() -> CGFloat {
        return 254
    }
    
    // MARK: - TableView List Res Data
    func numberOfRowsInSectionListRestaurants() -> Int {
        return dummyRestaurant.listAllRes.count
    }

    func cellForRowAtListRestaurants(indexPath: IndexPath) -> ListAllResTableViewCellVM {
        let item = dummyRestaurant.listAllRes[indexPath.row]
        let model = ListAllResTableViewCellVM(restaurant: item)
        return model
    }

    func heightForRowAtListRestaurants() -> CGFloat {
        return 282
    }
}
