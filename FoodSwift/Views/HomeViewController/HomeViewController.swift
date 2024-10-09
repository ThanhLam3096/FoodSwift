//
//  HomeViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/10/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var headerHomeView: HeaderHomeView!
    @IBOutlet private weak var locationListTableView: UITableView!
    
    // MARK: - Properties
    var viewModel: HomeViewVM = HomeViewVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func setUpUI() {
        setUPTableView()
        headerHomeView.delegate = self
    }
    
    private func setUPTableView() {
        locationListTableView.register(nibWithCellClass: LocationListTableViewCell.self)
        locationListTableView.isHidden = true
        locationListTableView.delegate = self
        locationListTableView.dataSource = self
    }

}

extension HomeViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LocationListTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = viewModel.listLocation[indexPath.row]
        headerHomeView.viewModel = HeaderHomeVM(location: location)
        locationListTableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt()
    }
}

extension HomeViewController: HeaderHomeViewDelegate {
    func tappingInsideList(view: HeaderHomeView) {
        locationListTableView.isHidden = !locationListTableView.isHidden
    }
}
