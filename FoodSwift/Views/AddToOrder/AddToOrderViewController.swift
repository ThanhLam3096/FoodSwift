//
//  AddToOrderViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 31/10/24.
//

import UIKit

class AddToOrderViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var scrollView: UIScrollView!
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
    
    // MARK: -NSLayoutConstraint
    @IBOutlet private weak var heightOfContentViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfImageMeal: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfNameMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfNameMealConstraint: NSLayoutConstraint!
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
    var popUp: PopUpView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if let scrollView = self.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
            scrollView.setContentOffset(.zero, animated: false)
        }
        updateUIView()
        resetStatusSelect()
    }

    override func setUpUI() {
        setFrameForView()
        updateUIView()
        setUpTableView()
    }
    
    private func setFrameForView() {
        heightOfContentViewConstraint.constant = ScreenSize.scaleHeight(1750)
        
        leadingSpaceOfNameMealConstraint.constant = ScreenSize.scaleWidth(20)
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
        botSpaceOfNameMealConstraint.constant = ScreenSize.scaleHeight(16)
        spaceOfCustomInfoOrderMealConstraint.constant = ScreenSize.scaleHeight(21)
        spaceOfTopTableViewConstraint.constant = ScreenSize.scaleHeight(34)
        spaceOfBottomTableViewConstraint.constant = ScreenSize.scaleHeight(34)
        spaceOfTopOrangeButtonConstraint.constant = ScreenSize.scaleHeight(34)
    }
    
    private func updateUIView() {
        guard let meal = viewModel.meal else {return}
        imageMealImageView.sd_setImage(with: URL(string: meal.image))
        closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        updateLabel(meal: meal)
        minusButton.setTitle("", for: .normal)
        plusButton.setTitle("", for: .normal)
        updatePriceOrangeButton(price: viewModel.totalOfPriceMeal())
        customInfoLabel.sizeToFit()
        customInfoLabel.text = viewModel.updateOrderInfoMeal()
    }
    
    private func resetStatusSelect() {
        viewModel.topCustomMealIndexPatch = nil
        viewModel.bottomCustomMealIndexPatch = nil
        viewModel.infoTopCustomMeal = ""
        viewModel.infoBottomCustomMeal = ""
        viewModel.addIntructionMealOrder = ""
        customInfoLabel.text = viewModel.updateOrderInfoMeal()
        customMealTableView.reloadData()
    }
    
    private func updateLabel(meal: Meal) {
        setUpTextTitleFontTextColorOfLabel(label: nameMealLabel, text: meal.name , labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(24)) ?? UIFont.systemFont(ofSize: 24), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: customInfoLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: priceMealLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        priceMealLabel.text = "\(displayNumber(meal.price))$"
        setUpTextTitleFontTextColorOfLabel(label: firstNationMealLabel, text: meal.nation1, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: secondNationLabel, text: meal.nation2, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: categoryMealLabel, text: meal.typeFood, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: numberOfMealLabel, text: viewModel.updateNumberOfMeals(numberOfMeals: viewModel.numberOfMeals),  labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(20)) ?? UIFont.systemFont(ofSize: 20), labelTextColor: Color.mainColor)
    }
    
    private func updatePriceOrangeButton(price: Double) {
        addToOrderButtonView.delegate = self
        addToOrderButtonView.viewModel = OrangeButtonViewModel(title: "ADD TO ORDER", totalPriceMeal: price)
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
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func minusButtonTouchUpInside(_ sender: Any) {
        viewModel.minusAction()
        numberOfMealLabel.text = viewModel.updateNumberOfMeals(numberOfMeals: viewModel.numberOfMeals)
        updatePriceOrangeButton(price: viewModel.totalOfPriceMeal())
    }
    
    @IBAction func plusButtonTouchUpInside(_ sender: Any) {
        viewModel.plusAction()
        numberOfMealLabel.text = viewModel.updateNumberOfMeals(numberOfMeals: viewModel.numberOfMeals)
        updatePriceOrangeButton(price: viewModel.totalOfPriceMeal())
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
        
        switch section {
        case .top, .bottom:
            let cell = tableView.dequeueReusableCell(withClass: ChoiceCustomMeaTableViewCell.self, for: indexPath)
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = Color.accentColor.withAlphaComponent(0.5)
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
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = .clear
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
            alertAddIntructions { resultInput in                
                self.viewModel.addIntructionMealOrder = resultInput
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

extension AddToOrderViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        guard let meal = viewModel.meal else { return }
        addMealToOrder()
    }
}

extension AddToOrderViewController {
    private func addMealToOrder() {
        guard let meal = viewModel.meal else { return }
        Task {
                do {
                    HUD.show()
                    let success = try await viewModel.addOrderMealFireStore(
                        meal: meal,
                        infoTopCustomMeal: viewModel.infoTopCustomMeal,
                        infoBottomCustomMeal: viewModel.infoBottomCustomMeal,
                        totalMealOrder: viewModel.numberOfMeals
                    )
                    
                    DispatchQueue.main.async {
                        HUD.dismiss()
                        if success {
                            self.showPopUp(title: "Order Success", isSuccess: success)
                        }
                    }
                } catch let error as OrderError {
                    DispatchQueue.main.async {
                        HUD.dismiss()
                        self.showPopUp(title: error.message, isSuccess: false)
                    }
                } catch {
                    DispatchQueue.main.async {
                        HUD.dismiss()
                        self.showPopUp(title: "It's Something happen", isSuccess: false)
                    }
                }
            }
        
//        viewModel.addOrderMealFireStore(meal: meal, infoTopCustomMeal: infoTopCustomMeal, infoBottomCustomMeal: infoBottomCustomMeal, totalMealOrder: total) { [weak self] (done, msg) in
//            guard let strongSelf = self else { return }
//            if done {
//                strongSelf.pushFromBottom(to: ScreenName.yourOrder, from: strongSelf)
//            } else {
//                strongSelf.showPopUp(title: msg, isSuccess: done)
//            }
//        }
    }
}

// Popup
extension AddToOrderViewController: PopUpViewDelegate {
    private func showPopUp(title: String, isSuccess: Bool) {
        // MARK: - Setup PopUp
        popUp = PopUpView(frame: view.frame, inView: self)
        popUp?.delegate = self
        popUp?.viewModel = PopUpViewVM(
            title: title,
            isSuccesPopup: isSuccess
        )
        
        // MARK: - Add to view hierarchy with animation
        addPopUpToViewHierarchy()
        animatePopUpPresentation()
    }
    
    func addPopUpToViewHierarchy() {
        guard let popUp = popUp else { return }
        
        // Set initial transform
        let initialTransform = CGAffineTransform(a: Constants.initialScale, b: Constants.initialScale, c: Constants.initialScale, d: Constants.initialScale, tx: Constants.initialScale, ty: Constants.initialScale)
        popUp.transform = initialTransform
        
        // Add to view
        view.addSubview(popUp)
    }
    
    func animatePopUpPresentation() {
        UIView.animate(
            withDuration: Constants.animationDuration,
            delay: 0,
            options: .curveEaseOut
        ) { [weak self] in
            self?.popUp?.transform = .identity
        }
    }
    
    func didTappingButton(view: PopUpView, isSuccess: Bool) {
        self.popUp?.removeFromSuperview()
        if isSuccess {
            self.pushFromBottom(to: ScreenName.yourOrder, from: self)
        } else {
            return
        }
        
    }
}
