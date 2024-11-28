//
//  ProfileInfomationSettingsViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 19/11/24.
//

import Foundation

final class ProfileInfomationSettingsViewControllerVM {
    var isChangePassword: Bool
    
    init(isChangePassword: Bool = false) {
        self.isChangePassword = isChangePassword
    }
}
