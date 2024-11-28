//
//  SearchRecentHeaderTableView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 18/11/24.
//

import UIKit

class SearchRecentHeaderTableView: UITableViewHeaderFooterView {

    // MARK: -IBOulet
    @IBOutlet private var searchRecentHeaderTableView: UIView!
    @IBOutlet private weak var titleHeaderLabel: UILabel!
    @IBOutlet private weak var clearAllLabel: UILabel!
    @IBOutlet weak var clearAllButton: UIButton!
    
    // MARK: -NSLayoutConstraint
    @IBOutlet weak var widthOfRecentSearchLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfRecentSearchLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthOfClearAllButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfClearAllButtonConstraint: NSLayoutConstraint!
    
    // MARK: -Properties
    var delegate: SearchRecentHeaderTableViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("SearchRecentHeaderTableView", owner: self, options: nil)
        self.addSubview(searchRecentHeaderTableView)
        searchRecentHeaderTableView.frame = self.bounds
        searchRecentHeaderTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setUpUI()
    }
    
    private func setUpUI() {
        setUpTextTitleFontTextColorOfLabel(label: titleHeaderLabel, text: "RECENT SEARCHES", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: clearAllLabel, text: "CLEAR ALL", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.mainColor)
        clearAllLabel.textAlignment = .right
        widthOfRecentSearchLabelConstraint.constant = ScreenSize.scaleWidth(140)
        heightOfRecentSearchLabelConstraint.constant = ScreenSize.scaleHeight(25)
        widthOfClearAllButtonConstraint.constant = ScreenSize.scaleWidth(60)
        heightOfClearAllButtonConstraint.constant = ScreenSize.scaleHeight(20)
    }
    
    @IBAction func clearAllButtonTouchUpInside(_ sender: Any) {
        if let delegate = delegate {
            delegate.tappingInsideButton(view: self)
        }
    }

}

protocol SearchRecentHeaderTableViewDelegate: AnyObject {
    func tappingInsideButton(view: SearchRecentHeaderTableView)
}
