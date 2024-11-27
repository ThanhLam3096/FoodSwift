//
//  TextFieldLoginViewVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 1/9/24.
//

import Foundation

class TextFieldLoginViewVM {
    
    // MARK: - Properties
    let typeForm: TypeOfTextFieldForm
    let isLogin: Bool

    init(typeForm: TypeOfTextFieldForm, isLogin: Bool = false) {
        self.typeForm = typeForm
        self.isLogin = isLogin
    }
}
