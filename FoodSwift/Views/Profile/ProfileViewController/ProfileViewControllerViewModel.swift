//
//  ProfileViewControllerViewModel.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 18/11/24.
//

import Foundation

final class ProfileViewControllerViewModel {
    
    // MARK: Properties
    let sections: [AccountSettingSection] = [.accountSettings, .notifications, .more]
    
    // MARK: -Enum
    enum AccountSettingSection: Int, CaseIterable {
        case accountSettings
        case notifications
        case more
        
        var title: String {
            switch self {
            case .accountSettings: return "Account Settings"
            case .notifications: return "Notifications"
            case .more: return "More"
            }
        }
        
        var subTitle: String {
            switch self {
            case .accountSettings: return "Update your settings like notifications,\npayments, profile edit etc"
            default: return ""
            }
        }
        
        var items: [AccountSettingItem] {
            switch self {
            case .accountSettings:
                return [
                    .profileInfo,
                    .changePassword,
                    .paymentMethods,
                    .locations,
                    .addSocialAccount,
                    .referToFriends
                ]
            case .notifications:
                return [
                    .pushNotifications,
                    .smsNotifications,
                    .promotionalNotifications
                ]
            case .more:
                return [
                    .rateUs,
                    .faq,
                    .logout
                ]
            }
        }
    }
    
    enum AccountSettingItem {
        case profileInfo
        case changePassword
        case paymentMethods
        case locations
        case addSocialAccount
        case referToFriends
        case pushNotifications
        case smsNotifications
        case promotionalNotifications
        case rateUs
        case faq
        case logout
        
        var iconSystem: String {
            switch self {
            case .profileInfo: return "person.fill"
            case .changePassword: return "lock.fill"
            case .paymentMethods: return "creditcard.fill"
            case .pushNotifications: return "bell.fill"
            case .smsNotifications: return "message.fill"
            case .promotionalNotifications: return "bell.badge.fill"
            case .rateUs: return "star.fill"
            case .locations: return "mappin.and.ellipse"
            case .addSocialAccount: return "socical_icon_Facebook"
            case .referToFriends: return "refer"
            case .faq: return "faq"
            case .logout: return "logout"
            }
        }
        
        var isIconSystem: Bool {
            switch self {
            case .addSocialAccount: return false
            case .referToFriends: return false
            case .faq: return false
            case .logout: return false
            default: return true
            }
        }
        
        var title: String {
            switch self {
            case .profileInfo: return "Profile Information"
            case .changePassword: return "Change Password"
            case .paymentMethods: return "Payment Methods"
            case .locations: return "Locations"
            case .addSocialAccount: return "Add Social Account"
            case .referToFriends: return "Refer to Friends"
            case .pushNotifications: return "Push Notifications"
            case .smsNotifications: return "SMS Notifications"
            case .promotionalNotifications: return "Promotional Notifications"
            case .rateUs: return "Rate Us"
            case .faq: return "FAQ"
            case .logout: return "Logout"
            }
        }
        
        var subtitle: String {
            switch self {
            case .profileInfo: return "Change your account information"
            case .changePassword: return "Change your password"
            case .paymentMethods: return "Add your credit & debit cards"
            case .locations: return "Add or remove your delivery locations"
            case .addSocialAccount: return "Add Facebook, Twitter etc"
            case .referToFriends: return "Get $10 for referring friends"
            case .pushNotifications: return "For daily update you will get it"
            case .smsNotifications: return "For daily update you will get it"
            case .promotionalNotifications: return "For daily update you will get it"
            case .rateUs: return "Rate us on playstore, appstore"
            case .faq: return "Frequently asked questions"
            case .logout: return ""
            }
        }
        
        var hasSwitch: Bool {
            switch self {
            case .pushNotifications, .smsNotifications, .promotionalNotifications:
                return true
            default:
                return false
            }
        }
    }
    
    func numberOfSections() -> Int {
        return sections.count
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
        let model = ProfileTableViewCellVM(image: iconItem, title: titleItem, content: subTitleItem, switchButton: hasSwitchItem, isIconSystem: isIconSystem)
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
