//
//  VerifyPhoneNumberViewModel.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 28/11/24.
//

import Foundation
import FirebaseAuth

final class VerifyPhoneNumberViewModel {
    
    var email: String = ""
    
    init() {}
    
    init(email: String) {
        self.email = email
    }
    
    // Need Update From Spark Plan (Free) to Blaze Plan (Using Money xD)
    func verifyPhoneNumber(verificationCode: String, completion: @escaping (Bool, String) -> Void) {
        // Get verificationID save
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            completion(false, "Verification ID not found.")
            return
        }

        // Create credential from verificationID and verificationCode
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)

        // Login with Firebase
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                completion(false, "Error verifying phone number: \(error.localizedDescription)")
                return
            }
            completion(true, "Phone number verified successfully!")
        }
    }
    
    func saveLoginStatus(email: String) {
        UserDefaults.standard.set(email, forKey: "emailLogin")
    }
}
