//
//  AddCreditCardViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 20/11/24.
//

import UIKit

class AddCreditCardViewController: BaseViewController {

    // MARK: IBOutlet
    @IBOutlet private weak var creditCardImageView: UIImageView!
    @IBOutlet private weak var dontHaveCardLabel: UILabel!
    @IBOutlet private weak var addAnyCardLabel: UILabel!
    @IBOutlet private weak var addCreditCardButton: UIButton!
    
    // MARK: IBOutlet TableView
    @IBOutlet private weak var creditCardTableView: UITableView!
    
    // MARK: NSLayoutConstraint CreditCardImage
    @IBOutlet private weak var widthOfCreditCardImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfCreditCardImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfCreditCardImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfCreditCardImageConstraint: NSLayoutConstraint!
    
    // MARK: NSLayoutConstraint Label
    @IBOutlet private weak var betweenSpaceOfCardLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfAddAnyCardLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfAddAnyCardLabelConstraint: NSLayoutConstraint!
    
    // MARK: NSLayoutConstraint AddCreditCardButton
    @IBOutlet private weak var widthOfAddCreditCardButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfAddCreditCardButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfAddCreditCardButtonConstraint: NSLayoutConstraint!
    
    // MARK: NSLayoutConstraint TableView
    @IBOutlet private weak var topSpaceCreditCardTableViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfCreditCardTableViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: AddCreditCardViewControllerVM = AddCreditCardViewControllerVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        checkHaveCard()
    }

    override func setUpUI() {
        setUpNavigation()
        checkHaveCard()
        setUpLabel()
        setUpFrameConstraint()
        setUpAddCreditCardButton()
        setUpTableView()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Payment Methods"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpCreditCardImage() {
        creditCardImageView.image = UIImage(named: "credit_card")
        creditCardImageView.contentMode = .scaleAspectFit
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: dontHaveCardLabel, text: "Don't have any card\n:)", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(24)) ?? UIFont.systemFont(ofSize: 24), labelTextColor: Color.mainColor)
        dontHaveCardLabel.numberOfLines = 2
        dontHaveCardLabel.textAlignment = .center
        setUpTextTitleFontTextColorOfLabel(label: addAnyCardLabel, text: "It’s seems like you have not added any credit or debit card. You may easily add card.", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        addAnyCardLabel.numberOfLines = 0
        addAnyCardLabel.textAlignment = .center
    }
    
    private func setUpFrameConstraint() {
        widthOfCreditCardImageConstraint.constant = ScreenSize.scaleWidth(125)
        heightOfCreditCardImageConstraint.constant = ScreenSize.scaleWidth(123)
        topSpaceOfCreditCardImageConstraint.constant = ScreenSize.scaleHeight(100)
        botSpaceOfCreditCardImageConstraint.constant = ScreenSize.scaleHeight(30)
        
        betweenSpaceOfCardLabelConstraint.constant = ScreenSize.scaleHeight(15)
        leadingSpaceOfAddAnyCardLabelConstraint.constant = ScreenSize.scaleWidth(44)
        trailingSpaceOfAddAnyCardLabelConstraint.constant = ScreenSize.scaleWidth(44)
        
        topSpaceOfAddCreditCardButtonConstraint.constant = ScreenSize.scaleHeight(20)
        widthOfAddCreditCardButtonConstraint.constant = ScreenSize.scaleWidth(255)
        heightOfAddCreditCardButtonConstraint.constant = ScreenSize.scaleHeight(38)
        
        topSpaceCreditCardTableViewConstraint.constant = ScreenSize.scaleHeight(24)
        heightOfCreditCardTableViewConstraint.constant = viewModel.heightForRow() * 3
    }
    
    private func setUpAddCreditCardButton() {
        addCreditCardButton.setAttributedTitle(NSAttributedString(string: "ADD CREDIT CARDS", attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: Color.activeColor
        ]), for: .normal)
        addCreditCardButton.layer.cornerRadius = 6
        addCreditCardButton.layer.borderWidth = 1
        addCreditCardButton.layer.borderColor = Color.activeColor.cgColor
        addCreditCardButton.backgroundColor = Color.bgColor

        addCreditCardButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        addCreditCardButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
    }
    
    private func setUpTableView() {
        creditCardTableView.delegate = self
        creditCardTableView.dataSource = self
        creditCardTableView.register(nibWithCellClass: CreditCardTableViewCell.self)
        creditCardTableView.separatorStyle = .none
    }
}

// Action
extension AddCreditCardViewController {
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    // When hold tapping Select Button
    @objc func buttonTouchDown(_ sender: UIButton) {
        addCreditCardButton.backgroundColor = Color.activeColor
        addCreditCardButton.layer.borderColor = Color.bgColor.cgColor
        addCreditCardButton.setAttributedTitle(NSAttributedString(string: "ADD CREDIT CARDS", attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(15)) as Any,
            .foregroundColor: Color.bgColor
        ]), for: .normal)
    }
    
    // When stop Select Button
    @objc func buttonTouchUp(_ sender: UIButton) {
        addCreditCardButton.backgroundColor = Color.bgColor
        addCreditCardButton.layer.borderColor = Color.activeColor.cgColor
        addCreditCardButton.setAttributedTitle(NSAttributedString(string: "ADD CREDIT CARDS", attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: Color.activeColor
        ]), for: .normal)
    }
    
    private func checkHaveCard() {
        hideOfAddCreditCardView(isHide: false)
    }
    
    private func hideOfAddCreditCardView(isHide: Bool) {
        creditCardImageView.isHidden = isHide
        dontHaveCardLabel.isHidden = isHide
        addAnyCardLabel.isHidden = isHide
        addCreditCardButton.isHidden = isHide
        creditCardTableView.isHidden = !isHide
    }
    
    @IBAction func addCreditCardButtonTouchUpInside(_ sender: Any) {
        hideOfAddCreditCardView(isHide: true)
    }
}

extension AddCreditCardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: CreditCardTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAtItem(indexPath: indexPath, isDefault: true)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow()
    }
}

extension AddCreditCardViewController: CreditCardTableViewCellDelegate {
    func tappingChosingDefaultPayment(view: CreditCardTableViewCell, typeCard: CreditCardType) {
        self.navigationController?.pushViewController(ScreenName.addYourPaymentMethos, animated: true)
    }
    
    
}
