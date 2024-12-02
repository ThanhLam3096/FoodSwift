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
    var popUp: PopUpView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        checkForm()
        getInfoFromFirebase { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.setUpFormProfileInfo()
            }
        }
    }

    override func setUpUI() {
        setUpDefaulFormProfileInfo()
        getInfoFromFirebase { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.setUpFormProfileInfo()
            }
        }
        setUpNavigation()
        setUpFrameStackView()
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
    
    private func setUpDefaulFormProfileInfo() {
        emailFormView.viewModel = TextFieldLoginViewVM(typeForm: .emailAddress, isEnable: false, value: "")
        passwordFormView.viewModel = PasswordFormProfileSettingsViewVM(typeForm: .password, value: "")
        phoneNumberFormView.viewModel = TextFieldLoginViewVM(typeForm: .phoneNumber, value: "")
        fullNameFormView.viewModel = TextFieldLoginViewVM(typeForm: .fullName, value: "")
    }
    
    private func setUpFormProfileInfo() {
        guard let user = viewModel.user else { return }
        setUpTextFieldForm(textField: emailFormView, type: .emailAddress, isEnable: false, value: user.email)
        setUpTextFieldForm(textField: fullNameFormView, type: .fullName, value: user.name)
        setUpTextFieldForm(textField: phoneNumberFormView, type: .phoneNumber, value: user.phoneNumber)
        passwordFormView.viewModel = PasswordFormProfileSettingsViewVM(typeForm: .password, value: user.password)
        passwordFormView.delegate = self
    }
    
    private func setUpFormChangePassword() {
        setUpTextFieldForm(textField: currentPasswordFormView, type: .password)
        setUpTextFieldForm(textField: newPasswordFormView, type: .newPassword)
        setUpTextFieldForm(textField: confirmPasswordFormView, type: .confirmPassword)
    }
    
    private func setUpTextFieldForm(textField: TextFieldLoginView, type: TypeOfTextFieldForm, isEnable: Bool = true, value: String = "") {
        textField.viewModel = TextFieldLoginViewVM(typeForm: type, isEnable: isEnable, value: value)
        textField.delegate = self
    }
    
    private func setUpChangeSettingsButton() {
        changeSettingsButtonView.viewModel = OrangeButtonViewModel(title: "CHANGE SETTINGS")
        heightOfChangeSettingButtonConstraint.constant = ScreenSize.scaleHeight(48)
        botSpaceOfChangeSettingButtonConstraint.constant = ScreenSize.scaleHeight(30)
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
        changeSettingsButtonView.delegate = self
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

extension ProfileInfomationSettingsViewController {
    private func getInfoFromFirebase(completion: @escaping () -> Void) {
        HUD.show()
        guard let email = viewModel.email else
        {
            completion()
            return
        }
        viewModel.fetchUserData(email: email) { [weak self] userResult, message in
            guard let this = self else { return }
            if let userResult = userResult {
                this.viewModel.user = userResult
                HUD.dismiss()
                completion()
            } else {
                HUD.dismiss()
                completion()
                print(message)
            }
        }
    }
    
    private func updateInfoUser(user: User) {
        Task {
            do {
                let success = try await viewModel.updateUserInfo(user: user)
                if success {
                    showPopUp(title: "Update user information successfully", isSuccess: success)
                } else {
                    showPopUp(title: "Can't Change information Please Try Again", isSuccess: success)
                }
            } catch let error as UserError {
                showPopUp(title: error.errorDescription ?? "Unknown error occurred", isSuccess: false)
                showAlert(message: error.errorDescription ?? "Unknown error occurred")
            } catch {
                showPopUp(title: error.localizedDescription, isSuccess: false)
            }
        }
    }
    
    private func updatePasswordInfoUser(currentPassword: String, newPassword: String, confirmPassword: String) {
        Task {
            do {
                let success = try await viewModel.updatePassword(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword)
                if success {
                    showPopUp(title: "Update Password information successfully", isSuccess: success)
                } else {
                    showPopUp(title: "Can't Change Password Please try again", isSuccess: success)
                }
            } catch let error as UserError {
                showPopUp(title: error.errorDescription ?? "Unknown error occurred", isSuccess: false)
            } catch {
                showPopUp(title: error.localizedDescription, isSuccess: false)
            }
        }
    }
    
    private func showPopUp(title: String, isSuccess: Bool) {
        self.popUp = PopUpView(frame: self.view.frame, inView: self)
        self.popUp.delegate = self
        self.popUp.viewModel = PopUpViewVM(title: title, isSuccesPopup: isSuccess)
        self.view.addSubview(self.popUp)
        self.popUp.transform = CGAffineTransform(a: 0.8, b: 0.8, c: 0.8, d: 0.8, tx: 0.8, ty: 0.8)
        UIView.animate(withDuration: 0.3) {
            self.popUp.transform = CGAffineTransform.identity
        }
    }
}

extension ProfileInfomationSettingsViewController: FormTextFieldDelegate {
    func getValueTextField(value: String, type: TypeOfTextFieldForm, isValid: Bool, view: TextFieldLoginView) {
        switch type {
        case .fullName:
            viewModel.user?.name = value
        case .emailAddress:
            viewModel.user?.email = value
        case .phoneNumber:
            viewModel.user?.phoneNumber = value
        case .password:
            viewModel.currentPassword = value
        case .newPassword:
            viewModel.newPassword = value
        case .confirmPassword:
            viewModel.confirmPassword = value
        }
    }
}

extension ProfileInfomationSettingsViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        guard let user = viewModel.user else { return }
        if viewModel.isChangePassword {
            guard let currentPassword = viewModel.currentPassword, let newPassword = viewModel.newPassword, let confirmPassword = viewModel.confirmPassword else { return }
            updatePasswordInfoUser(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword)
        } else {
            updateInfoUser(user: user)
        }
    }
}

extension ProfileInfomationSettingsViewController: PopUpViewDelegate {
    func didTappingButton(view: PopUpView, isSuccess: Bool) {
        self.popUp?.removeFromSuperview()
        if isSuccess {
            self.navigationController?.popViewController(animated: true)
        } else {
            return
        }
    }
}
