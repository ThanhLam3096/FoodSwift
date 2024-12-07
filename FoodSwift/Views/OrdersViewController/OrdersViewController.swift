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
    var popUp: PopUpView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.setUpEmail()
//        fetchDataMealOrder()
        setupRealTimeUpdates()
    }

    override func setUpUI() {
        title = "Orders"
    }
    
    private func setUpTableView() {
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        ordersTableView.register(nibWithCellClass: OrdersTableViewCell.self)
        ordersTableView.register(nibWithCellClass: EmptyDataOrderTableViewCell.self)
        ordersTableView.register(headerFooterViewClassWith: HeaderOrdersTableView.self)
        ordersTableView.register(headerFooterViewClassWith: FooterOrdersTableView.self)
        ordersTableView.reloadData()
    }
}

extension OrdersViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
}

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let typeSection = YourOrder(rawValue: section) else { return 0 }
        return viewModel.numberOfItemInSections(type: typeSection)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typeSection = YourOrder(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch typeSection {
        case .upComingOrders:
            if viewModel.isUpComingOrdersEmpty {
                let cell = tableView.dequeueReusableCell(withClass: EmptyDataOrderTableViewCell.self, for: indexPath)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withClass: OrdersTableViewCell.self, for: indexPath)
                cell.viewModel = viewModel.cellForRowAtItemsInSection(indexPath: indexPath, type: typeSection)
                return cell
            }
        case .pastOrders:
            if viewModel.isHistoryOrdersEmpty {
                let cell = tableView.dequeueReusableCell(withClass: EmptyDataOrderTableViewCell.self, for: indexPath)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withClass: OrdersTableViewCell.self, for: indexPath)
                cell.viewModel = viewModel.cellForRowAtItemsInSection(indexPath: indexPath, type: typeSection)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let typeSection = YourOrder(rawValue: indexPath.section) else {
            return 0
        }
        return viewModel.heightForRowItem(type: typeSection)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.tableHeaderView = nil
        guard let typeSection = YourOrder(rawValue: section)
        else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: HeaderOrdersTableView.self)
        headerView.viewModel = viewModel.cellForHeaderSections(type: typeSection)
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.tableFooterView = nil
        guard let typeSection = YourOrder(rawValue: section)
        else { return nil }
        switch typeSection {
        case .upComingOrders:
            if viewModel.isUpComingOrdersEmpty == true {
                return UIView()
            } else {
                let footerView = tableView.dequeueReusableHeaderFooterView(withClass: FooterOrdersTableView.self)
                footerView.delegate = self
                return footerView
            }
        case .pastOrders:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightOfHeader()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let typeSection = YourOrder(rawValue: section) else {return 0}
        switch typeSection {
        case .upComingOrders:
            return ScreenSize.scaleHeight(40)
        case .pastOrders:
            return 0
        }
    }
}

extension OrdersViewController: HeaderOrdersTableViewDelegate {    
    func tappingClearAllButton(view: HeaderOrdersTableView, type: YourOrder) {
        switch type {
        case .upComingOrders:
            clearAllDataOrder(collectionDB: App.String.collectionDBOrder)
        case .pastOrders:
            clearAllDataOrder(collectionDB: App.String.collectionDBHistoryOrder)
        }
    }
}

extension OrdersViewController: FooterOrdersTableViewDelegate {
    func tappingPaymentProceed(view: FooterOrdersTableView) {
        self.navigationController?.pushViewController(ScreenName.yourOrder, animated: true)
    }
}
 
extension OrdersViewController {
    private func clearAllDataOrder(collectionDB: String) {
        HUD.show()
        Task {
            let result = await viewModel.clearOrderMeal(collectionDB: collectionDB)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch result {
                case .success:
                    HUD.dismiss()
                    ordersTableView.reloadData()
                case .failure(let error):
                    HUD.dismiss()
                    self.showPopUp(title: error.message.localizedCapitalized, isSuccess: false)
                }
            }
        }
    }
    
    private func fetchDataMealOrder() {
        HUD.show()
        Task {
            let result = await viewModel.getDataOrderMealByEmail(dbCollection: App.String.collectionDBOrder)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch result {
                case .success:
                    fetchDataHistoryMealOrder()
                case .failure(let error):
                    switch error {
                    case .noDataFound(_):
                        self.viewModel.isUpComingOrdersEmpty = true
                        fetchDataHistoryMealOrder()
                    default:
                        fetchDataHistoryMealOrder()
                    }
                }
            }
        }
    }
    
    private func fetchDataHistoryMealOrder() {
        Task {
            let result = await viewModel.getDataOrderMealByEmail(dbCollection: App.String.collectionDBHistoryOrder)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                HUD.dismiss()
                
                switch result {
                case .success:
                    self.setUpTableView()
                case .failure(let error):
                    switch error {
                    case .noDataFound(_):
                        self.viewModel.isHistoryOrdersEmpty = true
                        self.setUpTableView()
                    default:
                        // Xử lý các lỗi khác
                        self.showPopUp(title: error.message, isSuccess: false)
                    }
                }
            }
        }
    }
}

// Popup
extension OrdersViewController: PopUpViewDelegate {
    private func showPopUp(title: String, isSuccess: Bool) {
        // MARK: - Setup PopUp
        popUp = PopUpView(frame: view.frame, inView: self)
        popUp?.delegate = self
        popUp?.viewModel = PopUpViewVM(
            title: title,
            isSuccesPopup: isSuccess
        )
        
        // MARK: - Add to view hierarchy with animation
        addPopUpToViewHierarchy()
        animatePopUpPresentation()
    }
    
    func addPopUpToViewHierarchy() {
        guard let popUp = popUp else { return }
        
        // Set initial transform
        let initialTransform = CGAffineTransform(a: Constants.initialScale, b: Constants.initialScale, c: Constants.initialScale, d: Constants.initialScale, tx: Constants.initialScale, ty: Constants.initialScale)
        popUp.transform = initialTransform
        
        // Add to view
        view.addSubview(popUp)
    }
    
    func animatePopUpPresentation() {
        UIView.animate(
            withDuration: Constants.animationDuration,
            delay: 0,
            options: .curveEaseOut
        ) { [weak self] in
            self?.popUp?.transform = .identity
        }
    }
    
    func didTappingButton(view: PopUpView, isSuccess: Bool) {
        self.popUp?.removeFromSuperview()
    }
}

// Real Time
extension OrdersViewController {
    private func setupRealTimeUpdates() {
        // Listen for upcoming orders
        viewModel.listenToOrderChanges(dbCollection: App.String.collectionDBOrder) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.listenToPastOrders()
            case .failure(let error):
                switch error {
                case .noDataFound(_):
                    self.viewModel.isUpComingOrdersEmpty = true
                    self.listenToPastOrders()
                default:
                    self.listenToPastOrders()
                }
            }
        }
    }
    
    private func listenToPastOrders() {
        viewModel.listenToOrderChanges(dbCollection: App.String.collectionDBHistoryOrder) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.setUpTableView()
                case .failure(let error):
                    switch error {
                    case .noDataFound(_):
                        self.viewModel.isHistoryOrdersEmpty = true
                        self.setUpTableView()
                    default:
                        self.showPopUp(title: error.message, isSuccess: false)
                    }
                }
            }
        }
    }
}
