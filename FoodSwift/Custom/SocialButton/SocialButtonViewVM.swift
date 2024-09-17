//
//  SocialButtonViewVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 2/9/24.
//

import Foundation

class SocialButtonViewVM {
    
    // MARK: - Properties
    var socialTitle: String
    var nameIcon: String
    var titleSocialButton: String

    init(socialTitle: String, nameIcon: String, titleSocialButton: String) {
        self.socialTitle = socialTitle
        self.nameIcon = nameIcon
        self.titleSocialButton = titleSocialButton
    }
}
