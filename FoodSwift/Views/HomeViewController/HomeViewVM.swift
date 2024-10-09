//
//  HomeViewVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/10/24.
//

import Foundation

final class HomeViewVM {
    let listLocation: [String] = ["Ha Noi, Viet Nam", "New York, USA", "Parisn, France", "London, England", "Bac Kinh, China", "Tokyo, Japan", "Malina, India", "Kevin, Australia", "Moccow, Russia", "Munich ,Germany", "Madrid, Spanish", "Buenos Aires, Argentina", "Brasília, Brazil"]
    
    // MARK: - TableView Data
    func numberOfRowsInSection() -> Int {
        return listLocation.count
    }

    func cellForRowAt(indexPath: IndexPath) -> LocationListViewModel {
        let itemLocaiton = listLocation[indexPath.row]
        let model = LocationListViewModel(location: itemLocaiton)
        return model
    }

    func heightForRowAt() -> CGFloat {
        return 36
    }
}
