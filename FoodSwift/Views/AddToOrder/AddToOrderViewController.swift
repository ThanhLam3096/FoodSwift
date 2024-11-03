//
//  AddToOrderViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 31/10/24.
//

import UIKit

class AddToOrderViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var imageMealImageView: UIImageView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var customInfoLabel: UILabel!
    @IBOutlet private weak var priceMealLabel: UILabel!
    @IBOutlet private weak var firstNationMealLabel: UILabel!
    @IBOutlet private weak var secondNationLabel: UILabel!
    @IBOutlet private weak var categoryMealLabel: UILabel!
    @IBOutlet private weak var customMealTableView: UITableView!
    @IBOutlet private weak var numberOfMealLabel: UILabel!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    
    @IBOutlet private weak var widthOfPlusButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfMinusButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfCloseButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfCaculatorView: NSLayoutConstraint!
    @IBOutlet private weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet private weak var heightOfCaculatorView: NSLayoutConstraint!
    @IBOutlet private weak var addToOrderButtonView: OrangeButtonView!
    @IBOutlet private weak var addToOrderWidthViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var addToOrderHeightViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: AddToOrderViewControllerViewModel = AddToOrderViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func setUpUI() {
        setFrameForView()
        updateUIView()
        setUpTableView()
    }
    
    private func setFrameForView() {
        widthOfCloseButtonConstraint.constant = ScreenSize.scaleWidth(34)
        widthOfPlusButtonConstraint.constant = ScreenSize.scaleWidth(54)
        widthOfMinusButtonConstraint.constant = ScreenSize.scaleWidth(54)
        closeButton.layer.cornerRadius = ScreenSize.scaleWidth(17)
        closeButton.clipsToBounds = true
        closeButton.backgroundColor = Color.blackColor.withAlphaComponent(0.5)
        minusButton.layer.cornerRadius = ScreenSize.scaleWidth(27)
        minusButton.clipsToBounds = true
        minusButton.backgroundColor = Color.cacuColor
        plusButton.layer.cornerRadius = ScreenSize.scaleWidth(27)
        plusButton.clipsToBounds = true
        plusButton.backgroundColor = Color.cacuColor
        heightOfTableView.constant = ScreenSize.scaleHeight(928)
        widthOfCaculatorView.constant = ScreenSize.scaleWidth(171)
        heightOfCaculatorView.constant = ScreenSize.scaleHeight(54)
        addToOrderWidthViewConstraint.constant = ScreenSize.scaleWidth(335)
        addToOrderHeightViewConstraint.constant = ScreenSize.scaleHeight(48)
    }
    
    private func updateUIView() {
        closeButton.setTitle("", for: .normal)
        minusButton.setTitle("", for: .normal)
        plusButton.setTitle("", for: .normal)
        setUpFontAndTextColorLabel(label: nameMealLabel, textFont: UIFont.fontYugothicUISemiBold(ofSize: 24) ?? UIFont.systemFont(ofSize: 24), textColor: Color.mainColor)
        setUpFontAndTextColorLabel(label: customInfoLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.mainColor)
        setUpFontAndTextColorLabel(label: priceMealLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.bodyTextColor)
        setUpFontAndTextColorLabel(label: firstNationMealLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.bodyTextColor)
        setUpFontAndTextColorLabel(label: secondNationLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.bodyTextColor)
        setUpFontAndTextColorLabel(label: categoryMealLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.bodyTextColor)
        setUpFontAndTextColorLabel(label: numberOfMealLabel, textFont: UIFont.fontYugothicUILight(ofSize: 20) ?? UIFont.systemFont(ofSize: 20), textColor: Color.mainColor)
        numberOfMealLabel.text = viewModel.updateNumberOfMeals(numberOfMeals: viewModel.numberOfMeals)
        addToOrderButtonView.setButtonTitle("ADD TO ORDER")
    }
    
    private func setUpFontAndTextColorLabel(label: UILabel, textFont: UIFont, textColor: UIColor) {
        label.font = textFont
        label.textColor = textColor
    }
    
    private func setUpTableView() {
        customMealTableView.register(nibWithCellClass: ChoiceCustomMeaTableViewCell.self)
        customMealTableView.delegate = self
        customMealTableView.dataSource = self
        customMealTableView.separatorStyle = .none
    }
    
    @IBAction func minusButtonTouchUpInside(_ sender: Any) {
        viewModel.minusAction()
        numberOfMealLabel.text = viewModel.updateNumberOfMeals(numberOfMeals: viewModel.numberOfMeals)
    }
    
    @IBAction func plusButtonTouchUpInside(_ sender: Any) {
        viewModel.plusAction()
        numberOfMealLabel.text = viewModel.updateNumberOfMeals(numberOfMeals: viewModel.numberOfMeals)
    }
}

extension AddToOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ChoiceCustomMeaTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.viewModel = viewModel.cellForRowAtSection(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ScreenSize.scaleHeight(48)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTableViewMeal = HeaderChoiceMealTableView(frame: CGRect(x: 0, y: 0, width: Int(ScreenSize.scaleWidth(335)), height: Int(ScreenSize.scaleHeight(32))))
        headerTableViewMeal.updateTitleHeaderTableView(title: section == 0 ? "Choice of Top Cookie" : "Choice of Bottom Cookie")
        return headerTableViewMeal
    }
}
