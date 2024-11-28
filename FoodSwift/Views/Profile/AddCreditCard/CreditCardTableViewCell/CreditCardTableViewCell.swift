//
//  CreditCardTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 20/11/24.
//

import UIKit

protocol CreditCardTableViewCellDelegate {
    func tappingChosingDefaultPayment(view: CreditCardTableViewCell, typeCard: CreditCardType)
}

final class CreditCardTableViewCell: UITableViewCell {
    
    // MARK: IBOutlet
    @IBOutlet private weak var creditCardImageView: UIImageView!
    @IBOutlet private weak var titleCardLabel: UILabel!
    @IBOutlet private weak var deafultPaymentLabel: UILabel!
    @IBOutlet private weak var rightArrowButton: UIButton!
    @IBOutlet private weak var lineView: UIView!
    
    // MARK: NSLayoutConstraint CreditCardImage
    @IBOutlet private weak var widthOfCreditCardImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfCreditCardImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfCreditCardImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfCreditCardImageConstraint: NSLayoutConstraint!
    
    // MARK: NSLayoutConstraint Label
    @IBOutlet private weak var betweenSpaceOfLabelConstraint: NSLayoutConstraint!
    
    // MARK: NSLayoutConstraint rightArrowButton
    @IBOutlet private weak var widthOfRightArrowButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfRightArrowButtonConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: CreditCardTableViewCellVM? {
        didSet {
            updateView()
        }
    }
    var delegate: CreditCardTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpUI() {
        setUpLabel()
        setUpLayoutConstraintOfCreditCardImageView()
        setUpRightArrowButton()
        setUpsetUpLayoutConstraintRightArrowButton()
        lineView.backgroundColor = UIColor(hex: "#F6F6F6")
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: titleCardLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
    }
    
    private func setUpLayoutConstraintOfCreditCardImageView() {
        widthOfCreditCardImageConstraint.constant = ScreenSize.scaleWidth(40)
        heightOfCreditCardImageConstraint.constant = ScreenSize.scaleWidth(34)
        leadingSpaceOfCreditCardImageConstraint.constant = ScreenSize.scaleWidth(10)
        trailingSpaceOfCreditCardImageConstraint.constant = ScreenSize.scaleWidth(16)
        
        betweenSpaceOfLabelConstraint.constant = ScreenSize.scaleHeight(5)
    }
    
    private func setUpRightArrowButton() {
        rightArrowButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        rightArrowButton.tintColor = Color.mainColor
    }
    
    private func setUpsetUpLayoutConstraintRightArrowButton() {
        widthOfRightArrowButtonConstraint.constant = ScreenSize.scaleWidth(24)
        trailingSpaceOfRightArrowButtonConstraint.constant = ScreenSize.scaleWidth(20)
    }
    
    private func updateView() {
        guard let typeCard = viewModel?.typeCard, let isDefault = viewModel?.isDefault else { return }
        creditCardImageView.image = UIImage(named: typeCard.icon)
        titleCardLabel.text = typeCard.title
        
        if isDefault {
            setUpTextTitleFontTextColorOfLabel(label: deafultPaymentLabel, text: "Default Payment", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        } else {
            setUpTextTitleFontTextColorOfLabel(label: deafultPaymentLabel, text: "Not Default", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        }
    }
    
    
    @IBAction func tappingRightArrowButtonTouchUpInside(_ sender: Any) {
        if let delegate = delegate, let typeCard = viewModel?.typeCard {
            delegate.tappingChosingDefaultPayment(view: self, typeCard: typeCard)
        }
    }
}
