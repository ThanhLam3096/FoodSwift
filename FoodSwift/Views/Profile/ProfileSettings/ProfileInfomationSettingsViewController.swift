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
    
    @IBOutlet private weak var changePasswordStackView: UIStackView!
    @IBOutlet private weak var currentPasswordFormView: TextFieldLoginView!
    @IBOutlet private weak var newPasswordFormView: TextFieldLoginView!
    @IBOutlet private weak var confirmPasswordFormView: TextFieldLoginView!
    
    // MARK: Constraint
    @IBOutlet private weak var heightOfProfileSettingStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfprofileSettingStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingOfprofileSettingStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfprofileSettingStackViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfChangeSettingButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfChangeSettingButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfChangePasswordStackViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: ProfileInfomationSettingsViewControllerVM = ProfileInfomationSettingsViewControllerVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        checkForm()
    }

    override func setUpUI() {
        setUpNavigation()
        setUpFrameStackView()
        setUpFormProfileInfo()
        setUpChangeSettingsButton()
        setUpFormChangePassword()
        checkForm()
        actionOfTappingOutSideHideOfKeyBoard()
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
        if viewModel.isChangePassword {
            profileSettingStackView.isHidden = true
        } else {
            profileSettingStackView.isHidden = false
        }
        
        profileSettingStackView.spacing = ScreenSize.scaleHeight(18)
        heightOfProfileSettingStackViewConstraint.constant = ScreenSize.scaleHeight(316)
        leadingSpaceOfprofileSettingStackViewConstraint.constant = ScreenSize.scaleWidth(20)
        trailingOfprofileSettingStackViewConstraint.constant = ScreenSize.scaleWidth(20)
        topSpaceOfprofileSettingStackViewConstraint.constant = ScreenSize.scaleHeight(24)
        
        changePasswordStackView.spacing = ScreenSize.scaleHeight(18)
        heightOfChangePasswordStackViewConstraint.constant = ScreenSize.scaleHeight(213)
    }
    
    private func setUpFormProfileInfo() {
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
    
    private func setUpFormChangePassword() {
        currentPasswordFormView.viewModel = TextFieldLoginViewVM(typeForm: .password)
        newPasswordFormView.viewModel = TextFieldLoginViewVM(typeForm: .newPassword)
        confirmPasswordFormView.viewModel = TextFieldLoginViewVM(typeForm: .confirmPassword)
    }
    
    private func checkForm() {
        if viewModel.isChangePassword {
            changePasswordStackView.isHidden = !viewModel.isChangePassword
            profileSettingStackView.isHidden = viewModel.isChangePassword
            changeSettingsButtonView.viewModel = OrangeButtonViewModel(title: "CHANGE PASSWORD")
            changeTitleSettingsButton(title: "CHANGE PASSWORD")
        } else {
            changePasswordStackView.isHidden = !viewModel.isChangePassword
            profileSettingStackView.isHidden = viewModel.isChangePassword
            changeSettingsButtonView.viewModel = OrangeButtonViewModel(title: "CHANGE SETTINGS")
            changeTitleSettingsButton(title: "CHANGE SETTINGS")
        }
    }
    
    private func changeTitleSettingsButton(title: String) {
        changeSettingsButtonView.viewModel = OrangeButtonViewModel(title: title)
    }
}

extension ProfileInfomationSettingsViewController: PasswordFormProfileSettingsViewDelegate {
    func tappingInsideButtonChangePassword(view: PasswordFormProfileSettingsView) {
        viewModel.isChangePassword = true
        checkForm()
        changeTitleSettingsButton(title: "CHANGE PASSWORD")
    }
}

extension ProfileInfomationSettingsViewController {
    private func actionOfTappingOutSideHideOfKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
