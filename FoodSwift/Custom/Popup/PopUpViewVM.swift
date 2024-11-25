//
//  PopUpViewVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 25/11/24.
//

import Foundation

final class PopUpViewVM {
    var title: String
    var isSuccesPopup: Bool
    
    init(title: String, isSuccesPopup: Bool) {
        self.title = title
        self.isSuccesPopup = isSuccesPopup
    }
}
