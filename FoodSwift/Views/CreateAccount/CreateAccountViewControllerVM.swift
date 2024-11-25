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
            "password" : password
        ]
        print("Check Data == \(data)")
        
        //        do {
        //            db.collection("users").addDocument(data: data)
        //            createAccountCompletion(true, "Create Account Success")
        //        } catch {
        //            print("Error adding document: \(error)")
        //            createAccountCompletion(false, error.localizedDescription)
        //        }
        db.collection("users").addDocument(data: data) { error in
            if let error = error {
                print("Error Code: \((error as NSError).code)")
                print("Error adding document: \(error.localizedDescription)")
                createAccountCompletion(false, error.localizedDescription)
            } else {
                createAccountCompletion(true, "Create Account Success")
            }
        }
    }
}
