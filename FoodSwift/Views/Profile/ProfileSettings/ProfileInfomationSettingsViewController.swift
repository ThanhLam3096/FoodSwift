//
//  ProfileInfomationSettingsViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 19/11/24.
//

import UIKit

final class ProfileInfomationSettingsViewController: BaseViewController {
    
    // MARK: IBOutlet
    @IBOutlet private weak var profileSettingStackView: UIStackView!
    @IBOutlet private weak var emailFormView: TextFieldLoginView!
    @IBOutlet private weak var passwordFormView: PasswordFormProfileSettingsView!
    @IBOutlet private weak var phoneNumberFormView: TextFieldLoginView!
    @IBOutlet private weak var fullNameFormView: TextFieldLoginView!
    @IBOutlet private weak var changeSettingsButtonView: OrangeButtonView!
    
    // MARK: Constraint
    @IBOutlet private weak var heightOfprofileSettingStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfprofileSettingStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingOfprofileSettingStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfprofileSettingStackViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfChangeSettingButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfChangeSettingButtonConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func setUpUI() {
        setUpNavigation()
        setUpFrameStackView()
        setUpForm()
        setUpChangeSettingsButton()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Profile Settings"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpFrameStackView() {
        profileSettingStackView.spacing = ScreenSize.scaleHeight(18)
        heightOfprofileSettingStackViewConstraint.constant = ScreenSize.scaleHeight(316)
        leadingSpaceOfprofileSettingStackViewConstraint.constant = ScreenSize.scaleWidth(20)
        trailingOfprofileSettingStackViewConstraint.constant = ScreenSize.scaleWidth(20)
        topSpaceOfprofileSettingStackViewConstraint.constant = ScreenSize.scaleHeight(24)
    }
    
    private func setUpForm() {
        emailFormView.viewModel = TextFieldLoginViewVM(typeForm: .emailAddress)
        passwordFormView.viewModel = PasswordFormProfileSettingsViewVM(typeForm: .password)
        phoneNumberFormView.viewModel = TextFieldLoginViewVM(typeForm: .phoneNumber)
        fullNameFormView.viewModel = TextFieldLoginViewVM(typeForm: .fullName)
        passwordFormView.delegate = self
    }
    
    private func setUpChangeSettingsButton() {
        changeSettingsButtonView.viewModel = OrangeButtonViewModel(title: "CHANGE SETTINGS")
        heightOfChangeSettingButtonConstraint.constant = ScreenSize.scaleHeight(48)
        botSpaceOfChangeSettingButtonConstraint.constant = ScreenSize.scaleHeight(30)
    }
}

extension ProfileInfomationSettingsViewController: PasswordFormProfileSettingsViewDelegate {
    func tappingInsideButtonChangePassword(view: PasswordFormProfileSettingsView) {
        print("Move to Screen Change Password")
    }
}
