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
    let isEnable: Bool
    let value: String

    init(typeForm: TypeOfTextFieldForm, isLogin: Bool = false, isEnable: Bool = true, value: String = "") {
        self.typeForm = typeForm
        self.isLogin = isLogin
        self.isEnable = isEnable
        self.value = value
    }
}
