//
//  YourOrderViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/11/24.
//

import UIKit

final class YourOrderViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var listOrderMealTableView: UITableView!
    
    @IBOutlet private weak var feeMealStackView: UIStackView!
    @IBOutlet private weak var subTotalLabel: UILabel!
    @IBOutlet private weak var valueSubTotalLabel: UILabel!
    @IBOutlet private weak var deliveryLabel: UILabel!
    @IBOutlet private weak var feeDeliveryLabel: UILabel!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    
    @IBOutlet private weak var discountPromotionStackView: UIStackView!
    @IBOutlet private weak var addMoreItemStackView: UIStackView!
    @IBOutlet private weak var promoStackView: UIStackView!
    @IBOutlet private weak var addMoreItemsLabel: UILabel!
    @IBOutlet private weak var promoCodeLabel: UILabel!
    @IBOutlet private weak var rightArrowAddMoreItemsButton: UIButton!
    @IBOutlet private weak var promoButton: UIButton!
    @IBOutlet private weak var firstLineView: UIView!
    @IBOutlet private weak var secondLineView: UIView!
    @IBOutlet private weak var continueButtonView: OrangeButtonView!
    
    // MARK: - Constraint
    @IBOutlet private weak var heightOfTableViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfTableView: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfTableView: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceTableViewWithContentViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfTotalFeeStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfBottomTableViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfContentViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceBottomOfFeeMealStackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfPromoStackViewConstaint: NSLayoutConstraint!
    @IBOutlet weak var widthOfRightArrowButtonStraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfContinueButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfTopContinueButtonConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: YourOrderViewControllerVM = YourOrderViewControllerVM()
    var popUp: PopUpView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        fetchDataMealOrder()
        viewModel.updateYourOrderTotalPrice()
    }
    
    override func setUpUI() {
        setUpNavigation()
        firstLineView.backgroundColor = Color.bodyTextColor.withAlphaComponent(0.3)
        secondLineView.backgroundColor = Color.bodyTextColor.withAlphaComponent(0.3)
        continueButtonView.viewModel = OrangeButtonViewModel(title: "CONTINUE", totalPriceMeal: viewModel.yourOrderTotalPrice)
        continueButtonView.delegate = self
    }

    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Your Order"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16))
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
        let leftImage = UIImageView(image: UIImage(named: "black_close"))
        leftImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftImage.widthAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(24)),
            leftImage.heightAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(24))
        ])
        
        let backItem = UIBarButtonItem(image: leftImage.image, style: .plain, target: self, action: #selector(closeScreen))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpLabel() {
        setLabelFontAndTextColor(label: subTotalLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        setLabelFontAndTextColor(label: valueSubTotalLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        setLabelFontAndTextColor(label: deliveryLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        setLabelFontAndTextColor(label: feeDeliveryLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        setLabelFontAndTextColor(label: totalPriceLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.accentColor)
        setLabelFontAndTextColor(label: addMoreItemsLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.accentColor)
        setLabelFontAndTextColor(label: promoCodeLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)  
        
        valueSubTotalLabel.text = "Dollars$\(displayNumber(viewModel.totalPrice))"
        feeDeliveryLabel.text = "$\(displayNumber(viewModel.feeShip))"
        totalPriceLabel.text = "Dollars$\(displayNumber(viewModel.yourOrderTotalPrice))"
    }
    
    private func setLabelFontAndTextColor(label: UILabel, labelFont: UIFont, labelTextColor: UIColor) {
        label.font = labelFont
        label.textColor = labelTextColor
    }

    private func setUpTableView() {
        listOrderMealTableView.delegate = self
        listOrderMealTableView.dataSource = self
        listOrderMealTableView.register(nibWithCellClass: ListTableOrderMealTableViewCell.self)
        listOrderMealTableView.separatorStyle = .none
        let numberOfItems = CGFloat(viewModel.listOrderMeals.count)
        heightOfTableViewConstraint.constant = ScreenSize.scaleHeight(140) * numberOfItems
        topSpaceTableViewWithContentViewConstraint.constant = ScreenSize.scaleWidth(24)
        leadingSpaceOfTableView.constant = ScreenSize.scaleWidth(20)
        trailingSpaceOfTableView.constant = ScreenSize.scaleWidth(20)
        listOrderMealTableView.reloadData()
    }
    
    private func setUpFrameView() {
        heightOfTotalFeeStackViewConstraint.constant = ScreenSize.scaleHeight(96)
        spaceOfBottomTableViewConstraint.constant = ScreenSize.scaleHeight(20)
        feeMealStackView.spacing = ScreenSize.scaleHeight(15)
        
        discountPromotionStackView.spacing = ScreenSize.scaleHeight(10)
        heightOfPromoStackViewConstaint.constant = ScreenSize.scaleHeight(98)
        widthOfRightArrowButtonStraint.constant = ScreenSize.scaleWidth(24)
        addMoreItemStackView.spacing = ScreenSize.scaleHeight(19)
        promoStackView.spacing = ScreenSize.scaleHeight(19)
        
        heightOfContinueButtonConstraint.constant = ScreenSize.scaleHeight(48)
        spaceOfTopContinueButtonConstraint.constant = ScreenSize.scaleHeight(47)
        
        let spaceOfView = spaceOfBottomTableViewConstraint.constant + spaceOfTopContinueButtonConstraint.constant + topSpaceTableViewWithContentViewConstraint.constant
        
        heightOfContentViewConstraint.constant = heightOfTotalFeeStackViewConstraint.constant  + heightOfTableViewConstraint.constant + heightOfPromoStackViewConstaint.constant + heightOfContinueButtonConstraint.constant + spaceOfView + 50
    }
    
    
    @objc func closeScreen() {
        viewModel.listOrderMeals.removeAll()
        popToPreviousScreen(from: self)
    }
}

extension YourOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ListTableOrderMealTableViewCell.self, for: indexPath)
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = selectedBackgroundView
        cell.viewModel = viewModel.cellForRowAtSection(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScreenSize.scaleHeight(140)
    }
}

extension YourOrderViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
//        navigationController?.pushViewController(ScreenName.addYourPaymentMethos, animated: true)
        guard let navigationController = self.navigationController else { return }
        navigationController.popToRootViewController(animated: true)
        
        // Đợi animation hoàn thành rồi set selected index
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let tabBarController = navigationController.viewControllers.first as? FoodTabBarViewController {
                tabBarController.selectedIndex = 2
            }
        }
    }
}

