//
//  ProfileInfomationSettingsViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 19/11/24.
//

import Foundation

final class ProfileInfomationSettingsViewControllerVM {
    private let userCollection = "users"
    var user: User?
    var isChangePassword: Bool
    private(set) var email: String?
    var currentPassword: String?
    var newPassword: String?
    var confirmPassword: String?
    
    init(isChangePassword: Bool = false) {
        self.isChangePassword = isChangePassword
        setUpEmail()
    }
    
    func setUpEmail() {
        email = UserDefaults.standard.string(forKey: UserDefaultsKeys.emailLogin)
    }
    
    func fetchUserData(email: String, completion: @escaping (User?, String) -> Void) {
        db.collection(userCollection).whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                completion(nil, "Error fetching user data: \(error.localizedDescription)")
                return
            }
            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                completion(nil, "No user found with email \(email)")
                return
            }
            // Get Data
            if let document = documents.first {
                let data = document.data()
                // Map data to User model
                if let name = data["fullName"] as? String,
                   let email = data["email"] as? String,
                   let password = data["password"] as? String,
                   let phoneNumber = data["phoneNumber"] as? String {
                    
                    let user = User(name: name, email: email, password: password, phoneNumber: phoneNumber)
                    completion(user, "Get Data Success")
                } else {
                    completion(nil, "Invalid user data format.")
                }
            }
        }
    }

    func updateUserInfo(user: User) async throws -> Bool {
        guard let email = email else {
            throw UserError.emailNotFound
        }
        
        let query = db.collection(userCollection).whereField("email", isEqualTo: email)
        let snapshot = try await query.getDocuments()
        
        guard let document = snapshot.documents.first else {
            throw UserError.notFound(email: email)
        }
        
        let updateData: [String: Any] = [
            "fullName": user.name,
            "password": user.password,
            "phoneNumber": user.phoneNumber
        ]
        
        try await document.reference.updateData(updateData)
        return true
    }
    
    func validatePasswordChange(currentPassword: String,
                                newPassword: String,
                                confirmPassword: String) throws {
        // Validate current password
        guard case .success = validatePassword(currentPassword) else {
            throw UserError.invalidCurrentPassword
        }
        
        // Validate new password
        switch validatePassword(newPassword) {
        case .failure(.empty):
            throw UserError.emptyNewPassword
        case .failure(.invalidLength):
            throw UserError.invalidPasswordLength
        case .failure(.invalidFormat):
            throw UserError.invalidPasswordFormat
        case .success: break
        }
        
        // Check if new password matches confirm password
        guard newPassword == confirmPassword else {
            throw UserError.passwordMismatch
        }
        
        // Check if new password is different from current password
        guard newPassword != currentPassword else {
            throw UserError.sameAsCurrentPassword
        }
    }
    
    func updatePassword(currentPassword: String,
                       newPassword: String,
                       confirmPassword: String) async throws -> Bool {
        guard let email = email else {
            throw UserError.emailNotFound
        }
        
        // Validate passwords
        try validatePasswordChange(currentPassword: currentPassword,
                                 newPassword: newPassword,
                                 confirmPassword: confirmPassword)
        
        let query = db.collection(userCollection)
            .whereField("email", isEqualTo: email)
            .whereField("password", isEqualTo: currentPassword)
        
        let snapshot = try await query.getDocuments()
        
        guard let document = snapshot.documents.first else {
            throw UserError.invalidCurrentPassword
        }
        
        try await document.reference.updateData(["password": newPassword])
        return true
    }
}
