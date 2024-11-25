//
//  SignInViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 21/8/24.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

final class SignInViewController: BaseViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleIntroLabel: UILabel!
    @IBOutlet private weak var title2IntroLabel: UILabel!
    @IBOutlet private weak var emailFormView: TextFieldLoginView!
    @IBOutlet private weak var passwordFormView: TextFieldLoginView!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var signInButtonView: OrangeButtonView!
    @IBOutlet private weak var dontHaveAccountLabel: UILabel!
    @IBOutlet private weak var createNewAccountButton: UIButton!
    @IBOutlet private weak var orLabel: UILabel!
    @IBOutlet private weak var googleLoginButton: SocialButtonView!
    @IBOutlet private weak var facebookLoginButton: SocialButtonView!

    // MARK: Constraint
    @IBOutlet private weak var heightOfContentView: NSLayoutConstraint!
    
    @IBOutlet private weak var leadingOfTitleSuperViewConstrain: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfBetweenTitleConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfFormSignInConstraint: NSLayoutConstraint!
    @IBOutlet private weak var traillingSpaceOfEmailFormConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfEmailFormConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfEmailPasswordFormConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceForgotPasswordButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceForgotPasswordButtonConstraint: NSLayoutConstraint!
    
    
    @IBOutlet private weak var heightOfSignInButtonViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceSignInButtonViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceOrLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bottomSpaceOrLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var betweenSpaceOfSocialButtonViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfSocialButtonViewConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    var viewModel: SigninViewControllerVM = SigninViewControllerVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionWhenShowKeyboard()
        actionWhenHideKeyboard()
        
    }
    
    override func setUpUI() {
        setUpLabel()
        setUpNavigation()
        setUpTextFieldSignIn()
        setUpForgetPasswordButton()
        setUpSignInOrangeButtonView()
        setUpCreateAccountButton()
        setUpSocialLoginButton()
        addActionHideKeyBoard()
        heightOfContentView.constant = ScreenSize.screenHeight
        scrollView.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "Sign In"
        titleLabel.font = UIFont.boldSystemFont(ofSize: ScreenSize.scaleHeight(16))
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: titleIntroLabel, text: "Welcome to Tamang\nFood Services", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(33)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(33)), labelTextColor: Color.mainColor)
        leadingOfTitleSuperViewConstrain.constant = ScreenSize.scaleHeight(20)
        spaceOfBetweenTitleConstraint.constant = ScreenSize.scaleHeight(20)
        
        setUpTextTitleFontTextColorOfLabel(label: title2IntroLabel, text: "Enter your Phone number or Email\naddress for sign in. Enjoy your food :)", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(16)), labelTextColor: Color.bodyTextColor)
        
        setUpTextTitleFontTextColorOfLabel(label: dontHaveAccountLabel, text: "Don't have account?", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.mainColor)
        
        setUpTextTitleFontTextColorOfLabel(label: orLabel, text: "Or", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.mainColor)
        topSpaceOrLabelConstraint.constant = ScreenSize.scaleHeight(20)
        bottomSpaceOrLabelConstraint.constant = ScreenSize.scaleHeight(20)
    }
        
    private func setUpTextFieldSignIn() {
        setUpTextFieldForm(textField: emailFormView, type: .emailAddress)
        traillingSpaceOfEmailFormConstraint.constant = ScreenSize.scaleWidth(20)
        topSpaceOfEmailFormConstraint.constant = ScreenSize.scaleWidth(24)
        heightOfFormSignInConstraint.constant = ScreenSize.scaleHeight(65)
        spaceOfEmailPasswordFormConstraint.constant = ScreenSize.scaleHeight(18)

        setUpTextFieldForm(textField: passwordFormView, type: .password)
    }
    
    private func setUpTextFieldForm(textField: TextFieldLoginView, type: TypeOfTextFieldForm) {
        textField.viewModel = TextFieldLoginViewVM(typeForm: type)
        textField.delegate = self
    }
    
    private func setUpForgetPasswordButton() {
        forgotPasswordButton.setAttributedTitle(NSAttributedString(string: "Forget Password?", attributes: [
            .font: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) as Any
        ]), for: .normal)
        forgotPasswordButton.titleLabel?.tintColor = Color.bodyTextColor
        topSpaceForgotPasswordButtonConstraint.constant = ScreenSize.scaleHeight(20)
        botSpaceForgotPasswordButtonConstraint.constant = ScreenSize.scaleHeight(24)
    }
    
    private func setUpSignInOrangeButtonView() {
        signInButtonView.viewModel = OrangeButtonViewModel(title: "SIGN IN")
        heightOfSignInButtonViewConstraint.constant = ScreenSize.scaleHeight(48)
        botSpaceSignInButtonViewConstraint.constant = ScreenSize.scaleHeight(20)
        signInButtonView.delegate = self
    }
    
    private func setUpCreateAccountButton() {
        createNewAccountButton.setAttributedTitle(NSAttributedString(string: "Create new account", attributes: [
            .font: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) as Any
        ]), for: .normal)
        createNewAccountButton.titleLabel?.tintColor = Color.activeColor
    }
    
    private func setUpSocialLoginButton() {
        setUpSocialLoginButtonView(typeLoginView: facebookLoginButton, type: .facebook)
        setUpSocialLoginButtonView(typeLoginView: googleLoginButton, type: .google)
        
        heightOfSocialButtonViewConstraint.constant = ScreenSize.scaleHeight(44)
        betweenSpaceOfSocialButtonViewConstraint.constant = ScreenSize.scaleHeight(15)
    }
    
    private func setUpSocialLoginButtonView(typeLoginView: SocialButtonView, type: SocialAccountType) {
        typeLoginView.viewModel = SocialButtonViewVM(socialType: type)
        typeLoginView.delegate = self
    }
    
    @IBAction func createAccountTouchUpInside(_ sender: Any) {
        self.navigationController?.pushViewController(ScreenName.createAccount, animated: true)
    }
    
    @IBAction func forgotPasswordButtonTouchUpInside(_ sender: Any) {
        self.navigationController?.pushViewController(ScreenName.forgotPassword, animated: true)
    }
    
    private func addActionHideKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func leftAction() {
//        self.navigationController?.popViewController(animated: true)
        print("abcd1234")
    }
}

