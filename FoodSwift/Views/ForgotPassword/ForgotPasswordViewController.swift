//
//  ForgotPasswordViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/9/24.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    // MARK: -IBOutlet
    @IBOutlet private weak var forgotPassTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var emailFormView: TextFieldLoginView!
    @IBOutlet private weak var resetPasswordButtonView: OrangeButtonView!
    
    @IBOutlet private weak var resetEmailView: UIView!
    @IBOutlet private weak var resendEmailTitleLabel: UILabel!
    @IBOutlet private weak var descriptionResendEmailLabel: UILabel!
    @IBOutlet private weak var sendAgainButtonView: OrangeButtonView!
    
    // MARK: Constraint
    @IBOutlet private weak var topSpaceTitleConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceTitleConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceTitleConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceTitleConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceEmailResetFormConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceEmailResetFormConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfEmailResetFormConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfResetPasswordButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfImageConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setUpUI() {
        setUpNavigation()
        setUpLabel()
        setUpUIWelcomeButtonView()
        setUpImage()
        actionOfTappingOutSideHideOfKeyBoard()
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: forgotPassTitleLabel, text: "Forgot Password", labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(34)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(34)), labelTextColor: Color.mainColor)
        forgotPassTitleLabel.textAlignment = NSTextAlignment.left
        forgotPassTitleLabel.numberOfLines = 0
        topSpaceTitleConstraint.constant = ScreenSize.scaleHeight(20)
        botSpaceTitleConstraint.constant = ScreenSize.scaleHeight(20)
        leadingSpaceTitleConstraint.constant = ScreenSize.scaleHeight(20)
        trailingSpaceTitleConstraint.constant = ScreenSize.scaleHeight(20)
        
        setUpTextTitleFontTextColorOfLabel(label: descriptionLabel, text: "Enter your email address and we will\nsend you a reset instructions.", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(16)), labelTextColor: Color.bodyTextColor)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = NSTextAlignment.left
        
        setUpTextTitleFontTextColorOfLabel(label: resendEmailTitleLabel, text: "Reset email sent", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(34)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(34)), labelTextColor: Color.mainColor)
        resendEmailTitleLabel.textAlignment = NSTextAlignment.left
        resendEmailTitleLabel.numberOfLines = 0
        
        descriptionResendEmailLabel.numberOfLines = 0
        let textTitle = "We have sent a instructions email\nto sajin tamang@figma.com.  Having problem?"
        descriptionResendEmailLabel.isUserInteractionEnabled = true
        let attributedStringTextTitle = NSMutableAttributedString(string: textTitle)
        attributedStringTextTitle.addAttribute(.font, value: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) as Any, range: NSRange(location: 0, length: attributedStringTextTitle.length))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: Color.bodyTextColor as Any, range: NSRange(location: 0, length: 60))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: Color.activeColor as Any, range: NSRange(location: 62, length: 15))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel))
        descriptionResendEmailLabel.addGestureRecognizer(tapGesture)
        descriptionResendEmailLabel.attributedText = attributedStringTextTitle
        descriptionResendEmailLabel.sizeToFit()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Forgot Password"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16))
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpTextField() {
        emailFormView.viewModel = TextFieldLoginViewVM(typeForm: .emailAddress)
        topSpaceEmailResetFormConstraint.constant = ScreenSize.scaleHeight(34)
        botSpaceEmailResetFormConstraint.constant = ScreenSize.scaleHeight(24)
        heightOfEmailResetFormConstraint.constant = ScreenSize.scaleHeight(65)
    }
    
    private func setUpUIWelcomeButtonView() {
        resetPasswordButtonView.delegate = self
        sendAgainButtonView.delegate = self
        resetPasswordButtonView.viewModel = OrangeButtonViewModel(title: "RESET PASSWORD")
        sendAgainButtonView.viewModel = OrangeButtonViewModel(title: "SEND AGAIN")
        heightOfResetPasswordButtonConstraint.constant = ScreenSize.scaleHeight(48)
    }
    
    private func setUpImage() {
        widthOfImageConstraint.constant = ScreenSize.scaleWidth(307)
        heightOfImageConstraint.constant = ScreenSize.scaleHeight(237.03)
        topSpaceOfImageConstraint.constant = ScreenSize.scaleHeight(150)
    }
    
    override func setUpData() {
        setUpTextField()
    }
    
    @objc func handleTapOnLabel(gesture: UITapGestureRecognizer) {
        // Get the position of the tap in the label
        let tapLocation = gesture.location(in: descriptionResendEmailLabel)
        
        // Calculate the bounding box for the clickable range
        guard let attributedText = descriptionResendEmailLabel.attributedText else { return }
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: descriptionResendEmailLabel.bounds.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = descriptionResendEmailLabel.numberOfLines
        textContainer.lineBreakMode = descriptionResendEmailLabel.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        let glyphIndex = layoutManager.glyphIndex(for: tapLocation, in: textContainer)
        
        // Check if the tap is within the clickable range
        let clickableRange = (attributedText.string as NSString).range(of: "Having problem?")
//        if NSLocationInRange(glyphIndex, clickableRange) {
        if NSLocationInRange(62, clickableRange) {
            // Perform navigation
            navigateToAnotherScreen()
        }
    }
    
    private func actionOfTappingOutSideHideOfKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func navigateToAnotherScreen() {
        // Code to navigate to another screen
        print("Open Some Screen Web link")
        // You can use navigationController?.pushViewController or present() method here
    }
    
    @objc func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ForgotPasswordViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        if resetEmailView.isHidden {
            resetEmailView.isHidden = false
        } else {
            print("Email Already to seen reset your password")
        }
    }

}
