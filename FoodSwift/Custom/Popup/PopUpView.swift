//
//  PopUpView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 25/11/24.
//

import UIKit

final class PopUpView: UIView {

    // MARK: IBOulet
    
    @IBOutlet private var popUpView: UIView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var checkMarkView: UIView!
    @IBOutlet private weak var checkMarkImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var doneButton: UIButton!
    
    // MARK: - Constraint
    @IBOutlet private weak var heightOfContentViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfContentViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfContentViewConstraint: NSLayoutConstraint!

    @IBOutlet private weak var widthOfCheckMarkViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfCheckMarkViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightDoneButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfDoneButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfDoneButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfDoneButtonConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    var vc: UIViewController!
    weak var delegate: PopUpViewDelegate?
    
    var viewModel: PopUpViewVM? {
        didSet {
            updateView()
        }
    }
    
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
        let nib = UINib(nibName: "PopUpView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    private func setUpUI() {
        popUpView.backgroundColor = Color.bodyTextColor.withAlphaComponent(0.3)
        
        contentView.layer.cornerRadius = 12
        
        checkMarkView.layer.cornerRadius = ScreenSize.scaleWidth(40)
        checkMarkView.layer.borderWidth = 3
        checkMarkView.layer.borderColor = Color.bgColor.cgColor
        
        
        setUpTextTitleFontTextColorOfLabel(label: titleLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        
        doneButton.backgroundColor = Color.activeColor
        doneButton.layer.cornerRadius = 6
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        setUpConstraintContentView()
        setUpConstraintCheckMarkView()
        setUpConstraintDoneButton()
    }
    
    private func setUpConstraintContentView() {
        heightOfContentViewConstraint.constant = ScreenSize.scaleHeight(180)
        leadingSpaceOfContentViewConstraint.constant = ScreenSize.scaleWidth(20)
        trailingSpaceOfContentViewConstraint.constant = ScreenSize.scaleWidth(20)
    }
    
    private func setUpConstraintCheckMarkView() {
        widthOfCheckMarkViewConstraint.constant = ScreenSize.scaleWidth(80)
        topSpaceOfCheckMarkViewConstraint.constant = ScreenSize.scaleHeight(-40)
    }
    
    private func setUpConstraintDoneButton() {
        heightDoneButtonConstraint.constant = ScreenSize.scaleHeight(30)
        topSpaceOfDoneButtonConstraint.constant = ScreenSize.scaleHeight(20)
        leadingSpaceOfDoneButtonConstraint.constant = ScreenSize.scaleWidth(15)
        trailingSpaceOfDoneButtonConstraint.constant = ScreenSize.scaleWidth(15)
    }
    
    private func updateView() {
        guard let viewModel = viewModel else {return}
        titleLabel.text = viewModel.title
        if viewModel.isSuccesPopup {
            checkMarkView.backgroundColor = Color.accentColor
            checkMarkImageView.image = UIImage(systemName: "checkmark")
            doneButton.setAttributedTitle(NSAttributedString(string: "Done", attributes: [
                .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
                .foregroundColor: Color.bgColor,
            ]), for: .normal)
        } else {
            checkMarkView.backgroundColor = UIColor.red.withAlphaComponent(0.6)
            checkMarkImageView.image = UIImage(systemName: "xmark")
            doneButton.setAttributedTitle(NSAttributedString(string: "Try Again", attributes: [
                .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
                .foregroundColor: Color.bgColor,
            ]), for: .normal)
        }
    }
    
    @IBAction func doneButtonTouchUpInside(_ sender: Any) {
        if let delegate = delegate, let isSuccess = viewModel?.isSuccesPopup {
            delegate.didTappingButton(view: self, isSuccess: isSuccess)
        }
    }
}

protocol PopUpViewDelegate: AnyObject {
    func didTappingButton(view: PopUpView, isSuccess: Bool)
}
