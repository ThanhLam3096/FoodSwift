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
    
    
    @IBOutlet private weak var heightOfContentViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfImageMeal: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfNameMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfCustomInfoOrderMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfTopTableViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfBottomTableViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfTopOrangeButtonConstraint: NSLayoutConstraint!
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
        heightOfContentViewConstraint.constant = ScreenSize.scaleHeight(1750)
        heightImageMealConstraint.constant = ScreenSize.scaleHeight(280)
        widthOfCloseButtonConstraint.constant = ScreenSize.scaleWidth(34)
        closeButton.layer.cornerRadius = ScreenSize.scaleWidth(17)
        closeButton.clipsToBounds = true
        closeButton.backgroundColor = Color.blackColor.withAlphaComponent(0.5)
        widthOfPlusButtonConstraint.constant = ScreenSize.scaleWidth(54)
        widthOfMinusButtonConstraint.constant = ScreenSize.scaleWidth(54)
        minusButton.layer.cornerRadius = ScreenSize.scaleWidth(27)
        minusButton.clipsToBounds = true
        minusButton.backgroundColor = Color.cacuColor
        plusButton.layer.cornerRadius = ScreenSize.scaleWidth(27)
        plusButton.clipsToBounds = true
        plusButton.backgroundColor = Color.cacuColor
        heightOfTableView.constant = 2 * (ScreenSize.scaleHeight(52) * 8) + 2 * (ScreenSize.scaleHeight(48)) + 95
        widthOfCaculatorView.constant = ScreenSize.scaleWidth(171)
        heightOfCaculatorView.constant = ScreenSize.scaleHeight(54)
        addToOrderWidthViewConstraint.constant = ScreenSize.scaleWidth(335)
        addToOrderHeightViewConstraint.constant = ScreenSize.scaleHeight(48)
        
        spaceOfImageMeal.constant = ScreenSize.scaleHeight(24)
        spaceOfNameMealConstraint.constant = ScreenSize.scaleHeight(16)
        spaceOfCustomInfoOrderMealConstraint.constant = ScreenSize.scaleHeight(21)
        spaceOfTopTableViewConstraint.constant = ScreenSize.scaleHeight(34)
        spaceOfBottomTableViewConstraint.constant = ScreenSize.scaleHeight(34)
        spaceOfTopOrangeButtonConstraint.constant = ScreenSize.scaleHeight(34)
    }
    
    private func updateUIView() {
        closeButton.setTitle("", for: .normal)
        closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        
        minusButton.setTitle("", for: .normal)
        plusButton.setTitle("", for: .normal)
        setUpFontAndTextColorLabel(label: nameMealLabel, textFont: UIFont.fontYugothicUISemiBold(ofSize: 24) ?? UIFont.systemFont(ofSize: 24), textColor: Color.mainColor)
        setUpFontAndTextColorLabel(label: customInfoLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.mainColor)
        setUpFontAndTextColorLabel(label: priceMealLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.bodyTextColor)
        priceMealLabel.text = "\(viewModel.priceMeal)$"
        setUpFontAndTextColorLabel(label: firstNationMealLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.bodyTextColor)
        setUpFontAndTextColorLabel(label: secondNationLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.bodyTextColor)
        setUpFontAndTextColorLabel(label: categoryMealLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.bodyTextColor)
        setUpFontAndTextColorLabel(label: numberOfMealLabel, textFont: UIFont.fontYugothicUILight(ofSize: 20) ?? UIFont.systemFont(ofSize: 20), textColor: Color.mainColor)
        numberOfMealLabel.text = viewModel.updateNumberOfMeals(numberOfMeals: viewModel.numberOfMeals)
        addToOrderButtonView.setButtonTitle("ADD TO ORDER")
        customInfoLabel.sizeToFit()
        customInfoLabel.text = viewModel.updateOrderInfoMeal()
    }
    
    private func setUpFontAndTextColorLabel(label: UILabel, textFont: UIFont, textColor: UIColor) {
        label.font = textFont
        label.textColor = textColor
    }
    
    private func setUpTableView() {
        customMealTableView.register(nibWithCellClass: ChoiceCustomMeaTableViewCell.self)
        customMealTableView.register(nibWithCellClass: AddInstructionTableViewCell.self)
        customMealTableView.delegate = self
        customMealTableView.dataSource = self
        customMealTableView.separatorStyle = .none
        customMealTableView.isScrollEnabled = false
    }
    
    @objc private func closeScreen() {
        
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
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberSection = AddToOrderViewControllerViewModel.SectionType(rawValue: section) else { return 0 }
        return viewModel.numberOfItemsInSection(section: numberSection)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = AddToOrderViewControllerViewModel.SectionType(rawValue: indexPath.section)
        else { return UITableViewCell() }
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = Color.accentColor.withAlphaComponent(0.5)
        
        switch section {
        case .top, .bottom:
            let cell = tableView.dequeueReusableCell(withClass: ChoiceCustomMeaTableViewCell.self, for: indexPath)
           
            cell.selectedBackgroundView = selectedBackgroundView
            cell.viewModel = viewModel.cellForRowAtSection(indexPath: indexPath)
            if section == .top {
                if indexPath == viewModel.topCustomMealIndexPatch {
                    cell.inSideCircleView.isHidden = false
                } else {
                    cell.inSideCircleView.isHidden = true
                }
            } else {
                if indexPath == viewModel.bottomCustomMealIndexPatch {
                    cell.inSideCircleView.isHidden = false
                } else {
                    cell.inSideCircleView.isHidden = true
                }
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withClass: AddInstructionTableViewCell.self, for: indexPath)
            cell.selectedBackgroundView = selectedBackgroundView
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = AddToOrderViewControllerViewModel.SectionType(rawValue: indexPath.section) else { return }
        switch section {
        case .top:
            viewModel.topCustomMealIndexPatch = indexPath
            viewModel.infoTopCustomMeal = viewModel.listChoice[indexPath.row]
            customInfoLabel.text = viewModel.updateOrderInfoMeal()
            tableView.reloadData()
        case .bottom:
            viewModel.bottomCustomMealIndexPatch = indexPath
            viewModel.infoBottomCustomMeal = viewModel.listChoice[indexPath.row]
            customInfoLabel.text = viewModel.updateOrderInfoMeal()
            tableView.reloadData()
        default:
            alertAddIntructions { resultInput in                self.viewModel.addIntructionMealOrder = resultInput
                self.customInfoLabel.text = self.viewModel.updateOrderInfoMeal()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = AddToOrderViewControllerViewModel.SectionType(rawValue: indexPath.section)
        else { return 0 }
        
        switch section {
        case .top, .bottom:
            return ScreenSize.scaleHeight(52)
        default:
            return ScreenSize.scaleHeight(37)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTableViewMeal = HeaderChoiceMealTableView(frame: CGRect(x: 0, y: 0, width: Int(ScreenSize.scaleWidth(335)), height: Int(ScreenSize.scaleHeight(32))))
        switch section {
        case 0:
            headerTableViewMeal.viewModel = viewModel.cellForHeader(sectionType: .top)
            return headerTableViewMeal
        case 1:
            headerTableViewMeal.viewModel = viewModel.cellForHeader(sectionType: .bottom)
            return headerTableViewMeal
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let mySection = AddToOrderViewControllerViewModel.SectionType(rawValue: section) else { return 0 }
        switch mySection {
        case .top, .bottom:
            return ScreenSize.scaleHeight(48)
        default:
            return ScreenSize.scaleHeight(0)
        }
    }
}
