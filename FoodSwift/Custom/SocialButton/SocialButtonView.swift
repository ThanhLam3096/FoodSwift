//
//  SocialButtonView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 2/9/24.
//

import UIKit

class SocialButtonView: UIView {
    
    @IBOutlet private weak var socialView: UIView!
    @IBOutlet private weak var socialIcon: UIImageView!
    @IBOutlet private weak var socialButton: UIButton!

    //MARK: - Properties
    var viewModel: SocialButtonViewVM? {
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

    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("SocialButtonView", owner: self, options: nil)
        self.addSubview(socialView)
        socialView.frame = self.bounds
        socialView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        socialView.layer.cornerRadius = 8
        setUpIcon()
        setUpSocialButton()
    }
    
    private func setUpIcon() {
        NSLayoutConstraint.activate([
            socialIcon.widthAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(28)),
            socialIcon.heightAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(28))
        ])
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        print("Name Icon \(viewModel.socialType.rawValue)")
        socialIcon.image = UIImage(named: viewModel.socialType.rawValue)
        socialButton.setAttributedTitle(NSAttributedString(string: viewModel.socialType.title, attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: UIColor.white,
        ]), for: .normal)
        socialView.backgroundColor = viewModel.socialType.color
    }
    
    private func setUpSocialButton() {
        socialButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        socialButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
    }

    @objc func buttonTouchDown(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        socialView.backgroundColor = viewModel.socialType.color.withAlphaComponent(0.8)
    }
    
    // Khôi phục màu nền khi thả tay
    @objc func buttonTouchUp(_ sender: UIButton) {
        socialButton.titleLabel?.tintColor = UIColor.white
        guard let viewModel = viewModel else { return }
        socialView.backgroundColor = viewModel.socialType.color
    }
}
