//
//  SigninViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/11/24.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

final class SigninViewControllerVM {
    var valueEmail: String = ""
    var valuePassword: String = ""
    
    func checkAccount(email: String, password: String, loginAccountCompletion: @escaping (Bool, String) -> Void ) {
        guard !email.isEmpty, !password.isEmpty else {
            loginAccountCompletion(false, "Invalid input data")
            return
        }

        db.collection("users").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                loginAccountCompletion(false, "Error checking email: \(error.localizedDescription)")
                return
            }
            
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                db.collection("users").whereField("password", isEqualTo: password).getDocuments { querySnapshot, error in
                    if let error = error {
                        loginAccountCompletion(false, "Error checking Password: \(error.localizedDescription)")
                        return
                    }
                    if let documents = querySnapshot?.documents, !documents.isEmpty {
                        loginAccountCompletion(true, "Login Success, Enjoy")
                    } else {
                        loginAccountCompletion(false, "Error: Email or password is incorrect. Please Try Again")
                    }
                }
            } else {
                loginAccountCompletion(false, "Error: Email or password is incorrect. Please Try Again")
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
            "phoneNumber": ""
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
