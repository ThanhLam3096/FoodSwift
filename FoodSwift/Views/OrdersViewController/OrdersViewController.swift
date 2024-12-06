//
//  OrdersViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 4/10/24.
//

import UIKit

final class OrdersViewController: BaseViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var ordersTableView: UITableView!
    
    // MARK: - Properties
    var viewModel: OrdersViewControllerVM = OrdersViewControllerVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setUpUI() {
        title = "Orders"
        setUpTableView()
    }
    
    private func setUpTableView() {
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        ordersTableView.register(nibWithCellClass: OrdersTableViewCell.self)
        ordersTableView.register(headerFooterViewClassWith: HeaderOrdersTableView.self)
        ordersTableView.register(headerFooterViewClassWith: FooterOrdersTableView.self)
    }
}

extension OrdersViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
}

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let typeSection = OrdersViewControllerVM.YourOrder(rawValue: section) else { return 0 }
        return viewModel.numberOfitemInSections(type: typeSection)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typeSection = OrdersViewControllerVM.YourOrder(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withClass: OrdersTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAtItemsInSection(indexPath: indexPath, type: typeSection)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowItem()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.tableHeaderView = nil
        guard let typeSection = OrdersViewControllerVM.YourOrder(rawValue: section)
        else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: HeaderOrdersTableView.self)
        headerView.viewModel = viewModel.cellForHeaderSections(type: typeSection)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.tableFooterView = nil
        guard let typeSection = OrdersViewControllerVM.YourOrder(rawValue: section)
        else { return nil }
        switch typeSection {
        case .upComingOrders:
            let footerView = tableView.dequeueReusableHeaderFooterView(withClass: FooterOrdersTableView.self)
            footerView.delegate = self
            return footerView
        case .pastOrders:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightOfHeader()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let typeSection = OrdersViewControllerVM.YourOrder(rawValue: section) else {return 0}
        switch typeSection {
        case .upComingOrders:
            return ScreenSize.scaleHeight(40)
        case .pastOrders:
            return 0
        }
    }
}

extension OrdersViewController: FooterOrdersTableViewDelegate {
    func tappingPaymentProceed(view: FooterOrdersTableView) {
        print("Move To Payment Order Meal")
    }
}
