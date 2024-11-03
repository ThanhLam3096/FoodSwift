//
//  TextFieldLoginView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 30/8/24.
//

import UIKit

class TextFieldLoginView: UIView {
    @IBOutlet private weak var loginFormTextView: UIView!
    @IBOutlet private weak var eyeButton: UIButton!
    @IBOutlet private weak var titleTextFieldLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    @IBOutlet private weak var infoTextField: UITextField!
    
    //MARK: - Properties
    var viewModel: TextFieldLoginViewVM? {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUIView()
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        titleTextFieldLabel.text = viewModel.infoTextField
        eyeButton.isHidden = !viewModel.isPasswordTextField
    }
    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("TextFieldLoginView", owner: self, options: nil)
        self.addSubview(loginFormTextView)
        loginFormTextView.frame = self.bounds
        loginFormTextView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        titleTextFieldLabel.font = UIFont.fontYugothicLight(ofSize: 12)
        titleTextFieldLabel.textColor = Color.bodyTextColor
        eyeButton.tintColor = Color.tabBarColor
        lineView.backgroundColor = UIColor(hex: "#F3F2F2")
        infoTextField.borderStyle = .none
    }
    @IBAction func eyeShowPasswordTouchUpInside(_ sender: Any) {
        print("ádasdasd")
    }
    
}