// Fetch Meal Order
extension YourOrderViewController {
    
//    private func fetchDataMealOrder() {
//        HUD.show()
//        viewModel.getDataOrderMealByEmail { [weak self] success, message in
//            guard let strongSelf = self else { return }
//            if success {
//                HUD.dismiss()
//                strongSelf.setUpTableView()
//                strongSelf.setUpFrameView()
//            } else {
//                HUD.dismiss()
//                strongSelf.showPopUp(title: message, isSuccess: success)
//            }
//        }
//    }
    
    private func fetchDataMealOrder() {
        HUD.show()
        Task {
            let result = await viewModel.getDataOrderMealByEmail()
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                HUD.dismiss()
                
                switch result {
                case .success:
                    self.viewModel.updateYourOrderTotalPrice()
                    self.setUpTableView()
                    self.setUpFrameView()
                    self.setUpLabel()
                    
                case .failure(let error):
                    self.showPopUp(title: error.message, isSuccess: false)
                }
            }
        }
    }
}

// Popup
extension YourOrderViewController: PopUpViewDelegate {
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
        // Xóa popup
        self.popUp?.removeFromSuperview()
        
        if isSuccess {
            guard let navigationController = self.navigationController else { return }
            navigationController.popToRootViewController(animated: true)
            
            // Đợi animation hoàn thành rồi set selected index
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let tabBarController = navigationController.viewControllers.first as? FoodTabBarViewController {
                    tabBarController.selectedIndex = 2
                }
            }
        }
    }
}
