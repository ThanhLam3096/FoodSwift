//
//  ProfileViewControllerViewModel.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 18/11/24.
//

import Foundation

final class ProfileViewControllerViewModel {
    
    func numberOfSections() -> Int {
        return AccountSettingSection.allCases.count
    }
    
    func numberOfItemInSections(section: AccountSettingSection) -> Int {
        return section.items.count
    }
    
    func cellForRowAtItem(indexPath: IndexPath, sections: AccountSettingSection) -> ProfileTableViewCellVM {
        let items = sections.items
        let iconItem = items[indexPath.row].iconSystem
        let titleItem = items[indexPath.row].title
        let subTitleItem = items[indexPath.row].subtitle
        let hasSwitchItem = items[indexPath.row].hasSwitch
        let isIconSystem = items[indexPath.row].isIconSystem
        let typeItem = items[indexPath.row]
        let model = ProfileTableViewCellVM(image: iconItem, title: titleItem, content: subTitleItem, switchButton: hasSwitchItem, isIconSystem: isIconSystem, typeItemSetting: typeItem)
        return model
    }
    
    func dataHeaderForSection(sections: AccountSettingSection) -> ProfileMoreAndNotiHeaderTableViewVM {
        return ProfileMoreAndNotiHeaderTableViewVM(title: sections.title)
    }
    
    func heightForItemAccountSettings() -> CGFloat {
        return ScreenSize.scaleHeight(72)
    }
    
    func heightForHeaderSectionAccountSettings(sections: AccountSettingSection) -> CGFloat {
        switch sections {
        case .accountSettings:
            return ScreenSize.scaleHeight(80)
        default: return ScreenSize.scaleHeight(25)
        }
    }
}
