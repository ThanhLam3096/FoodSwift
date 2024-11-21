//
//  ProfileViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 4/10/24.
//

import UIKit
import StoreKit

final class ProfileViewController: BaseViewController {
    
    // MARK: -IBOulet
    @IBOutlet private weak var profileTableView: UITableView!
    
    // MARK: -NSLayoutConstraint
//    @IBOutlet weak var topSpaceOfTableViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: ProfileViewControllerViewModel = ProfileViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func setUpUI() {
        setUpTableView()
//        topSpaceOfTableViewConstraint.constant = ScreenSize.scaleHeight(68)
    }
    
    private func setUpTableView() {
        profileTableView.tableHeaderView = nil
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        profileTableView.register(nibWithCellClass: ProfileTableViewCell.self)
        profileTableView.register(headerFooterViewClassWith: ProfileAccoutnSettingHeaderTableView.self)
        profileTableView.register(headerFooterViewClassWith: ProfileMoreAndNotiHeaderTableView.self)
        profileTableView.separatorStyle = .none
    }
    
    private func ratingApp() {
        guard let scene = view.window?.windowScene else { return }
        SKStoreReviewController.requestReview(in: scene)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let accountSettingSections = AccountSettingSection(rawValue: section) else {return 0}
        return viewModel.numberOfItemInSections(section: accountSettingSections)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let accountSettingSections = AccountSettingSection(rawValue: indexPath.section)
        else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withClass: ProfileTableViewCell.self, for: indexPath)
        cell.delegate = self
        cell.viewModel = viewModel.cellForRowAtItem(indexPath: indexPath, sections: accountSettingSections)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForItemAccountSettings()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.tableHeaderView = nil
        guard let accountSettingSections = AccountSettingSection(rawValue: section)
        else { return nil }
        switch accountSettingSections {
        case .accountSettings:
            let headerCell = tableView.dequeueReusableHeaderFooterView(withClass: ProfileAccoutnSettingHeaderTableView.self)
            return headerCell
        case .notifications, .more:
            let headerCell = tableView.dequeueReusableHeaderFooterView(withClass: ProfileMoreAndNotiHeaderTableView.self)
            headerCell.viewModel = viewModel.dataHeaderForSection(sections: accountSettingSections)
            return headerCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let accountSettingSections = AccountSettingSection(rawValue: indexPath.section)
        else { return }
        let item = accountSettingSections.items[indexPath.row]
        switch item {
        case .profileInfo:
            navigationController?.pushViewController(ScreenName.profileSettingInfo, animated: true)
        default:
            print("Do Something")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let accountSettingSections = AccountSettingSection(rawValue: section)
        else { return 0 }
        return viewModel.heightForHeaderSectionAccountSettings(sections: accountSettingSections)
    }
}

extension ProfileViewController:  ProfileTableViewCellDelegate {
    func tappingArrowButton(view: ProfileTableViewCell, typeItem: AccountSettingItem) {
        switch typeItem {
        case .profileInfo:
            let vc = ScreenName.profileSettingInfo
            vc.viewModel = ProfileInfomationSettingsViewControllerVM(isChangePassword: false)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        case .changePassword:
            let vc = ScreenName.profileSettingInfo
            vc.viewModel = ProfileInfomationSettingsViewControllerVM(isChangePassword: true)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        case .paymentMethods:
            let vc = ScreenName.addCreditCard
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        case .locations:
            print("Locations")
        case .addSocialAccount:
            let vc = ScreenName.connectSocicalAccount
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        case .referToFriends:
            let vc = ScreenName.referToFriend
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        case .rateUs:
            ratingApp()
        case .faq:
            print("Faq")
        case .logout:
            print("Logout")
        default: print("Do Something")
        }
    }
}
