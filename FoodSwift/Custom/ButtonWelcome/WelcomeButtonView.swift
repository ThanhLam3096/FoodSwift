//
//  WelcomeButtonView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 30/4/24.
//

import UIKit

class WelcomeButtonView: UIView {

    @IBOutlet private var welcomButtonView: UIView!
    @IBOutlet private weak var startButton: UIButton!
    var delegate: WelcomButtonViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUIView()
    }
    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("WelcomeButtonView", owner: self, options: nil)
        self.addSubview(welcomButtonView)
        welcomButtonView.frame = self.bounds
        welcomButtonView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
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

protocol WelcomButtonViewDelegate {
    func tappingInsideButton(view: WelcomeButtonView)
}
