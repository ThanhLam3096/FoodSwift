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
    let filterByPriceRange: [String] = ["$", "$$", "$$$", "$$$$", "$$$$$", "$$$$$$", "$$$$$$$"]
    var typyFilter: [TypeFilter] = [.nation, .category, .priceRange]
    
    var listFilterChooseByNation: [String] = []
    var listFilterChooseByCategory: [String] = []
    var listFilterChooseByPriceRange: [String] = []
    var listIndexFilterChooseByNation: [IndexPath] = []
    var listIndexFilterChooseByCategory: [IndexPath] = []
    var listIndexFilterChooseByPriceRange: [IndexPath] = []
    
    var dataSearchFilter: SearchFilter?
    
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
            return filterByPriceRange.count
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
        let item = filterByPriceRange[indexPath.row]
        let model = PriceRangeCollectionViewCellVM(priceRange: item)
        return model
    }
    
    func saveDataFilterByNation(indexPath: IndexPath) {
        listFilterChooseByNation.append(filterByNation[indexPath.row])
        listIndexFilterChooseByNation.append(indexPath)
    }
    
    func saveDataFilterByCategory(indexPath: IndexPath) {
        listFilterChooseByCategory.append(filterByCategory[indexPath.row])
        listIndexFilterChooseByCategory.append(indexPath)
    }
    
    func saveDataFilterByPriceRange(indexPath: IndexPath) {
        listFilterChooseByPriceRange.append(filterByPriceRange[indexPath.row])
        listIndexFilterChooseByPriceRange.append(indexPath)
    }
    
    func unSaveDataFilterByNation(indexPath: IndexPath) {
        if let index = listFilterChooseByNation.firstIndex(of: filterByNation[indexPath.row]) {
            listFilterChooseByNation.remove(at: index)
        }
    }
    
    func unSaveDataIndexFilterByNation(indexPath: IndexPath) {
        if let index = listIndexFilterChooseByNation.firstIndex(of: indexPath) {
            listIndexFilterChooseByNation.remove(at: index)
        }
    }
    
    func unSaveDataFilterByCategory(indexPath: IndexPath) {
        if let index = listFilterChooseByCategory.firstIndex(of: filterByCategory[indexPath.row]) {
            listFilterChooseByCategory.remove(at: index)
        }
    }
    
    func unSaveDataIndexFilterByCategory(indexPath: IndexPath) {
        if let index = listIndexFilterChooseByCategory.firstIndex(of: indexPath) {
            listIndexFilterChooseByCategory.remove(at: index)
        }
    }
    
    func unSaveDataFilterByPriceRange(indexPath: IndexPath) {
        if let index = listFilterChooseByPriceRange.firstIndex(of: filterByPriceRange[indexPath.row]) {
            listFilterChooseByPriceRange.remove(at: index)
        }
    }
    
    func unSaveDataIndexFilterByPriceRange(indexPath: IndexPath) {
        if let index = listIndexFilterChooseByPriceRange.firstIndex(of: indexPath) {
            listIndexFilterChooseByPriceRange.remove(at: index)
        }
    }
    
    func clearDataFilterNation() {
        listFilterChooseByNation.removeAll()
        listIndexFilterChooseByNation.removeAll()
    }
    
    func clearDataFilterCategory() {
        listFilterChooseByCategory.removeAll()
        listIndexFilterChooseByCategory.removeAll()
    }
    
    func clearDataFilterPriceRange() {
        listFilterChooseByPriceRange.removeAll()
        listIndexFilterChooseByPriceRange.removeAll()
    }
    
    func getDataSearchFilterToLocal() {
        if let savedUserData = UserDefaults.standard.data(forKey: "searchFilter") {
            // Giải mã `Data` thành đối tượng `User`
            if let loadedUser = try? JSONDecoder().decode(SearchFilter.self, from: savedUserData) {
                listFilterChooseByNation = loadedUser.filterSearchNation
                listFilterChooseByCategory = loadedUser.filterSearchCategory
                listFilterChooseByPriceRange = loadedUser.filterSearchPriceRange
                listIndexFilterChooseByNation = loadedUser.indexPathSearchNation
                listIndexFilterChooseByCategory = loadedUser.indexPathSearchCategory
                listIndexFilterChooseByPriceRange = loadedUser.indexPathSearchPriceRange
            }
        }
    }
    
    func saveDataSearchFilterToLocal() {
        dataSearchFilter = SearchFilter(account: "LocalAccount", filterSearchNation: listFilterChooseByNation, filterSearchCategory: listFilterChooseByCategory, filterSearchPriceRange: listFilterChooseByPriceRange, indexPathSearchNation: listIndexFilterChooseByNation, indexPathSearchCategory: listIndexFilterChooseByCategory, indexPathSearchPriceRange: listIndexFilterChooseByPriceRange)
        if let encodedUser = try? JSONEncoder().encode(dataSearchFilter) {
            UserDefaults.standard.set(encodedUser, forKey: "searchFilter")
        }
    }
}
