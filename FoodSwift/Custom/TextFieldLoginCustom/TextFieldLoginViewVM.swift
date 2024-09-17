//
//  TextFieldLoginViewVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 1/9/24.
//

import Foundation

class TextFieldLoginViewVM {
    
    // MARK: - Properties
    var infoTextField: String
    var isPasswordTextField: Bool = false

    init(infoTextField: String, isPasswordTextField: Bool) {
        self.infoTextField = infoTextField
        self.isPasswordTextField = isPasswordTextField
    }
}
