//
//  OrdersViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/12/24.
//

import Foundation

final class OrdersViewControllerVM {
    
    var upComingOrder: [OrderMeal] = DummyOrderData.dummyOrderData
    var passOrder: [OrderMeal] = DummyOrderData.dummyOrderData
    
    enum YourOrder: Int, CaseIterable  {
        case upComingOrders
        case pastOrders
        
        var title: String {
            switch self {
            case .upComingOrders:
                return "UPCOMING ORDERS"
            case .pastOrders:
                return "PAST ORDERS"
            }
        }
    }
    
    func numberOfSections() -> Int {
        return YourOrder.allCases.count
    }
    
    func numberOfitemInSections(type: YourOrder) -> Int {
        switch type {
        case .upComingOrders:
            return upComingOrder.count
        case .pastOrders:
            return passOrder.count
        }
    }
    
    func cellForRowAtItemsInSection(indexPath: IndexPath, type: YourOrder) -> OrdersTableViewCellVM {
        switch type {
        case .upComingOrders:
            let item = upComingOrder[indexPath.row]
            return OrdersTableViewCellVM(orders: item)
        case .pastOrders:
            let item = passOrder[indexPath.row]
            return OrdersTableViewCellVM(orders: item)
        }
    }
    
    func cellForHeaderSections(type: YourOrder) -> HeaderOrdersTableViewVM {
        return HeaderOrdersTableViewVM(titleHeader: type.title)
    }
    
    func heightForRowItem() -> CGFloat {
        return ScreenSize.scaleHeight(130)
    }
    
    func heightOfHeader() -> CGFloat {
        return ScreenSize.scaleHeight(44)
    }

}
