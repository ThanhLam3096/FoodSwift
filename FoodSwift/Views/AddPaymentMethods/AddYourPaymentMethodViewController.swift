//
//  AddYourPaymentMethodViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 6/11/24.
//

import UIKit

class AddYourPaymentMethodViewController: BaseViewController {
    
    // MARK: IBOutlet
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var idCardView: UIView!
    @IBOutlet private weak var iconCardImageView: UIImageView!
    
    @IBOutlet private weak var idCardTextField: UITextField!
    @IBOutlet private weak var expiryCardTextField: UITextField!
    @IBOutlet private weak var cvcCardTextField: UITextField!
    
    @IBOutlet private weak var addCardButtonView: OrangeButtonView!
    @IBOutlet private weak var scanCardButton: UIButton!
    @IBOutlet private weak var scanCardView: UIView!
    @IBOutlet private weak var scanCardLabel: UILabel!
    @IBOutlet private weak var iconCameraImageView: UIImageView!
    
    // MARK: Constraint
    @IBOutlet private weak var heightOfContentView: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfTopIdCardViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfIdCardView: NSLayoutConstraint!
    @IBOutlet private weak var spaceBottomOfIdCardViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfTopAddCardButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfCameraImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingScanCardViewOfCameraConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfAddCardViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var widthOfExpiryCardTextFieldConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthOfCVCCardTextFieldConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    var keyboardObserver: KeyboardObserver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionWhenShowKeyboard()
        actionWhenHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func setUpUI() {
        setUpLabel()
        setUpButton()
        setUpFrame()
        setUpTextField()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setUpLabel() {
        setLabelFontAndTextColor(label: titleLabel, labelFont: UIFont.fontYugothicUISemiBold(ofSize: 24) ?? UIFont.systemFont(ofSize: 24), labelTextColor: Color.mainColor)
        setLabelFontAndTextColor(label: subjectLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        subjectLabel.text = App.String.subjectMethodsPayment
        
        setLabelFontAndTextColor(label: scanCardLabel, labelFont: UIFont.fontYugothicUISemiBold(ofSize: 14) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
        scanCardLabel.text = "SCAN CARD"
    }
    
    private func setLabelFontAndTextColor(label: UILabel, labelFont: UIFont, labelTextColor: UIColor) {
        label.font = labelFont
        label.textColor = labelTextColor
    }

    private func setUpButton() {
        NSLayoutConstraint.activate([
            addCardButtonView.heightAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(48)),
        ])
        scanCardView.layer.borderWidth = 1
        scanCardView.layer.cornerRadius = 8
        scanCardView.layer.borderColor = Color.bodyTextColor.withAlphaComponent(0.3).cgColor
        
        iconCameraImageView.image = UIImage(named: "camera")
        addCardButtonView.delegate = self
        addCardButtonView.viewModel = OrangeButtonViewModel(title: "ADD CARD")
    }
    
    private func setUpTextField() {
        heightOfIdCardView.constant = ScreenSize.scaleHeight(54)
        idCardView.backgroundColor = Color.bodyTextColor.withAlphaComponent(0.132)
        idCardView.layer.cornerRadius = 8
        idCardView.layer.borderWidth = 1
        idCardView.layer.borderColor = Color.bodyTextColor.withAlphaComponent(0.3).cgColor
        setTextFieldFontAndTextColor(textField: idCardTextField, labelFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor, backgroupColor: .clear, borderWidth: 0)
        idCardTextField.borderStyle = .none
        widthOfExpiryCardTextFieldConstraint.constant = ScreenSize.scaleWidth(170)
        widthOfCVCCardTextFieldConstraint.constant = ScreenSize.scaleWidth(150)
        setTextFieldFontAndTextColor(textField: expiryCardTextField, labelFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setTextFieldFontAndTextColor(textField: cvcCardTextField, labelFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
    }
    
    private func setTextFieldFontAndTextColor(textField: UITextField, labelFont: UIFont, labelTextColor: UIColor, backgroupColor: UIColor = Color.bodyTextColor.withAlphaComponent(0.132), borderWidth: CGFloat = 1, borderColor: CGColor = Color.bodyTextColor.withAlphaComponent(0.3).cgColor, cornerRadius: CGFloat = 8) {
        textField.font = labelFont
        textField.textColor = labelTextColor
        textField.backgroundColor = backgroupColor
        textField.layer.borderWidth = borderWidth
        textField.layer.borderColor = borderColor
        textField.layer.cornerRadius = cornerRadius
    }
    
    private func setUpFrame() {
        heightOfContentView.constant = ScreenSize.screenHeight + 50
        leadingViewConstraint.constant = ScreenSize.scaleWidth(20)
        trailingViewConstraint.constant = ScreenSize.scaleWidth(20)
        spaceOfTopIdCardViewConstraint.constant = ScreenSize.scaleHeight(47)
        spaceOfTopAddCardButtonConstraint.constant = DeviceType.currentDevice() == .iPhone5 ? ScreenSize.scaleHeight(280) :  ScreenSize.scaleHeight(300)
        spaceBottomOfIdCardViewConstraint.constant = ScreenSize.scaleHeight(16)
        widthOfCameraImageConstraint.constant = ScreenSize.scaleWidth(24)
        leadingScanCardViewOfCameraConstraint.constant = (ScreenSize.screenWidth - ScreenSize.scaleWidth(40)) / 2 - ScreenSize.scaleWidth(48)
        heightOfAddCardViewConstraint.constant = ScreenSize.scaleHeight(48)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func actionWhenShowKeyboard() {
        keyboardObserver = KeyboardObserver()
        keyboardObserver?.onKeyboardWillShow = { [weak self] _ in
            guard let self = self else { return }
            self.spaceOfTopAddCardButtonConstraint.constant = ScreenSize.scaleHeight(30)
            let scrollOffsetY = ScreenSize.scaleHeight(112)
            UIView.animate(withDuration: 0.3) {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffsetY), animated: false)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func actionWhenHideKeyboard() {
        keyboardObserver?.onKeyboardWillHide = { [weak self] in
            guard let self = self else { return }
            self.spaceOfTopAddCardButtonConstraint.constant = ScreenSize.scaleHeight(280)
            let scrollOffsetY = 0
            UIView.animate(withDuration: 0.3) {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffsetY), animated: true)
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension AddYourPaymentMethodViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        print("asdasd")
    }
}

extension AddYourPaymentMethodViewController: UITextFieldDelegate {
    
}
