//
//  GlobalFunction.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/10/24.
//

import Foundation
import UIKit
import SDWebImage

func displayNumber(_ number: Double) -> String {
    // Kiểm tra nếu phần thập phân không bằng 0 (số lẻ dạng Double)
    if number.truncatingRemainder(dividingBy: 1) != 0 {
        return String(number)
    } else {
        return String(Int(number))
    }
}

struct GlobalVariables {
    static var indexNumber = 0
    static var selectedIndexPath: IndexPath? = IndexPath(item: 0, section: 0)
}

struct DetailFollowThemeMealDB {
    
    private func randomPriceMeal() -> Double {
        let decimalArray = Array(stride(from: 1.0, through: 100.0, by: 0.1))
        if let randomtPrice = decimalArray.randomElement() {
            return randomtPrice.rounded(toPlaces: 1)
        }
        return 0.0
    }
    
    private func randomTimeShip() -> String {
        let decimalArray = Array(stride(from: 1, through: 30, by: 1))
        if let randomtTime = decimalArray.randomElement() {
            return "\(randomtTime) Minutes"
        }
        return "1 Minutes"
    }
    
    private func randomRating() -> String {
        let decimalArray = Array(stride(from: 1.0, through: 5.0, by: 0.1))
        if let randomtRating = decimalArray.randomElement() {
            return "\(randomtRating.rounded(toPlaces: 1))"
        }
        return "5"
    }
    
    private func randomTotalVote() -> Int {
        let decimalArray = Array(stride(from: 1, through: 1000, by: 1))
        if let randomTotalVote = decimalArray.randomElement() {
            return randomTotalVote
        }
        return 12345
    }
    
    private func randomFeeShip() -> Double {
        let decimalArray = Array(stride(from: 1.0, through: 10.0, by: 0.1))
        if let randomFeeShip = decimalArray.randomElement() {
            return randomFeeShip.rounded(toPlaces: 1)
        }
        return 96.69
    }
    
    func setDetailDataForThemeMealDB(themeMealDB: TheMealDB) -> Meal {
        let meal = Meal(image: themeMealDB.imageMeal, name: themeMealDB.nameMeal, typeFood: themeMealDB.category, price: randomPriceMeal(), address: themeMealDB.area, nation1: themeMealDB.area, nation2: themeMealDB.area, time: randomTimeShip(), rating: randomRating(), totalVote: randomTotalVote(), fee: randomFeeShip(), idMeal: Int(themeMealDB.idMeal) ?? 69)
        
        return meal
    }
}
// MARK: -Enum
enum HeaderFilterType {
    case nationHeader
    case categoryHeader
    case priceRangeHeader
}

enum TypeOfTextFieldForm: Int, CaseIterable {
    case fullName
    case emailAddress
    case phoneNumber
    case password
    case newPassword
    case confirmPassword
    
    var title: String {
        switch self {
        case .fullName:
            return "FULL NAME"
        case .emailAddress:
            return "EMAIL ADDRESS"
        case .phoneNumber:
            return "PHONE NUMBER"
        case .password:
            return "PASSWORD"
        case .newPassword:
            return "NEW PASSWORD"
        case .confirmPassword:
            return "CONFIRM PASSWORD"
        }
    }
    
    var isEyeShow: Bool {
        switch self {
        case .password, .newPassword, .confirmPassword:
            return true
        default: return false
        }
    }
    
}

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

