//
//  HeaderFilterCollectionReusableView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 15/11/24.
//

import UIKit

protocol HeaderFilterDelegate {
    func tappingInsideButton(view: HeaderFilterCollectionReusableView)
}

final class HeaderFilterCollectionReusableView: UICollectionReusableView {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var titleFilterLabel: UILabel!
    @IBOutlet private weak var clearAllLabel: UILabel!
    @IBOutlet private weak var clearAllButton: UIButton!
    
    
    @IBOutlet private weak var widthOfClearAllButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfClearAllButtonConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var delegate: HeaderFilterDelegate?
    var viewModel: HeaderFilterCollectionViewCellVM? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUIView()
    }
    
    private func setUpUIView() {
        setUpTextTitleFontTextColorOfLabel(label: titleFilterLabel, labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: clearAllLabel, text: "Clear All" ,labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.mainColor)
        clearAllLabel.textAlignment = .right
        widthOfClearAllButtonConstraint.constant = ScreenSize.scaleWidth(60)
        heightOfClearAllButtonConstraint.constant = ScreenSize.scaleHeight(20)
    }
    
    private func updateView() {
        guard let title = viewModel?.title else { return }
        titleFilterLabel.text = title
    }
    
    
    @IBAction func clearButtonTouchUpInside(_ sender: Any) {
        if let delegate = delegate {
            delegate.tappingInsideButton(view: self)
        }
    }
    
}
