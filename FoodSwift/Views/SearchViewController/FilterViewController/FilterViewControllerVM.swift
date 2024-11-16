//
//  FilterViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 15/11/24.
//

import Foundation

final class FilterViewControllerVM {
    
    // MARK: Properties
    var filterByNation: [String] = []
    var filterByCategory: [String] = []
    var typyFilter: [TypeFilter] = [.nation, .category, .priceRange]
    let filterPriceRange: [String] = ["$", "$$", "$$$", "$$$$", "$$$$$", "$$$$$$", "$$$$$$$"]
    
    init() {}
    
    init(filterByNation: [String], filterByCategory: [String]) {
        self.filterByNation = filterByNation
        self.filterByCategory = filterByCategory
    }
    
    // MARK: - Enum
    enum TypeFilter: Int {
        case nation = 0
        case category
        case priceRange
    }
    
    func numberOfSection() -> Int {
        return typyFilter.count
    }
    
    func numberOfItemInSection(typeFilter: TypeFilter) -> Int {
        switch typeFilter {
        case .nation:
            return filterByNation.count
        case .category:
            return filterByCategory.count
        default:
            return filterPriceRange.count
        }
    }
    
    func cellForHeaderOfSectionCollection(sectionFilterType: TypeFilter) -> HeaderFilterCollectionViewCellVM {
        switch sectionFilterType {
        case .nation:
            return HeaderFilterCollectionViewCellVM(title: "NATION", headerType: .nationHeader)
        case .category:
            return HeaderFilterCollectionViewCellVM(title: "CATEGORY", headerType: .categoryHeader)
        default:
            return HeaderFilterCollectionViewCellVM(title: "PRICE RANGE", headerType: .priceRangeHeader)
        }
    }
    
    func cellForRowAtSectionCollection(indexPath: IndexPath, sectionFilterType: TypeFilter) -> NationAndCategoryFilterCollectionViewCellVM {
        switch sectionFilterType {
        case .nation:
            let item = filterByNation[indexPath.row]
            let model = NationAndCategoryFilterCollectionViewCellVM(title: item)
            return model
        default:
            let item = filterByCategory[indexPath.row]
            let model = NationAndCategoryFilterCollectionViewCellVM(title: item)
            return model
        }
    }
    
    func setWidthFollowTitleLabel(indexPath: IndexPath, sectionFilterType: TypeFilter) -> String {
        switch sectionFilterType {
        case .nation:
            return filterByNation[indexPath.row]
        case .category:
            return filterByCategory[indexPath.row]
        default:
            return ""
        }
    }
    
    func cellForRowAtPriceRangeSectionCollection(indexPath: IndexPath) -> PriceRangeCollectionViewCellVM {
        let item = filterPriceRange[indexPath.row]
        let model = PriceRangeCollectionViewCellVM(priceRange: item)
        return model
    }
}
