//
//  File.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 13/10/24.
//

import Foundation

final class FeaturedPartnersCollectionViewCellViewModel {
    var meal: Meal
    var typeList: TypeList
    
    init(meal: Meal, typeList: TypeList) {
        self.meal = meal
        self.typeList = typeList
    }
}
