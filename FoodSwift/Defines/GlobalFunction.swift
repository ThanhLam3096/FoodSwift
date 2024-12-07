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

enum CreditCardType: Int, CaseIterable {
    case payPal
    case masterCard
    case visa
    
    var title: String {
        switch self {
        case .payPal:
            return "PayPal"
        case .masterCard:
            return "MasterCard"
        case .visa:
            return "Visa"
        }
    }
    
    var icon: String {
        switch self {
        case .payPal:
            return "PayPal"
        case .masterCard:
            return "MasterCard"
        case .visa:
            return "Visa"
        }
    }
}

enum SocialAccountType: String {
    case facebook = "facebook"
    case google = "google"
    
    var title: String {
        switch self {
        case .facebook:
            return "CONNECT WITH FACEBOOK"
        case .google:
            return "CONNECT WITH GOOGLE"
        }
    }
    
    var color: UIColor {
        switch self {
        case .facebook:
            return UIColor(hex: "#395998")
        case .google:
            return UIColor(hex: "#4285F4")
        }
    }
}

enum UserDefaultsKeys {
    static let emailLogin = "emailLogin"
}

// MARK: - Error Handling
enum PasswordValidationResult {
    case success
    case failure(PasswordValidationError)
}

enum PasswordValidationError {
    case empty
    case invalidLength
    case invalidFormat
}

enum UserError: LocalizedError {
    case notFound(email: String)
    case userNameInvalid
    case phoneNumberInvalid
    case invalidData
    case emailNotFound
    case emptyNewPassword
    case invalidPasswordLength
    case invalidPasswordFormat
    case passwordMismatch
    case invalidCurrentPassword
    case newAndConfirmPasswordIsInvalid
    case sameAsCurrentPassword
    
    var errorDescription: String? {
        switch self {
        case .notFound(let email):
            return "User not found with email: \(email)"
        case .userNameInvalid:
            return "The user needs 4 or more characters and no special characters."
        case .phoneNumberInvalid:
            return "Invalid phone number format."
        case .emptyNewPassword:
            return "New password cannot be empty"
        case .invalidPasswordLength:
            return "Password must be between 8 and 20 characters"
        case .invalidPasswordFormat:
            return "Password must contain at least one uppercase letter, one lowercase letter, one number and one special character"
        case .invalidData:
            return "Invalid user data format"
        case .emailNotFound:
            return "Email not found"
        case .newAndConfirmPasswordIsInvalid:
            return "New Password Or Confirm Password is invalid Please Try Again"
        case .passwordMismatch:
            return "New password and confirm password do not match"
        case .invalidCurrentPassword:
            return "Current password is incorrect"
        case .sameAsCurrentPassword:
            return "New password must be different from current password"
        }
    }
}

enum OrderError: Error {
    case emailNotFound
    case noDataFound(email: String)
    case fetchError(Error)
    case parseError
    case totalFieldMissing
    case firebaseError(Error)
    case saveHistoryError(Error)
    
    var message: String {
        switch self {
        case .emailNotFound:
            return "Can't Connect Your Account"
        case .noDataFound(let email):
            return "Can't Found Your Order in your account \(email)"
        case .fetchError(let error):
            return "Failed to Load Data: \(error.localizedDescription)"
        case .parseError:
            return "Faild to Parse Data"
        case .totalFieldMissing:
            return "Missing Info quality"
        case .firebaseError(let error):
            return "Error System: \(error.localizedDescription)"
        case .saveHistoryError(let error):
            return "Failed when Orders: \(error.localizedDescription)"
        }
    }
}

enum YourOrder: Int, CaseIterable  {
    case upComingOrders
    case pastOrders
    
    var title: String {
        switch self {
        case .upComingOrders:
            return "UPCOMING ORDERS"
        case .pastOrders:
            return "PAST ORDERS"
        }
    }
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func isValidNameUser(_ userName: String) -> Bool {
    let userNameRegEx = "^[\\p{L}\\d ]{4,}$"

    let userNamePred = NSPredicate(format:"SELF MATCHES %@", userNameRegEx)
    return userNamePred.evaluate(with: userName)
}

func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
    let phoneRegex = #"^\+(84|1|33|44|86|81|91|61|7|49|34|54|55)\d{6,12}$"#
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    return phoneTest.evaluate(with: phoneNumber)
}

func isValidUserPassword(_ userPassword: String) -> Bool {
    let userPasswordRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"

    let userPasswordPred = NSPredicate(format:"SELF MATCHES %@", userPasswordRegEx)
    return userPasswordPred.evaluate(with: userPassword)
}

struct PasswordValidation {
    static let minimumLength = 8
    static let maximumLength = 20
    static let pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
}

func validatePassword(_ password: String) -> PasswordValidationResult {
    // Check empty
    guard !password.isEmpty else {
        return .failure(.empty)
    }
    
    // Check length
    guard (PasswordValidation.minimumLength...PasswordValidation.maximumLength).contains(password.count) else {
        return .failure(.invalidLength)
    }
    
    // Check pattern
    guard password.range(of: PasswordValidation.pattern, options: .regularExpression) != nil else {
        return .failure(.invalidFormat)
    }
    
    return .success
}

enum Constants {
    static let animationDuration: TimeInterval = 0.3
    static let initialScale: CGFloat = 0.8
    static let finalScale: CGFloat = 1.0
}

let listFlagTitle: [String] = ["Viet Nam", "USA", "France", "England", "China", "Japan", "India", "Australia", "Russia", "Germany", "Spanish", "Argentina", "Brazil"]
let nameFlag: [String] = ["VietNam", "USA", "France", "England", "China", "Japan", "India", "Australia", "Russia", "Germany", "Spanish", "Argentina", "Brazil"]
let codeNumber = ["+84", "+1", "+33", "+44", "+86", "+81", "+91", "+61", "+7", "+49", "+34", "+54", "+55"]
