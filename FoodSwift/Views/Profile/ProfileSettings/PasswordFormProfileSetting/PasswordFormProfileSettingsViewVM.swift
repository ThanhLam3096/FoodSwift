//
//  PasswordFormProfileSettingsViewVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 19/11/24.
//

import Foundation

final class PasswordFormProfileSettingsViewVM {
    // MARK: - Properties
    let typeForm: TypeOfTextFieldForm
    let value: String

    init(typeForm: TypeOfTextFieldForm, value: String) {
        self.typeForm = typeForm
        self.value = value
    }
}
