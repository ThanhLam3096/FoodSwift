//
//  TextFieldLoginView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 30/8/24.
//

import UIKit

class TextFieldLoginView: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var loginFormTextView: UIView!
    @IBOutlet private weak var eyeButton: UIButton!
    @IBOutlet private weak var checkMarkButtonImageView: UIImageView!
    @IBOutlet private weak var titleTextFieldLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    @IBOutlet private weak var infoTextField: UITextField!
    
    // MARK: - Constraint
    @IBOutlet private weak var spaceOfTitleAndTextFieldConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthEyeButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightEyeButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfLineViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfCheckMarkImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfCheckMarkImageConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: TextFieldLoginViewVM? {
        didSet {
            updateView()
        }
    }
    weak var delegate: FormTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUIView()
    }
    
    private func updateView() {
        guard let typeForm = viewModel?.typeForm, let isEnable = viewModel?.isEnable, let value = viewModel?.value else { return }
        titleTextFieldLabel.text = typeForm.title
        eyeButton.isHidden = !typeForm.isEyeShow
        infoTextField.isEnabled = isEnable
        infoTextField.text = value
        switch typeForm {
        case .password, .newPassword, .confirmPassword:
            infoTextField.isSecureTextEntry = true
            infoTextField.textContentType = .none
        case .phoneNumber:
            infoTextField.keyboardType = .numberPad
            addDoneButtonToKeyboard(for: infoTextField)
        default: infoTextField.isSecureTextEntry = false
        }
    }
    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("TextFieldLoginView", owner: self, options: nil)
        self.addSubview(loginFormTextView)
        loginFormTextView.frame = self.bounds
        loginFormTextView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setUpLabel()
        setUpTextField()
        
        lineView.backgroundColor = UIColor(hex: "#F6F6F6")
        topSpaceOfLineViewConstraint.constant = ScreenSize.scaleHeight(10)
        
    }
    
    private func setUpLabel() {
        setLabelFontAndTextColor(label: titleTextFieldLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.bodyTextColor)
        spaceOfTitleAndTextFieldConstraint.constant = ScreenSize.scaleHeight(8)
    }
    
    private func setLabelFontAndTextColor(label: UILabel, labelFont: UIFont, labelTextColor: UIColor) {
        label.font = labelFont
        label.textColor = labelTextColor
    }
    
    private func setUpTextField() {
        infoTextField.font = UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16))
        infoTextField.textColor = Color.mainColor
        infoTextField.borderStyle = .none
        infoTextField.tintColor = Color.accentColor
        infoTextField.delegate = self
        NSLayoutConstraint.activate([
            infoTextField.heightAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(24)),
        ])
        widthOfCheckMarkImageConstraint.constant = ScreenSize.scaleHeight(17)
        heightOfCheckMarkImageConstraint.constant = ScreenSize.scaleHeight(17)
        checkMarkButtonImageView.isHidden = true
        eyeButton.tintColor = Color.tabBarColor
        widthEyeButtonConstraint.constant = ScreenSize.scaleWidth(14)
        heightEyeButtonConstraint.constant = ScreenSize.scaleHeight(12)
    }
    
    @IBAction func eyeShowPasswordTouchUpInside(_ sender: Any) {
        infoTextField.isSecureTextEntry = !infoTextField.isSecureTextEntry
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func addDoneButtonToKeyboard(for textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        let attributesNormal: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.bodyTextColor,
            .font: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(20)) as Any
        ]
        let attributesHighlight: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.activeColor,
            .font: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(20)) as Any
        ]
        doneButton.setTitleTextAttributes(attributesNormal, for: .normal)
        doneButton.setTitleTextAttributes(attributesHighlight, for: .highlighted)
        let flexSpaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let flexSpaceRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.items = [flexSpaceLeft, doneButton, flexSpaceRight]
        textField.inputAccessoryView = toolbar
    }
}

extension TextFieldLoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let type = viewModel?.typeForm, let isLogin = viewModel?.isLogin ,let value = textField.text, let delegate = delegate else {return}
        checkMarkButtonImageView.isHidden = isLogin
        switch type {
        case .fullName:
            if isValidNameUser(value) {
                checkMarkButtonImageView.image = UIImage(named: "check")
            } else {
                checkMarkButtonImageView.image = UIImage(systemName: "xmark")
            }
            delegate.getValueTextField(value: value, type: type, isValid: isValidNameUser(value), view: self)
        case .emailAddress:
            if isValidEmail(value) {
                checkMarkButtonImageView.image = UIImage(named: "check")
            } else {
                checkMarkButtonImageView.image = UIImage(systemName: "xmark")
            }
            delegate.getValueTextField(value: value, type: type, isValid: isValidEmail(value), view: self)
        case .phoneNumber:
            checkMarkButtonImageView.isHidden = true
            delegate.getValueTextField(value: value, type: type, isValid: true, view: self)
        case .password, .newPassword, .confirmPassword:
            if isValidUserPassword(value) {
                checkMarkButtonImageView.image = UIImage(named: "check")
            } else {
                checkMarkButtonImageView.image = UIImage(systemName: "xmark")
            }
            delegate.getValueTextField(value: value, type: type, isValid: isValidUserPassword(value), view: self)
        }
        
    }
}

protocol FormTextFieldDelegate: AnyObject {
    func getValueTextField(value: String, type: TypeOfTextFieldForm, isValid: Bool, view: TextFieldLoginView)
}