extension SignInViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
//        firebaseAUTH.auth().signIn(withEmail: viewModel.valueEmail, password: viewModel.valuePassword, completion: { [weak self] result, error in
//            guard let this = self else { return }
//            guard error == nil else {
//                this.showAlert(message: "You Need To Account?")
//                return
//            }
//            
//        })
        self.navigationController?.pushViewController(ScreenName.baseTabbar, animated: true)
    }
}

extension SignInViewController {
    private func actionWhenShowKeyboard() {
        keyboardObserver = KeyboardObserver()
        keyboardObserver?.onKeyboardWillShow = { [weak self] heightOfKeyBoard in
            guard let self = self else { return }
            self.heightOfContentView.constant = heightOfContentView.constant + heightOfKeyBoard
            let scrollOffsetY = ScreenSize.scaleHeight(180)
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
            self.heightOfContentView.constant = ScreenSize.screenHeight
            let scrollOffsetY = 0
            scrollView.isScrollEnabled = false
            UIView.animate(withDuration: 0.3) {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffsetY), animated: true)
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension SignInViewController: FormTextFieldDelegate {
    func getValueTextField(value: String, type: TypeOfTextFieldForm, isValid: Bool, view: TextFieldLoginView) {
        switch type {
        case .emailAddress:
            viewModel.valueEmail = value
        case .password:
            viewModel.valuePassword = value
        default: print("abcd")
        }
    }
}

extension SignInViewController: SocialButtonViewDelegate {
    func connectSoccialAccountButtonTapping(view: SocialButtonView, type: SocialAccountType) {
        switch type {
        case .facebook:
            print("Connect Facebook Account")
        case .google:
            connectToGoogleAccount()
        }
    }
}

// Connect Social Account
extension SignInViewController {
    private func connectToGoogleAccount() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                // ...
                showAlert(message: "Error Can't Connect Your Google Account")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                showAlert(message: "Can't Find Your Account Form Google")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Lỗi Firebase: \(error.localizedDescription)")
                    return
                }
                
                // Đăng nhập thành công
                print("Login Success")
                if let user = result?.user {
                    print("Tên: \(user.displayName ?? "Không có tên")")
                    print("Email: \(user.email ?? "Không có email")")
                }
            }
        }
    }
}
