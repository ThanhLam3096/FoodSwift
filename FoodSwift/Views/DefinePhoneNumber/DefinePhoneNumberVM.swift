//
//  DefinePhoneNumberVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 6/9/24.
//

import Foundation

final class DefinePhoneNumberVM {
    let listFlagTitle: [String] = ["Viet Nam", "USA", "France", "England", "China", "Japan", "India", "Australia", "Russia", "Germany", "Spanish", "Argentina", "Brazil"]
    let nameFlag: [String] = ["VietNam", "USA", "France", "England", "China", "Japan", "Indian", "Australia", "Russia", "Germany", "Spanish", "Argentina", "Brazil"]
    let codeNumber = ["+84", "+1", "+33", "+44", "+86", "+81", "+91", "+61", "+7", "+49", "+34", "+54", "+55"]
    var indexOfNationFlagsList = 0
    
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
}
