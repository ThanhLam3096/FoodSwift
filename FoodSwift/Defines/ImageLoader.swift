//
//  ImageLoader.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 26/10/24.
//

import UIKit
import SDWebImage
import SkeletonView

class ImageLoader {
    // MARK: - Singleton instance
    private static var sharedImageLoader: ImageLoader = {
        let imageLoader = ImageLoader()
        return imageLoader
    }()
    
    class func shared() -> ImageLoader {
        return sharedImageLoader
    }
    
    private init() {}
    
    func addShimmerEffect(to view: UIView) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor, UIColor.lightGray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = view.bounds
        
        // Animation cho shimmer
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -view.bounds.width
        animation.toValue = view.bounds.width
        animation.duration = 1.5
        animation.repeatCount = .infinity
        
        gradientLayer.add(animation, forKey: "shimmer")
        view.layer.addSublayer(gradientLayer)
        return gradientLayer
    }
    
    func loadImageWithShimmerEffect(url: URL, imageView: UIImageView) {
        // Thêm shimmer placeholder trước khi ảnh tải
        let shimmerLayer = addShimmerEffect(to: imageView)
        
        // Sử dụng SDWebImage để tải ảnh
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "jeanne"), options: .continueInBackground) { [weak shimmerLayer] (image, error, _, _) in
            // Xóa shimmer khi ảnh đã tải xong
            shimmerLayer?.removeFromSuperlayer()
            
            // Thêm animation fade-in cho ảnh
            if image != nil {
                UIView.transition(with: imageView, duration: 2, options: .transitionFlipFromTop, animations: {
                    imageView.image = image
                }, completion: nil)
            }
        }
    }
    
    func loadImageWithFadeIn(url: URL, imageView: UIImageView) {
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "jeanne"), options: .continueInBackground) { image, error, _, _ in
            if image != nil {
                UIView.transition(with: imageView, duration: 2, options: .transitionFlipFromTop, animations: {
                    imageView.image = image
                }, completion: nil)
            }
        }
    }
    
    // MARK: - Load Image with Skeleton View
    func loadImageWithSkeleton(url: URL, into imageView: UIImageView) {
        imageView.showAnimatedSkeleton()
        
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "jeanne"), options: .continueInBackground) { image, _, _, _ in
            imageView.hideSkeleton()
            if image != nil {
                UIView.transition(with: imageView, duration: 2, options: .transitionFlipFromTop, animations: {
                    imageView.image = image
                }, completion: nil)
            }
        }
    }
}
