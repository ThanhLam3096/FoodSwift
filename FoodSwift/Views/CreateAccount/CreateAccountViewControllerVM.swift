//
//  CreateAccountViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 24/11/24.
//

import Foundation
import FirebaseFirestore

let db = Firestore.firestore()

final class CreateAccountViewControllerVM {
    var valueFullName = ""
    var valueEmail = ""
    var valuePassword = ""
    var isValidFullName: Bool = false
    var isValidEmail: Bool = false
    var isValidPassword: Bool = false
    
    // Create Account From FirebaseFirestore
    func createAccount(fullName: String, email: String, password: String, createAccountCompletion: @escaping (Bool, String) -> Void ) {
        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty else {
            createAccountCompletion(false, "Invalid input data")
            return
        }
        
        let data: [String: Any] =
        [
            "fullName" : fullName,
            "email" : email,
            "password" : password,
            "phoneNumber": ""
        ]
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                createAccountCompletion(false, "Error checking email: \(error.localizedDescription)")
                return
            }
            
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                createAccountCompletion(false, "Create Account Failed: Email already exists.")
            } else {
                db.collection("users").addDocument(data: data) { error in
                    if let error = error {
                        createAccountCompletion(false, error.localizedDescription)
                    } else {
                        createAccountCompletion(true, "Create Account Success")
                    }
                }
            }
        }
    }
}
