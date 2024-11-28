//
//  DefinePhoneNumberViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 6/9/24.
//

import UIKit

final class DefinePhoneNumberViewController: BaseViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var title2Label: UILabel!
    @IBOutlet private weak var dropDownMenu: UIButton!
    @IBOutlet private weak var nationCodePhoneNumberImageView: UIImageView!
    @IBOutlet private weak var listFlagTableView: UITableView!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var signUpButtonView: OrangeButtonView!
    
    // MARK: - @NSLayoutConstraint
    
    @IBOutlet private weak var topSpaceOfTitleScreenConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfTitleScreenConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var leadingTitle2Constraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingTitle2Constraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfTitle2Constraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfNationImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfNationImageConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfDownArrowButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfTableViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfTableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceSignUpButtonView: NSLayoutConstraint!
    @IBOutlet private weak var heightOfSignUpButtonViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var popUp: PopUpView!
    var viewModel: DefinePhoneNumberVM = DefinePhoneNumberVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionWhenShowKeyboard()
        actionWhenHideKeyboard()
    }
    
    override func setUpUI() {
        setUpNavigation()
        setUpLabel()
        setUpNationImageView()
        dropDownMenu.tintColor = Color.bodyTextColor
        setUpTableView()
        setUpTextField()
        setUpSignUPButton()
        actionOfTappingOutSideHideOfKeyBoard()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Login to Tamago Food\nServices"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: titleLabel, text: "Get started with Foodly", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(24)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(24)), labelTextColor: Color.mainColor)
        topSpaceOfTitleScreenConstraint.constant = ScreenSize.scaleHeight(24)
        botSpaceOfTitleScreenConstraint.constant = ScreenSize.scaleHeight(20)
        
        setUpTextTitleFontTextColorOfLabel(label: title2Label, text: "Enter your phone number to use foodly and enjoy your food :)", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(16)), labelTextColor: Color.bodyTextColor)
        title2Label.numberOfLines = 0
        leadingTitle2Constraint.constant = ScreenSize.scaleWidth(20)
        trailingTitle2Constraint.constant = ScreenSize.scaleWidth(20)
        botSpaceOfTitle2Constraint.constant = ScreenSize.scaleHeight(20)
        
        setUpTextTitleFontTextColorOfLabel(label: phoneNumberLabel, text: "PHONE NUMBER", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(12)), labelTextColor: Color.bodyTextColor)
    }
    
    private func setUpNationImageView() {
        widthOfNationImageConstraint.constant = ScreenSize.scaleWidth(32)
        heightOfNationImageConstraint.constant = ScreenSize.scaleHeight(24)
    }
    
    private func setUpButton() {
        widthOfDownArrowButtonConstraint.constant = ScreenSize.scaleWidth(12)
    }
    
    private func setUpTableView() {
        listFlagTableView.register(nibWithCellClass: FlagCodeNumberTableViewCell.self)
        listFlagTableView.isHidden = true
        listFlagTableView.delegate = self
        listFlagTableView.dataSource = self
        widthOfTableViewConstraint.constant = ScreenSize.scaleWidth(120)
        heightOfTableViewConstraint.constant = ScreenSize.scaleHeight(100)
    }
    
    private func setUpTextField() {
        phoneNumberTextField.font = UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16))
        phoneNumberTextField.attributedText = updateStringTextField(codePhoneNumber: viewModel.codeNumber[0])
        phoneNumberTextField.borderStyle = .none
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.delegate = self
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    private func setUpSignUPButton() {
        signUpButtonView.viewModel = OrangeButtonViewModel(title: "SIGN UP")
        signUpButtonView.delegate = self
        heightOfSignUpButtonViewConstraint.constant = ScreenSize.scaleHeight(48)
        topSpaceSignUpButtonView.constant = ScreenSize.scaleHeight(400)
    }
    
    private func actionOfTappingOutSideHideOfKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        guard let text = phoneNumberTextField.text else { return }
        if text.isEmpty {
            phoneNumberTextField.attributedText = updateStringTextField(codePhoneNumber: viewModel.codeNumber[viewModel.indexOfNationFlagsList])
        } else if text.count <= 3 {
            phoneNumberTextField.attributedText = updateStringTextField(codePhoneNumber: text)
        }
        view.endEditing(true)
    }
    
    private func updateStringTextField(codePhoneNumber: String) -> NSAttributedString {
        let attributedStringTextTitle = NSMutableAttributedString(string: (codePhoneNumber + "123456789"))
        attributedStringTextTitle.addAttribute(.font, value: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) as Any, range: NSRange(location: 0, length: attributedStringTextTitle.length))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: UIColor.black as Any, range: NSRange(location: 0, length: codePhoneNumber.count))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: Color.bodyTextColor as Any, range: NSRange(location: codePhoneNumber.count, length: 9))
        return attributedStringTextTitle
    }
    
    @objc func textFieldDidChanged() {
        print(phoneNumberTextField.text ?? "")
    }
    
    @IBAction func dropDownButtonTouchUpInside(_ sender: Any) {
        listFlagTableView.isHidden = false
    }
    
    @objc func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension DefinePhoneNumberViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension DefinePhoneNumberViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: FlagCodeNumberTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flag = viewModel.nameFlag[indexPath.row]
        nationCodePhoneNumberImageView.image = UIImage(named: flag)
        phoneNumberTextField.attributedText = updateStringTextField(codePhoneNumber: viewModel.codeNumber[indexPath.row])
        viewModel.indexOfNationFlagsList = indexPath.row
        listFlagTableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt()
    }
}

extension DefinePhoneNumberViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text, text.count >= 9  {
            let newText = String(text.dropLast(9))
            let result = NSMutableAttributedString(string: newText)
            result.addAttribute(.font, value: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) as Any, range: NSRange(location: 0, length: result.length))
            result.addAttribute(.foregroundColor, value: UIColor.black as Any, range: NSRange(location: 0, length: result.length))
            phoneNumberTextField.attributedText = result
        }
    }
}

extension DefinePhoneNumberViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        viewModel.sendVerificationCode(to: phoneNumberTextField.text ?? "") { [weak self] success, message in
            guard let this = self else { return}
            this.showPopUp(title: message, isSuccess: success)
        }
    }
}

extension DefinePhoneNumberViewController {
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
    
    private func actionWhenShowKeyboard() {
        keyboardObserver = KeyboardObserver()
        keyboardObserver?.onKeyboardWillShow = { [weak self] heightOfKeyBoard in
            guard let this = self else { return }
            UIView.animate(withDuration: 0.5) {
                this.topSpaceSignUpButtonView.constant = ScreenSize.scaleHeight(400) - heightOfKeyBoard
            }
        }
    }
    
    private func actionWhenHideKeyboard() {
        keyboardObserver?.onKeyboardWillHide = { [weak self] in
            guard let this = self else { return }
            UIView.animate(withDuration: 0.5) {
                this.topSpaceSignUpButtonView.constant = ScreenSize.scaleHeight(400)
            }
        }
    }
}

extension DefinePhoneNumberViewController: PopUpViewDelegate {
    func didTappingButton(view: PopUpView, isSuccess: Bool) {
        self.popUp?.removeFromSuperview()
        if isSuccess {
            self.navigationController?.pushViewController(ScreenName.verifyPhoneNumber, animated: true)
        } else {
            return
        }
    }
}
