//
//  PopupChooseImage.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 12/12/24.
//

import Foundation
import UIKit

final class PopupChooseImage: UIView {
    
    // MARK: - IBOulet
    @IBOutlet private weak var popUpView: UIView!
    
    @IBOutlet private weak var libraryView: UIView!
    @IBOutlet private weak var cameraView: UIView!
    @IBOutlet private weak var libraryImageView: UIImageView!
    @IBOutlet private weak var titleChoosingLibraryLabel: UILabel!
    @IBOutlet private weak var cameraImageView: UIImageView!
    @IBOutlet private weak var titleChoosingCameraLabel: UILabel!
    
    // MARK: - Constraint
    @IBOutlet private weak var heightOfViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfLibraryViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingOfCameraViewConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    var vc: UIViewController!
    weak var delegate: PopupChooseImageViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    init(frame: CGRect, inView: UIViewController) {
        super.init(frame: frame)
        xibSetUP(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        vc = inView
    }
    
    func xibSetUP(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        setUpUI()
        addSubview(view)
    }
    
    private func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PopupChooseImage", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    private func setUpUI() {
        popUpView.backgroundColor = Color.bodyTextColor.withAlphaComponent(0.3)
        setUpNSLayoutConstraint()
        setUpView()
        setUpTapGestureView()
    }
    
    private func setUpTapGestureView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        popUpView.addGestureRecognizer(tapGesture)
        let tappingLibraryView = UITapGestureRecognizer(target: self, action: #selector(actionTappingLibraryView))
        libraryView.addGestureRecognizer(tappingLibraryView)
        let tappingCameraView = UITapGestureRecognizer(target: self, action: #selector(actionTappingCameraView))
        cameraView.addGestureRecognizer(tappingCameraView)
    }
    
    @objc private func dismissPopUp() {
        if let delegate = delegate {
            delegate.didTappingOutSideHiddenPopup(view: self)
        }
    }
    
    @objc private func actionTappingLibraryView() {
        if let delegate = delegate {
            delegate.didTappingLibraryView(view: self)
        }
    }
    
    @objc private func actionTappingCameraView() {
        if let delegate = delegate {
            delegate.didTappingCameraView(view: self)
        }
    }
    
    private func setUpView() {
        setUpTextTitleFontTextColorOfLabel(label: titleChoosingLibraryLabel, text: "Choose Image From Library", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(18)) ?? UIFont.systemFont(ofSize: 18), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: titleChoosingCameraLabel, text: "Choose Image From Camera", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(18)) ?? UIFont.systemFont(ofSize: 18), labelTextColor: Color.bodyTextColor)
        
        libraryImageView.tintColor = Color.activeColor
        cameraImageView.tintColor = Color.activeColor
        libraryView.layer.cornerRadius = 12
        cameraView.layer.cornerRadius = 12
    }
    
    
    
    private func setUpNSLayoutConstraint() {
        heightOfViewConstraint.constant = ScreenSize.scaleHeight(130)
        widthOfViewConstraint.constant = ScreenSize.scaleWidth(150)
        leadingSpaceOfLibraryViewConstraint.constant = ScreenSize.scaleWidth(20)
        trailingOfCameraViewConstraint.constant = ScreenSize.scaleWidth(20)
    }
    
}

protocol PopupChooseImageViewDelegate: AnyObject {
    func didTappingOutSideHiddenPopup(view: PopupChooseImage)
    func didTappingLibraryView(view: PopupChooseImage)
    func didTappingCameraView(view: PopupChooseImage)
}
