//
//  HeaderOrdersTableView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/12/24.
//

import UIKit
protocol HeaderOrdersTableViewDelegate: AnyObject {
    func tappingClearAllButton(view: HeaderOrdersTableView, type: YourOrder)
}

final class HeaderOrdersTableView: UITableViewHeaderFooterView {
    
    // MARK: - IBOulet
    @IBOutlet private weak var titleHeaderLabel: UILabel!
    @IBOutlet private weak var clearAllButton: UIButton!
    
    @IBOutlet var headerOrdersTableView: UIView!
    
    // MARK: - NSLayoutConstraint
    @IBOutlet private weak var leadingSpaceOfContentView: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfContentView: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: HeaderOrdersTableViewVM? {
        didSet {
            updateUIView()
        }
    }
    static let identifier = "HeaderOrdersTableView"
    weak var delegate: HeaderOrdersTableViewDelegate?
    
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
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        self.contentView.addSubview(headerOrdersTableView)
        headerOrdersTableView.frame = self.bounds
        headerOrdersTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setUpUI()
        setUpNSLayoutConstraint()
    }
    
    private func setUpUI() {
        setUpTextTitleFontTextColorOfLabel(label: titleHeaderLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        clearAllButton.setAttributedTitle(NSAttributedString(string: "CLEAR ALL", attributes: [
            .font: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: Color.mainColor,
        ]), for: .normal)
    }

    private func setUpNSLayoutConstraint() {
        leadingSpaceOfContentView.constant = ScreenSize.scaleWidth(20)
        trailingSpaceOfContentView.constant = ScreenSize.scaleWidth(20)
    }
    
    private func updateUIView() {
        guard let type = viewModel?.type else { return }
        titleHeaderLabel.text = type.title
    }
    
    
    @IBAction func clearAllButtonTouchUpInside(_ sender: Any) {
        guard let type = viewModel?.type else { return }
        if let delegate = delegate {
            delegate.tappingClearAllButton(view: self, type: type)
        }
    }
}
