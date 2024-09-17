//
//  DefinePhoneNumberViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 6/9/24.
//

import UIKit

final class DefinePhoneNumberViewController: BaseViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet var DefinePhoneNumberView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var title2Label: UILabel!
    @IBOutlet private weak var dropDownMenu: UIButton!
    @IBOutlet private weak var nationCodePhoneNumberImageView: UIImageView!
    @IBOutlet private weak var listFlagTableView: UITableView!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var signUpButtonView: WelcomeButtonView!
    @IBOutlet private weak var topSpaceSignUpButtonView: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: DefinePhoneNumberVM = DefinePhoneNumberVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpUI() {
        setUpNavigation()
        titleLabel.text = "Get started with Foodly"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 24)
        titleLabel.textColor = UIColor(hex: "#010F07")
        
        title2Label.text = "Enter your phone number to use foodly and enjoy your food :)"
        title2Label.font = UIFont.fontYugothicRegular(ofSize: 16)
        title2Label.textColor = UIColor(hex: "#868686")
        title2Label.numberOfLines = 0
        
        phoneNumberLabel.text = "PHONE NUMBER"
        phoneNumberLabel.font = UIFont.fontYugothicLight(ofSize: 12)
        phoneNumberLabel.textColor = UIColor(hex: "#868686")
        
        dropDownMenu.tintColor = UIColor(hex: "#868686")
        setUPTableView()
        setUpTextField()
        setUpSignUPButton()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Login to Tamago Food\nServices"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUPTableView() {
        listFlagTableView.register(nibWithCellClass: FlagCodeNumberTableViewCell.self)
        listFlagTableView.isHidden = true
        listFlagTableView.delegate = self
        listFlagTableView.dataSource = self
    }
    
    private func setUpTextField() {
        phoneNumberTextField.attributedText = updateStringTextField(codePhoneNumber: viewModel.codeNumber[0])
        phoneNumberTextField.borderStyle = .none
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.delegate = self
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        DefinePhoneNumberView.addGestureRecognizer(tapGesture)
    }
    
    private func setUpSignUPButton() {
        signUpButtonView.setButtonTitle("SIGN UP")
        signUpButtonView.delegate = self
    }
    
    @objc func dismissKeyboard() {
        guard let text = phoneNumberTextField.text else { return }
        if text.count <= 3 {
            phoneNumberTextField.attributedText = updateStringTextField(codePhoneNumber: text)
        }
        view.endEditing(true) // Ẩn bàn phím hoặc mất focus từ textField
        topSpaceSignUpButtonView.constant = 400
    }
    
    private func updateStringTextField(codePhoneNumber: String) -> NSAttributedString {
        let attributedStringTextTitle = NSMutableAttributedString(string: (codePhoneNumber + "123456789"))
        attributedStringTextTitle.addAttribute(.font, value: UIFont.fontYugothicRegular(ofSize: 16) as Any, range: NSRange(location: 0, length: attributedStringTextTitle.length))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: UIColor.black as Any, range: NSRange(location: 0, length: codePhoneNumber.count - 1))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: UIColor(hex: "#868686") as Any, range: NSRange(location: codePhoneNumber.count, length: 9))
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
        listFlagTableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt()
    }
}

extension DefinePhoneNumberViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        topSpaceSignUpButtonView.constant = 150
        if let text = textField.text, text.count >= 9  {
            let newText = String(text.dropLast(9))
            let result = NSMutableAttributedString(string: newText)
            result.addAttribute(.font, value: UIFont.fontYugothicRegular(ofSize: 16) as Any, range: NSRange(location: 0, length: result.length))
            result.addAttribute(.foregroundColor, value: UIColor.black as Any, range: NSRange(location: 0, length: result.length))
            phoneNumberTextField.attributedText = result
        }
    }
}

extension DefinePhoneNumberViewController: WelcomButtonViewDelegate {
    func tappingInsideButton(view: WelcomeButtonView) {
        self.navigationController?.pushViewController(ScreenName.verifyPhoneNumber, animated: true)
    }

}
