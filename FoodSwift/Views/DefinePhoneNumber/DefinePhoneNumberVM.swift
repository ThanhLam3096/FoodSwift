//
//  DefinePhoneNumberVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 6/9/24.
//

import Foundation
import FirebaseAuth

final class DefinePhoneNumberVM {
    private let userCollection = "users"
    var indexOfNationFlagsList = 0
    var email: String = ""
    
    init() {}
    
    init(email: String) {
        self.email = email
    }
    
    // MARK: - TableView Data
    func numberOfRowsInSection() -> Int {
        return listFlagTitle.count
    }

    func cellForRowAt(indexPath: IndexPath) -> FlagCodeNumberCellVM {
        let itemNation = listFlagTitle[indexPath.row]
        let itemFlag = nameFlag[indexPath.row]
        let model = FlagCodeNumberCellVM(nation: itemNation, imgNation: itemFlag)
        return model
    }

    func heightForRowAt() -> CGFloat {
        return 36
    }
    
    func addPhoneNumberUserInfo(phoneNumber: String, nation: String) async throws -> Bool {
        guard email != "" else {
            throw UserError.emailNotFound
        }
        
        let query = db.collection(userCollection).whereField("email", isEqualTo: email)
        let snapshot = try await query.getDocuments()
        
        guard let document = snapshot.documents.first else {
            throw UserError.notFound(email: email)
        }
        
        guard isValidPhoneNumber(phoneNumber) else {
            throw UserError.phoneNumberInvalid
        }
        
        let updateData: [String: Any] = [
            "phoneNumber": phoneNumber,
            "nation": nation
        ]
        
        try await document.reference.updateData(updateData)
        return true
    }
    
    // Need Update From Spark Plan (Free) to Blaze Plan (Using Money xD)
    func sendVerificationCode(to phoneNumber: String, verificationCodeCompletion: @escaping (Bool, String) -> Void) {
        // Verify With FireBase
        let phoneNumber = phoneNumber // Example: +84 0903019621

        // Create instance of PhoneAuthProvider
        let phoneAuthProvider = PhoneAuthProvider.provider()

        phoneAuthProvider.verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error as NSError? {
                verificationCodeCompletion(false, "Error sending verification code: \(error.localizedDescription)")
                return
            }
            
            // Save Verify Code to UserDefaults
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            verificationCodeCompletion(true, "Verification code sent successfully.")
        }
    }
}
