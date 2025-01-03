//
//  ProfileTableViewCellVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 18/11/24.
//

import Foundation

final class ProfileTableViewCellVM {
    let image: String
    let title: String
    let content: String
    let switchButton: Bool
    let isIconSystem: Bool
    let typeItemSetting: AccountSettingItem
    
    init(image: String, title: String, content: String, switchButton: Bool, isIconSystem: Bool, typeItemSetting: AccountSettingItem) {
        self.image = image
        self.title = title
        self.content = content
        self.switchButton = switchButton
        self.isIconSystem = isIconSystem
        self.typeItemSetting = typeItemSetting
    }
    
}
