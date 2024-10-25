//
//  TypeMealCollectionCellVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/10/24.
//

import Foundation

final class TypeMealCollectionCellVM {
    let typeMealTitle: String
    let indexPath: Int
    
    init(typeMealTitle: String, indexPath: Int) {
        self.typeMealTitle = typeMealTitle
        self.indexPath = indexPath
    }
}
