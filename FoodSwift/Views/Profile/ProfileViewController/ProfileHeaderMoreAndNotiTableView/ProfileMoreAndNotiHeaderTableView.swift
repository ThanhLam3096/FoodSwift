//
//  ProfileMoreAndNotiHeaderTableView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 18/11/24.
//

import UIKit

class ProfileMoreAndNotiHeaderTableView: UITableViewHeaderFooterView {

    // MARK: -IBOulet
    
    @IBOutlet private var profileMoreAndNotiHeaderTableView: UIView!
    @IBOutlet private weak var titleMoreAndNotificationLabel: UILabel!
    
    // MARK: -NSLayoutConstraint
    @IBOutlet weak var leadingSpaceOfTitleLabelConstraint: NSLayoutConstraint!
    
    
    //MARK: - Properties
    var viewModel: ProfileMoreAndNotiHeaderTableViewVM? {
        didSet {
            updateView()
        }
    }
    
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
        Bundle.main.loadNibNamed("ProfileMoreAndNotiHeaderTableView", owner: self, options: nil)
        self.addSubview(profileMoreAndNotiHeaderTableView)
        profileMoreAndNotiHeaderTableView.frame = self.bounds
        profileMoreAndNotiHeaderTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setUpUI() {
        setUpLabel()
        setUpFrame()
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: titleMoreAndNotificationLabel, labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
    }
    
    private func setUpFrame() {
        leadingSpaceOfTitleLabelConstraint.constant = ScreenSize.scaleWidth(20)
    }
    
    private func updateView() {
        guard let viewModel = viewModel else {return}
        titleMoreAndNotificationLabel.text = viewModel.title
    }
}
