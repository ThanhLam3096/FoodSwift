//
//  CreateAccountViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 2/9/24.
//

import UIKit

final class CreateAccountViewController: BaseViewController {
    
    // MARK: IBOutlet
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var title2CreateAccountLabel: TopAlignedLabel!
    @IBOutlet private weak var emailFormView: TextFieldLoginView!
    @IBOutlet private weak var passwordFormView: TextFieldLoginView!
    @IBOutlet private weak var fullNameFormView: TextFieldLoginView!
    @IBOutlet private weak var signUpButtonView: OrangeButtonView!
    @IBOutlet private weak var privacyLabel: UILabel!
    @IBOutlet private weak var orLabel: UILabel!
    @IBOutlet private weak var googleLoginButton: SocialButtonView!
    @IBOutlet private weak var facebookLoginButton: SocialButtonView!
    
    // MARK: Constraint
    @IBOutlet private weak var heightOfContentViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var leadingSpaceOfTitle: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfTitle: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfFormTextFieldConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceFullNameTextFieldConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceEmailFormConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceEmailFormConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfSignUpConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfSignUpButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceOrLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOrLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var betweenSpaceOfSocialButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfSocialButtonConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    var viewModel: CreateAccountViewControllerVM = CreateAccountViewControllerVM()
    var popUp: PopUpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setUpUI() {
        setUpNavigation()
        setUpLabel()
        setUpTextField()
        setUpSignUPButton()
        setUpSocialLoginButton()
        heightOfContentViewConstraint.constant = ScreenSize.screenHeight
        actionOfTappingOutSideHideOfKeyBoard()
        actionWhenShowKeyboard()
        actionWhenHideKeyboard()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Create Account"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16))
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpLabel() {
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.numberOfLines = 0
        setUpTextTitleFontTextColorOfLabel(label: titleLabel, text: "Create Account", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(34)) ?? UIFont.systemFont(ofSize: 34), labelTextColor: Color.mainColor)
        leadingSpaceOfTitle.constant = ScreenSize.scaleWidth(20)
        trailingSpaceOfTitle.constant = ScreenSize.scaleWidth(20)
        
        title2CreateAccountLabel.numberOfLines = 0
        let textTitle = "Enter your Name, Email and Password\nfor sign up.  Already have account?"
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = ScreenSize.scaleHeight(5)
//        paragraphStyle.alignment = .left
        title2CreateAccountLabel.isUserInteractionEnabled = true
        let attributedStringTextTitle = NSMutableAttributedString(string: textTitle)
        attributedStringTextTitle.addAttribute(.font, value: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) as Any, range: NSRange(location: 0, length: attributedStringTextTitle.length))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: Color.bodyTextColor as Any, range: NSRange(location: 0, length: 48))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: Color.activeColor as Any, range: NSRange(location: 50, length: 21))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel))
//        attributedStringTextTitle.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedStringTextTitle.length))
        title2CreateAccountLabel.addGestureRecognizer(tapGesture)
        title2CreateAccountLabel.attributedText = attributedStringTextTitle
        title2CreateAccountLabel.sizeToFit()

        privacyLabel.textAlignment = .center
        privacyLabel.numberOfLines = 0
        setUpTextTitleFontTextColorOfLabel(label: privacyLabel, text: "By Signing up you agree to our Terms\nConditions & Privacy Policy.", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(16)), labelTextColor: Color.bodyTextColor)
        
        topSpaceOrLabelConstraint.constant = ScreenSize.scaleHeight(20)
        botSpaceOrLabelConstraint.constant = ScreenSize.scaleHeight(20)
        setUpTextTitleFontTextColorOfLabel(label: orLabel, text: "Or", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(16)), labelTextColor: Color.mainColor)
    }
    
    private func setUpSignUPButton() {
        let isEnable = (viewModel.isValidEmail && viewModel.isValidFullName && viewModel.isValidPassword)
        signUpButtonView.viewModel = OrangeButtonViewModel(title: "SIGN UP", isEnableButton: isEnable)
        topSpaceOfSignUpButtonConstraint.constant = ScreenSize.scaleHeight(24)
        heightOfSignUpConstraint.constant = ScreenSize.scaleHeight(48)
        signUpButtonView.delegate = self
    }
    
    private func setUpTextField() {
        setUpTextFieldForm(textField: fullNameFormView, type: .fullName)
        topSpaceFullNameTextFieldConstraint.constant = ScreenSize.scaleHeight(20)
        heightOfFormTextFieldConstraint.constant = ScreenSize.scaleHeight(65)

        setUpTextFieldForm(textField: emailFormView, type: .emailAddress)
        topSpaceEmailFormConstraint.constant = ScreenSize.scaleHeight(18)
        botSpaceEmailFormConstraint.constant = ScreenSize.scaleHeight(18)

        setUpTextFieldForm(textField: passwordFormView, type: .password)
    }
    
    private func setUpTextFieldForm(textField: TextFieldLoginView, type: TypeOfTextFieldForm) {
        textField.viewModel = TextFieldLoginViewVM(typeForm: type)
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpSocialLoginButton() {
        setUpSocialLoginButtonView(typeLoginView: facebookLoginButton, type: .facebook)
        setUpSocialLoginButtonView(typeLoginView: googleLoginButton, type: .google)
        
        heightOfSocialButtonConstraint.constant = ScreenSize.scaleHeight(44)
        betweenSpaceOfSocialButtonConstraint.constant = ScreenSize.scaleHeight(20)
    }
    
    private func setUpSocialLoginButtonView(typeLoginView: SocialButtonView, type: SocialAccountType) {
        typeLoginView.viewModel = SocialButtonViewVM(socialType: type)
        typeLoginView.delegate = self
    }

    @objc func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTapOnLabel(gesture: UITapGestureRecognizer) {
        // Get the position of the tap in the label
        let tapLocation = gesture.location(in: title2CreateAccountLabel)
        
        // Calculate the bounding box for the clickable range
        guard let attributedText = title2CreateAccountLabel.attributedText else { return }
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: title2CreateAccountLabel.bounds.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = title2CreateAccountLabel.numberOfLines
        textContainer.lineBreakMode = title2CreateAccountLabel.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        let glyphIndex = layoutManager.glyphIndex(for: tapLocation, in: textContainer)
        
        // Check if the tap is within the clickable range
        let clickableRange = (attributedText.string as NSString).range(of: "Already have account?")
        if NSLocationInRange(glyphIndex, clickableRange) {
            // Perform navigation
            navigateToAnotherScreen()
        }
    }
    
    func navigateToAnotherScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateAccountViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        createAccount(fullName: viewModel.valueFullName, email: viewModel.valueEmail, password: viewModel.valuePassword)
//        self.navigationController?.pushViewController(ScreenName.definePhoneNumber, animated: true)
    }
}

