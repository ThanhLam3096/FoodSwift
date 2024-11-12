//
//  VerifylePhoneNumberVC.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 16/9/24.
//

import UIKit

final class VerifylePhoneNumberVC: BaseViewController {
    
    // MARK: IBOutlet
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    @IBOutlet private weak var descriptionTextLabel: UILabel!
    @IBOutlet private weak var otpTextField1: UITextField!
    @IBOutlet private weak var otpTextField2: UITextField!
    @IBOutlet private weak var otpTextField3: UITextField!
    @IBOutlet private weak var otpTextField4: UITextField!
    @IBOutlet private weak var continueButtonView: OrangeButtonView!
    @IBOutlet private weak var didntRecevieCodeLabel: UILabel!
    @IBOutlet private weak var sendAgainButton: UIButton!
    @IBOutlet private weak var policyLabel: UILabel!

    // MARK: Constraint
    @IBOutlet private weak var topSpaceTitleVerifyPhoneNumberConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceTitleVerifyPhoneNumberConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfCodeStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfCodeStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfCodeStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfCodeStackViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfContinueButtonViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfContinueButtonViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfContinueButtonViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfResendCodeStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfResendCodeStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfResendCodeStackViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpUI() {
        view.backgroundColor = Color.inputColor
        setUpNavigation()
        setUpLabel()
        setUpTextField()
        setUpOrangeButtonView()
        actionOfTappingOutSideHideOfKeyBoard()
        setUpStackView()
        setUpResendButton()
        actionWhenShowKeyboard()
        actionWhenHideKeyboard()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Login To Foodly"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: descriptionTitleLabel, text: "Verify phone number", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(24)) ?? UIFont.systemFont(ofSize: 24), labelTextColor: Color.mainColor)
        topSpaceTitleVerifyPhoneNumberConstraint.constant = ScreenSize.scaleHeight(24)
        botSpaceTitleVerifyPhoneNumberConstraint.constant = ScreenSize.scaleHeight(20)
        
//        Enter the 4-Digit code sent to you at +610489632578
        setUpTextTitleFontTextColorOfLabel(label: descriptionTextLabel, text: "Enter the 4-Digit code sent to you at \n+610489632578", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        descriptionTextLabel.textAlignment = .center
        descriptionTextLabel.numberOfLines = 0
        
        setUpTextTitleFontTextColorOfLabel(label: didntRecevieCodeLabel, text: "Didn’t receive code?", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.bodyTextColor)
        
        setUpTextTitleFontTextColorOfLabel(label: policyLabel, text: "By Signing up you agree to our Terms\nConditions & Privacy Policy.", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        policyLabel.numberOfLines = 0
        policyLabel.textAlignment = .center
    }
    
    @objc func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpOrangeButtonView() {
        continueButtonView.delegate = self
        continueButtonView.viewModel = OrangeButtonViewModel(title: "CONTINUE")
        
        widthOfContinueButtonViewConstraint.constant = ScreenSize.scaleWidth(335)
        heightOfContinueButtonViewConstraint.constant = ScreenSize.scaleHeight(48)
        botSpaceOfContinueButtonViewConstraint.constant = ScreenSize.scaleHeight(24)
    }
    
    private func setUpStackView() {
        widthOfResendCodeStackViewConstraint.constant = ScreenSize.scaleWidth(220)
        heightOfResendCodeStackViewConstraint.constant = ScreenSize.scaleHeight(22)
        botSpaceOfResendCodeStackViewConstraint.constant = ScreenSize.scaleHeight(34)
    }
    
    private func setUpResendButton() {
        //        sendAgainButton.setTitle("Resend Again", for: .normal)
        //        sendAgainButton.setTitleColor(Color.activeColor, for: .normal)
        //        sendAgainButton.titleLabel?.textColor = Color.activeColor
        //        sendAgainButton.titleLabel?.font = UIFont.fontYugothicLight(ofSize: 12)
        let attributedSendAgainButton = NSAttributedString(string: "Resend Again", attributes: [
            .font: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: Color.activeColor
        ])
        sendAgainButton.titleLabel?.numberOfLines = 1
        sendAgainButton.titleLabel?.lineBreakMode = .byTruncatingTail
        sendAgainButton.setAttributedTitle(attributedSendAgainButton, for: .normal)
    }
    
    private func setUpTextField() {
        widthOfCodeStackViewConstraint.constant = ScreenSize.scaleWidth(260)
        heightOfCodeStackViewConstraint.constant = ScreenSize.scaleHeight(50)
        topSpaceOfCodeStackViewConstraint.constant = ScreenSize.scaleHeight(41)
        botSpaceOfCodeStackViewConstraint.constant = ScreenSize.scaleHeight(304)
        
        let listCodeOTP = [otpTextField1, otpTextField2, otpTextField3, otpTextField4]
        for textField in listCodeOTP {
            guard let textField = textField else {
                return
            }
            textField.keyboardType = .numberPad
            textField.font = UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(16))
            textField.textColor = Color.mainColor
            textField.tintColor = Color.greenColor
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let listCodeOTP = [otpTextField1, otpTextField2, otpTextField3, otpTextField4]
        guard let text = textField.text, !text.isEmpty else { return }
        
        // Tìm vị trí của textField hiện tại
        if let index = listCodeOTP.firstIndex(of: textField) {
            // Chuyển focus sang textField tiếp theo, nếu có
            if index < listCodeOTP.count - 1 {
                listCodeOTP[index + 1]?.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()  // Khi đến ô cuối cùng
            }
        }
    }

}

extension VerifylePhoneNumberVC: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        print("OTP")
    }
}

extension VerifylePhoneNumberVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let listCodeOTP = [otpTextField1, otpTextField2, otpTextField3, otpTextField4]
//        guard let text = textField.text else { return false }
//        
//        if string.isEmpty {  // Khi người dùng xóa ký tự
//            if let index = listCodeOTP.firstIndex(of: textField), index > 0 {
//                listCodeOTP[index]?.text = ""
//                listCodeOTP[index]?.becomeFirstResponder()  // Quay về ô trước
//            }
//        } else {
//            // Chỉ cho phép nhập 1 ký tự duy nhất
//            return text.count < 1
//        }
//        return true
        
        textField.text = ""
        if textField.text == "" {
            print("Backspace has been pressed")
        }
        if string == ""
        {
            switch textField {
            case otpTextField2:
                otpTextField1.becomeFirstResponder()
            case otpTextField3:
                otpTextField2.becomeFirstResponder()
            case otpTextField4:
                otpTextField3.becomeFirstResponder()
            default:
                otpTextField1.resignFirstResponder()
            }
            textField.text = ""
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // lỗi khi đặt con trỏ ở cuối chuỗi fix sau
        if let endPosition = textField.position(from: textField.endOfDocument, offset: 0) {
            textField.selectedTextRange = textField.textRange(from: endPosition, to: endPosition)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("abcd")
    }
}

extension VerifylePhoneNumberVC {
    private func actionOfTappingOutSideHideOfKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension VerifylePhoneNumberVC {
    private func actionWhenShowKeyboard() {
        keyboardObserver = KeyboardObserver()
        keyboardObserver?.onKeyboardWillShow = { [weak self] heightOfKeyBoard in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.3) {
                self.botSpaceOfCodeStackViewConstraint.constant = ScreenSize.scaleHeight(34)
            }
        }
    }
    
    private func actionWhenHideKeyboard() {
        keyboardObserver?.onKeyboardWillHide = { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.3) {
                self.botSpaceOfCodeStackViewConstraint.constant = ScreenSize.scaleHeight(304)
            }
        }
    }
}
