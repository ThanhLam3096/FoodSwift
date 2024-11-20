//
//  PasswordFormProfileSettingsView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 19/11/24.
//

import Foundation
import UIKit

protocol PasswordFormProfileSettingsViewDelegate: AnyObject {
    func tappingInsideButtonChangePassword(view: PasswordFormProfileSettingsView)
}

final class PasswordFormProfileSettingsView: UIView {
    // MARK: - IBOutlet
    @IBOutlet private weak var passwordFormProfileSettingsView: UIView!
    @IBOutlet private weak var titleTextFieldLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    @IBOutlet private weak var infoTextField: UITextField!
    @IBOutlet private weak var changePasswordButton: UIButton!
    
    // MARK: - Constraint
    @IBOutlet private weak var spaceOfTitleAndTextFieldConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfLineViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfChangeButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfChangeButtonConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: PasswordFormProfileSettingsViewVM? {
        didSet {
            updateView()
        }
    }
    var delegate: PasswordFormProfileSettingsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUIView()
    }
    
    private func updateView() {
        guard let typeForm = viewModel?.typeForm else { return }
        titleTextFieldLabel.text = typeForm.title
    }
    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("PasswordFormProfileSettingsView", owner: self, options: nil)
        self.addSubview(passwordFormProfileSettingsView)
        passwordFormProfileSettingsView.frame = self.bounds
        passwordFormProfileSettingsView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setUpLabel()
        setUpTextField()
        lineView.backgroundColor = UIColor(hex: "#F6F6F6")
        topSpaceOfLineViewConstraint.constant = ScreenSize.scaleHeight(10)
        setUpChangeButton()
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
    }
    
    private func setUpChangeButton() {
        changePasswordButton.setAttributedTitle(NSAttributedString(string: "Change", attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: Color.activeColor,
        ]), for: .normal)
        widthOfChangeButtonConstraint.constant = ScreenSize.scaleWidth(65)
        leadingSpaceOfChangeButtonConstraint.constant = ScreenSize.scaleWidth(0)
    }
    
    
    @IBAction func changeButtonTouchUpInside(_ sender: Any) {
        if let delegate = delegate {
            delegate.tappingInsideButtonChangePassword(view: self)
        }
    }
    
    func dismissKeyboard() {
        self.endEditing(true)
    }
}

extension PasswordFormProfileSettingsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
}
