//
//  LaunchScreenViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 27/11/24.
//

import UIKit

class LaunchScreenViewController: BaseViewController {
    
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var loadingView: UIView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        changeRoot()
    }

    override func setUpUI() {
        super.setUpUI()
        setUpTitle()
        setUpLoadingView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.startBouncingLabelWithCoreAnimation(label: self.titleLabel)
//            self.startRotatingAndScaling(image: self.launchImageView)
        })
    }
    
    private func setUpTitle() {
        setUpTextTitleFontTextColorOfLabel(label: titleLabel, text: "Tamamo Gang", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(50)) ?? UIFont.systemFont(ofSize: 69), labelTextColor: Color.activeColor)
    }
    
    private func setUpLoadingView() {
        loadingView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        addYouTubeLoadingEffect()
    }
    
    func startBouncingLabelWithCoreAnimation(label: UILabel) {
        let bounceXAnimation = CABasicAnimation(keyPath: "position.x")
        bounceXAnimation.fromValue = label.layer.position.x
        bounceXAnimation.toValue = label.layer.position.x + 10
        bounceXAnimation.duration = 0.5
        bounceXAnimation.autoreverses = true
        bounceXAnimation.repeatCount = .infinity
        
        let bounceYAnimation = CABasicAnimation(keyPath: "position.y")
        bounceYAnimation.fromValue = label.layer.position.y
        bounceYAnimation.toValue = label.layer.position.y - 20
        bounceYAnimation.duration = 0.5
        bounceYAnimation.autoreverses = true
        bounceYAnimation.repeatCount = .infinity
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0  // Kích thước ban đầu
        scaleAnimation.toValue = 0.5    // Kích thước phóng to (1.5 lần)
        scaleAnimation.duration = 0.5   // Thời gian phóng to/thu nhỏ
        scaleAnimation.autoreverses = true // Thu nhỏ lại sau khi phóng to
        scaleAnimation.repeatCount = .infinity // Lặp lại vô hạn
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [bounceXAnimation, bounceYAnimation, scaleAnimation]
        groupAnimation.duration = 2.0
        groupAnimation.repeatCount = .infinity
        label.layer.add(scaleAnimation, forKey: "bounceAndScale")
    }
    
    func startRotatingAndScaling(image: UIImageView) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = 2.0
        rotationAnimation.repeatCount = .infinity

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.2
        scaleAnimation.duration = 1.0
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [rotationAnimation, scaleAnimation]
        groupAnimation.duration = 2.0
        groupAnimation.repeatCount = .infinity

        image.layer.add(groupAnimation, forKey: "rotateAndScale")
    }
    
    func addYouTubeLoadingEffect() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0,
                                          y: 0,
                                          width: loadingView.frame.width + 20,
                                          height: loadingView.frame.height)
        gradientLayer.colors = [
            Color.accentColor.cgColor,
            Color.bodyTextColor.cgColor,
            Color.accentColor.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0.0, 0.5, 1.0]

        loadingView.layer.addSublayer(gradientLayer)

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2] // Điểm bắt đầu gradient
        animation.toValue = [0.8, 0.9, 1.0]   // Điểm kết thúc gradient
        animation.duration = 1.0 // Thời gian 1 vòng lặp
        animation.repeatCount = .infinity // Lặp mãi mãi

        gradientLayer.add(animation, forKey: "youtubeLoading")
    }
    
    private func dancingTitle() {
        UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.autoreverse, .repeat],
                           animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -10).scaledBy(x: 0.5, y: 0.5)
            }, completion: nil)
    }

    private func changeRoot() {
        _ = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { (timer) in
            SceneDelegate.shared.changeRoot(vc: ScreenName.welcomeScreen)
        }
    }

}
