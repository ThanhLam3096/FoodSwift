//
//  LaunchScreenViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 28/11/24.
//

import Foundation

final class LaunchScreenViewControllerVM {
    func getToHitorySearch() -> Bool {
        if let emailLogin = UserDefaults.standard.string(forKey: "emailLogin") {
            return true
        } else {
            return false
        }
    }
}