extension CreateAccountViewController: FormTextFieldDelegate {
    func getValueTextField(value: String, type: TypeOfTextFieldForm, isValid: Bool, view: TextFieldLoginView) {
        switch type {
        case .fullName:
            viewModel.valueFullName = value
            viewModel.isValidFullName = isValid
        case .emailAddress:
            viewModel.valueEmail = value
            viewModel.isValidEmail = isValid
        case .password:
            viewModel.valuePassword = value
            viewModel.isValidPassword = isValid
        default: break
        }
        let isEnable = (viewModel.isValidEmail && viewModel.isValidFullName && viewModel.isValidPassword)
        signUpButtonView.viewModel = OrangeButtonViewModel(title: "SIGN UP", isEnableButton: isEnable)
    }
}

extension CreateAccountViewController {
    private func actionOfTappingOutSideHideOfKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension CreateAccountViewController {
    private func actionWhenShowKeyboard() {
        keyboardObserver = KeyboardObserver()
        keyboardObserver?.onKeyboardWillShow = { [weak self] heightOfKeyBoard in
            guard let self = self else { return }
            self.heightOfContentViewConstraint.constant = heightOfContentViewConstraint.constant + heightOfKeyBoard
            let scrollOffsetY = ScreenSize.scaleHeight(100)
            scrollView.isScrollEnabled = true
            UIView.animate(withDuration: 0.3) {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffsetY), animated: false)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func actionWhenHideKeyboard() {
        keyboardObserver?.onKeyboardWillHide = { [weak self] in
            guard let self = self else { return }
            self.heightOfContentViewConstraint.constant = ScreenSize.screenHeight
            let scrollOffsetY = 0
            scrollView.isScrollEnabled = false
            UIView.animate(withDuration: 0.3) {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffsetY), animated: true)
                self.view.layoutIfNeeded()
            }
        }
    }
}

// Create Account
extension CreateAccountViewController {
    private func createAccount(fullName: String, email: String, password: String) {
        HUD.show()
        viewModel.createAccount(fullName: fullName, email: email, password: password) { [weak self] (success, message) in
            guard let strongSelf = self else { return }
            strongSelf.showPopUp(title: message, isSuccess: success)
            HUD.dismiss()
        }
    }
    
    private func createAccountWithGoogleAccount() {
        viewModel.connectToGoogleAccount(presentViewController: self) { [weak self] (success, message) in
            guard let strongSelf = self else { return }
            strongSelf.showPopUp(title: message, isSuccess: success)
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

extension CreateAccountViewController: SocialButtonViewDelegate {
    func connectSoccialAccountButtonTapping(view: SocialButtonView, type: SocialAccountType) {
        switch type {
        case .facebook:
            print("Connect Facebook Account")
        case .google:
            createAccountWithGoogleAccount()
        }
    }
}

extension CreateAccountViewController: PopUpViewDelegate {
    func didTappingButton(view: PopUpView, isSuccess: Bool) {
        self.popUp?.removeFromSuperview()
        if isSuccess {
            self.navigationController?.pushViewController(ScreenName.definePhoneNumber, animated: true)
        } else {
            return
        }
    }
}
