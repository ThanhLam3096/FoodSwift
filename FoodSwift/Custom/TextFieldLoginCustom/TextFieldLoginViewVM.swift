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
    let codePhoneNumber: String
    let imageName: String
    let isChangeCodeNumberPhone: Bool

    init(typeForm: TypeOfTextFieldForm, isLogin: Bool = false, isEnable: Bool = true, value: String = "", codePhoneNumber: String = "+84", imageName: String = "VietNam", isChangeCodeNumberPhone: Bool = false) {
        self.typeForm = typeForm
        self.isLogin = isLogin
        self.isEnable = isEnable
        self.value = value
        self.codePhoneNumber = codePhoneNumber
        self.imageName = imageName
        self.isChangeCodeNumberPhone = isChangeCodeNumberPhone
    }
}
