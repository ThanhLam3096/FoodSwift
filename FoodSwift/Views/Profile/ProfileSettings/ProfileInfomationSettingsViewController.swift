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
    @IBOutlet private weak var listFlagTableView: UITableView!
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    // MARK: Constraint
    @IBOutlet private weak var heightOfProfileSettingStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfprofileSettingStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingOfprofileSettingStackViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfChangeSettingButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfChangeSettingButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfChangePasswordStackViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfTableViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfAvatarImageViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: ProfileInfomationSettingsViewControllerVM = ProfileInfomationSettingsViewControllerVM()
    var popUp: PopUpView?
    var popUpCameraLibrary: PopupChooseImage?

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
        settingAvatarImageView()
        setUpChangeSettingsButton()
        setUpFormChangePassword()
        checkForm()
        actionOfTappingOutSideHideOfKeyBoard()
        setUpTableView()
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
        changePasswordStackView.spacing = ScreenSize.scaleHeight(18)
        heightOfChangePasswordStackViewConstraint.constant = ScreenSize.scaleHeight(213)
    }
    
    private func settingAvatarImageView() {
        avatarImageView.image = UIImage(named: "default_avatar")
        avatarImageView.layer.cornerRadius = ScreenSize.scaleWidth(50)
        widthOfAvatarImageViewConstraint.constant = ScreenSize.scaleWidth(100)
        
        avatarImageView.isUserInteractionEnabled = true // accpect image take action
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeAvatarTapping))
        avatarImageView.addGestureRecognizer(tapGesture)
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
        setUpTextFieldForm(textField: phoneNumberFormView, type: .phoneNumber, value: user.phoneNumber, codePhoneNumber: codeNumber[viewModel.indexOfNationFlagsList], imageName: user.nation)
        phoneNumberFormView.delegatePhoneNumber = self
        passwordFormView.viewModel = PasswordFormProfileSettingsViewVM(typeForm: .password, value: user.password)
        passwordFormView.delegate = self
    }
    
    private func setUpFormChangePassword() {
        setUpTextFieldForm(textField: currentPasswordFormView, type: .password, isLogin: true)
        setUpTextFieldForm(textField: newPasswordFormView, type: .newPassword)
        setUpTextFieldForm(textField: confirmPasswordFormView, type: .confirmPassword)
    }
    
    private func setUpTextFieldForm(textField: TextFieldLoginView, type: TypeOfTextFieldForm, isEnable: Bool = true, value: String = "", isLogin: Bool = false, codePhoneNumber: String = "+84", imageName: String = "VietNam", isChangeCodeNumberPhone: Bool = false) {
        textField.viewModel = TextFieldLoginViewVM(typeForm: type, isLogin: isLogin, isEnable: isEnable, value: value, codePhoneNumber: codePhoneNumber, imageName: imageName, isChangeCodeNumberPhone: isChangeCodeNumberPhone)
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
        phoneNumberFormView.dismissKeyboard()
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

extension ProfileInfomationSettingsViewController: FormPhoneNumberTextFieldDelegate {
    func showHideListFlag(view: TextFieldLoginView) {
        listFlagTableView.isHidden = !listFlagTableView.isHidden
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

extension ProfileInfomationSettingsViewController {
    private func setUpTableView() {
        listFlagTableView.register(nibWithCellClass: FlagCodeNumberTableViewCell.self)
        listFlagTableView.isHidden = true
        listFlagTableView.delegate = self
        listFlagTableView.dataSource = self
        widthOfTableViewConstraint.constant = ScreenSize.scaleWidth(120)
    }
}

extension ProfileInfomationSettingsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ProfileInfomationSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: FlagCodeNumberTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.indexOfNationFlagsList = indexPath.row
        let flag = nameFlag[indexPath.row]
        viewModel.user?.nation = flag
        let codeNumber = codeNumber[indexPath.row]
        guard let user = viewModel.user else { return }
        setUpTextFieldForm(textField: phoneNumberFormView, type: .phoneNumber, value: user.phoneNumber, codePhoneNumber: codeNumber, imageName: flag, isChangeCodeNumberPhone: true)
        viewModel.indexOfNationFlagsList = indexPath.row
        listFlagTableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt()
    }
}

// Change Avatar
extension ProfileInfomationSettingsViewController {
    @objc func changeAvatarTapping() {
        showPopUpCameraLibrary()
    }
    
    private func showPopUpCameraLibrary() {
        // MARK: - Setup PopUp
        popUpCameraLibrary = PopupChooseImage(frame: view.frame, inView: self)
        popUpCameraLibrary?.delegate = self
        
        // MARK: - Add to view hierarchy with animation
        addPopUpCameraLibraryToViewHierarchy()
        animatePopUpCameraLibraryPresentation()
    }
    
    func addPopUpCameraLibraryToViewHierarchy() {
        guard let popUp = popUpCameraLibrary else { return }
        
        // Set initial transform
        let initialTransform = CGAffineTransform(a: Constants.initialScale, b: Constants.initialScale, c: Constants.initialScale, d: Constants.initialScale, tx: Constants.initialScale, ty: Constants.initialScale)
        popUp.transform = initialTransform
        
        // Add to view
        view.addSubview(popUp)
    }
    
    func animatePopUpCameraLibraryPresentation() {
        UIView.animate(
            withDuration: Constants.animationDuration,
            delay: 0,
            options: .curveEaseOut
        ) { [weak self] in
            self?.popUpCameraLibrary?.transform = .identity
        }
    }
}

extension ProfileInfomationSettingsViewController: PopupChooseImageViewDelegate {
    
    func didTappingOutSideHiddenPopup(view: PopupChooseImage) {
        self.popUpCameraLibrary?.removeFromSuperview()
    }
    
    func didTappingLibraryView(view: PopupChooseImage) {
        openImagePicker(sourceType: .photoLibrary)
    }
    
    func didTappingCameraView(view: PopupChooseImage) {
        openImagePicker(sourceType: .camera)
    }
}

extension ProfileInfomationSettingsViewController: UIImagePickerControllerDelegate {
    func openImagePicker(sourceType: UIImagePickerController.SourceType) {
            guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
                print("Nguồn không khả dụng!")
                return
            }
            
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            picker.allowsEditing = true // Cho phép chỉnh sửa ảnh sau khi chọn
            present(picker, animated: true)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            // Chuyển UIImage thành Data
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                print("Error converting image to data")
                return
            }
            
            // Gọi phương thức uploadImageToFirebaseStorage trong ViewModel
            viewModel.uploadImageToFirebaseStorage(imageData: imageData) { [weak self] imageURL in
                guard let self = self, let imageURL = imageURL else { return }
                self.viewModel.saveImageURLToFirestore(imageURL: imageURL)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileInfomationSettingsViewController: UINavigationControllerDelegate {
    
}
