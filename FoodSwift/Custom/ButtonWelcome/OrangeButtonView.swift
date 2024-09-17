//
//  WelcomeButtonView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 30/4/24.
//

import UIKit

class OrangeButtonView: UIView {

    @IBOutlet private var orangeButtonView: UIView!
    @IBOutlet private weak var startButton: UIButton!
    var delegate: OrangeButtonViewViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUIView()
    }
    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("OrangeButtonView", owner: self, options: nil)
        self.addSubview(orangeButtonView)
        orangeButtonView.frame = self.bounds
        orangeButtonView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        startButton.setAttributedTitle(NSAttributedString(string: "GET STARTED", attributes: [
            .font: UIFont.fontYugothicUIBold(ofSize: 14) as Any
        ]), for: .normal)
        startButton.backgroundColor = UIColor(red: 238/255, green: 167/255, blue: 52/255, alpha: 1.0)
        startButton.layer.cornerRadius = 8
    }
    
    @IBAction func getStartButtonTouchUpInside(_ sender: Any) {
        if let delegate = delegate {
            delegate.tappingInsideButton(view: self)
        }
    }
    
    func setButtonTitle(_ title: String) {
        startButton.setAttributedTitle(NSAttributedString(string: title, attributes: [
            .font: UIFont.fontYugothicUIBold(ofSize: 14) as Any
        ]), for: .normal)
    }
    
}

protocol OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView)
}
