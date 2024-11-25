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
        guard let typeForm = viewModel?.typeForm else { return }
        titleTextFieldLabel.text = typeForm.title
        eyeButton.isHidden = !typeForm.isEyeShow
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
            checkMarkButtonImageView.heightAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(24)),
            checkMarkButtonImageView.widthAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(24))
        ])
        
        eyeButton.tintColor = Color.tabBarColor
        widthEyeButtonConstraint.constant = ScreenSize.scaleWidth(14)
        heightEyeButtonConstraint.constant = ScreenSize.scaleHeight(12)
    }
    
    @IBAction func eyeShowPasswordTouchUpInside(_ sender: Any) {
        print("ádasdasd")
    }
    
    func dismissKeyboard() {
        self.endEditing(true)
    }
}

extension TextFieldLoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let delegate = delegate, let value = textField.text, let type = viewModel?.typeForm {
            delegate.getValueTextField(value: value, type: type, view: self)
        }
    }
}

protocol FormTextFieldDelegate: AnyObject {
    func getValueTextField(value: String, type: TypeOfTextFieldForm, view: TextFieldLoginView)
}
