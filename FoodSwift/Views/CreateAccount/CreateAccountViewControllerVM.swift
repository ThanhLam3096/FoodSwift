//
//  CreateAccountViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 24/11/24.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

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
            "phoneNumber": "",
            "nation": ""
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
    
    func connectToGoogleAccount(presentViewController: UIViewController, sosicalAccountCompletion: @escaping (Bool, String) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentViewController) { [unowned self] result, error in
            guard error == nil else {
                sosicalAccountCompletion(false, "Error Can't Connect Your Google Account")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    sosicalAccountCompletion(false, "Error Firebase: \(error.localizedDescription)")
                    return
                }
                
                if let user = result?.user, let name = user.displayName, let email = user.email {
                    self.createAccountWithGoogleAccount(fullName: name, email: email)
                }
                sosicalAccountCompletion(true, "Success Connect Google Account")
                
            }
        }
    }
    
    func createAccountWithGoogleAccount(fullName: String, email: String) {
        let data: [String: Any] =
        [
            "fullName" : fullName,
            "email" : email,
            "password" : "",
            "phoneNumber": "",
            "nation": ""
        ]
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error checking email: \(error.localizedDescription)")
                return
            }
            
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                print("Error : Create Account Failed: Email already exists.")
            } else {
                db.collection("users").addDocument(data: data) { error in
                    if let error = error {
                        print("Error : \(error.localizedDescription)")
                    } else {
                        print("Create Account Success")
                    }
                }
            }
        }
    }
}
