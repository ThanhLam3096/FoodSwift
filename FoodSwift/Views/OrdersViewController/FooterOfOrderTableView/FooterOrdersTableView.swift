//
//  FooterOrdersTableView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 6/12/24.
//

import UIKit

protocol FooterOrdersTableViewDelegate: AnyObject {
    func tappingPaymentProceed(view: FooterOrdersTableView)
}

final class FooterOrdersTableView: UITableViewHeaderFooterView {

    // MARK: - IBOulet
    @IBOutlet private weak var proceedPaymentButton: UIButton!
    @IBOutlet private var footerOrdersTableView: UIView!
    
    // MARK: - NSLayoutConstraint
    @IBOutlet private weak var trailingSpaceOfContentView: NSLayoutConstraint!
    
    weak var delegate: FooterOrdersTableViewDelegate?
    
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
        self.contentView.addSubview(footerOrdersTableView)
        footerOrdersTableView.frame = self.bounds
        footerOrdersTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setUpUI()
        setUpNSLayoutConstraint()
    }
    
    private func setUpUI() {
        proceedPaymentButton.setAttributedTitle(NSAttributedString(string: "Proceed Payment", attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16)) as Any,
            .foregroundColor: Color.accentColor,
        ]), for: .normal)
    }

    private func setUpNSLayoutConstraint() {
        trailingSpaceOfContentView.constant = ScreenSize.scaleWidth(20)
    }
    
    @IBAction func proceedPaymentButtonTouchUpInside(_ sender: Any) {
        if let delegate = delegate {
            delegate.tappingPaymentProceed(view: self)
        }
    }
    
}
