//
//  DetailMealViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 21/10/24.
//

import UIKit

class DetailMealViewController: BaseViewController {

    @IBOutlet private weak var contentScrollView: UIScrollView!
    @IBOutlet private weak var navigationBarView: UIView!
    @IBOutlet private weak var infoDetailMealView: UIView!
    
    // MARK: - IBOutlet Label
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var priceMealLabel: UILabel!
    @IBOutlet private weak var firstNationLabel: UILabel!
    @IBOutlet private weak var secondNationLabel: UILabel!
    @IBOutlet private weak var typeFoodLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var numberVoteLabel: UILabel!
    @IBOutlet private weak var firstDeliveryLabel: UILabel!
    @IBOutlet private weak var secondDeliveryLabel: UILabel!
    @IBOutlet private weak var firstTimeDeliveryLabel: UILabel!
    @IBOutlet private weak var secondTimeDeliveryLabel: UILabel!
    @IBOutlet private weak var listFeatureLabel: UILabel!
    
    // MARK: - IBOutlet Button
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var shapeButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var takeAwayButton: UIButton!
    
    // MARK: - IBOutlet ListView
    @IBOutlet private weak var featureItemCollectionView: UICollectionView!
    @IBOutlet private weak var typeMealCollectionView: UICollectionView!
    @IBOutlet private weak var listMealForTypeTableView: UITableView!
    
    // MARK: - IBOutlet ImageView
    @IBOutlet private weak var imageMealImageView: UIImageView!
    
    // MARK: - Constraint
    @IBOutlet private weak var heightOfImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfImageMealConstraint: NSLayoutConstraint!
    
    // MARK: - Constraint InfoDetailMealView
    @IBOutlet private weak var topSpaceOfPriceMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfPriceMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfRatingMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfStarIconConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfActiveIconConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfActiveIconConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfDollarIconConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfFeeShipMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfInfoDetailMealViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingPriceLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingRatingLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfContentViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfViewImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfViewInfoConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfViewFeaturedItemConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfCollectionViewFeaturedItemConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfCollectionViewCategoryConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfTableViewViewMealConstraint: NSLayoutConstraint!
    
    // MARK: - Constraint Button Header
    @IBOutlet private weak var leadingSpaceConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: DetailMealViewModel = DetailMealViewModel()
    private var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        updateInfoView()
        if viewModel.listMealByCategory.isEmpty {
            loadAPIListMealByCategory(categoryName: viewModel.typeMeal[GlobalVariables.indexNumber])
        }
    }
    
    override func setUpUI() {
        setUpNavigation()
        setUpImageMeal()
        setUpFrameInfoDetailMeal()
        setUpLabel()
        setUpFrameButton()
        contentScrollView.delegate = self
        setUpTableView()
        updateCollectionView()
        setUpFrame()
    }
    
    override func setUpData() {
        loadAPIListMealByCategory(categoryName: viewModel.typeMeal[GlobalVariables.indexNumber])
    }
    
    private func setUpImageMeal() {
        heightOfImageMealConstraint.constant = ScreenSize.scaleHeight(280)
        botSpaceOfImageMealConstraint.constant = ScreenSize.scaleHeight(5)
    }
    
    private func setUpFrameInfoDetailMeal() {
        topSpaceOfPriceMealConstraint.constant = ScreenSize.scaleHeight(10)
        topSpaceOfPriceMealConstraint.constant = ScreenSize.scaleHeight(10)
        botSpaceOfRatingMealConstraint.constant = ScreenSize.scaleHeight(5)
        widthOfStarIconConstraint.constant = ScreenSize.scaleWidth(12)
        widthOfActiveIconConstraint.constant = ScreenSize.scaleWidth(18)
        heightOfActiveIconConstraint.constant = ScreenSize.scaleHeight(24)
        widthOfDollarIconConstraint.constant = ScreenSize.scaleWidth(17)
        botSpaceOfFeeShipMealConstraint.constant = ScreenSize.scaleHeight(10)
        botSpaceOfInfoDetailMealViewConstraint.constant = ScreenSize.scaleHeight(10)
        trailingPriceLabelConstraint.constant = ScreenSize.scaleWidth(10)
        trailingRatingLabelConstraint.constant = ScreenSize.scaleWidth(10)
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: nameMealLabel, labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(24)) ?? UIFont.systemFont(ofSize: 24), labelTextColor: UIColor(hex: "#000000"))
        setUpTextTitleFontTextColorOfLabel(label: priceMealLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: firstNationLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: secondNationLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: typeFoodLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: ratingLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: numberVoteLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: firstDeliveryLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: firstTimeDeliveryLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: secondDeliveryLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: secondTimeDeliveryLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.mainColor)
        
        setUpTextTitleFontTextColorOfLabel(label: listFeatureLabel,text: "Featured Items" ,labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(20)) ?? UIFont.systemFont(ofSize: 20), labelTextColor: Color.mainColor)
    }
    
    private func setUpFrameButton() {
        takeAwayButton.setAttributedTitle(NSAttributedString(string: "TAKE AWAY", attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: Color.activeColor,
            .backgroundColor: Color.bgColor
        ]), for: .normal)
        takeAwayButton.layer.cornerRadius = 6
        takeAwayButton.layer.borderWidth = 1
        takeAwayButton.layer.borderColor = CGColor.hexStringToCGColor(hex: "#EEA734")
        takeAwayButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        takeAwayButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
        takeAwayButton.widthAnchor.constraint(equalToConstant: ScreenSize.scaleWidth(115)).isActive = true
        takeAwayButton.heightAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(42)).isActive = true
    }
    
    private func setUpFrame() {
        heightOfViewImageConstraint.constant = ScreenSize.scaleHeight(280)
        heightOfViewInfoConstraint.constant = ScreenSize.scaleHeight(165)
        heightOfViewFeaturedItemConstraint.constant = ScreenSize.scaleHeight(230)
        heightOfCollectionViewFeaturedItemConstraint.constant = ScreenSize.scaleHeight(198)
        heightOfCollectionViewCategoryConstraint.constant = ScreenSize.scaleHeight(32)
        heightOfTableViewViewMealConstraint.constant = ScreenSize.scaleHeight(500)
        
        heightOfContentViewConstraint.constant = heightOfViewImageConstraint.constant + heightOfViewInfoConstraint.constant + heightOfViewFeaturedItemConstraint.constant + heightOfCollectionViewCategoryConstraint.constant + heightOfTableViewViewMealConstraint.constant + 80
    }
    
    // Đổi màu nền khi nhấn giữ
    @objc func buttonTouchDown() {
        takeAwayButton.setAttributedTitle(NSAttributedString(string: "TAKE AWAY", attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: UIColor.white,
            .backgroundColor: Color.activeColor
        ]), for: .normal)
        takeAwayButton.backgroundColor = Color.activeColor
    }
    
    // Khôi phục màu nền ban đầu khi thả tay
    @objc func buttonTouchUp() {
        takeAwayButton.setAttributedTitle(NSAttributedString(string: "TAKE AWAY", attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: Color.activeColor,
            .backgroundColor: UIColor.white
        ]), for: .normal)
        takeAwayButton.backgroundColor = .white
    }
    
    
    @IBAction func takeAwayTouchUpInside(_ sender: Any) {
        guard let meal = viewModel.meal else { return }
        let vcAddToOrder = ScreenName.addToOrder
        vcAddToOrder.viewModel = AddToOrderViewControllerViewModel(meal: meal)
        navigationController?.pushViewController(ScreenName.addToOrder, animated: true)
    }
    
    private func setUpNavigation() {
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationBarView.layer.cornerRadius = 6
        navigationBarView.backgroundColor = Color.activeColor.withAlphaComponent(0.8)
        leadingSpaceConstraint.constant = ScreenSize.scaleWidth(20)
        trailingSpaceConstraint.constant = ScreenSize.scaleWidth(20)
    }
    
    private func updateInfoView() {
        guard let meal = viewModel.meal else { return }
        imageMealImageView.sd_setImage(with: URL(string: meal.image))
        nameMealLabel.text = meal.name
        priceMealLabel.text = "\(displayNumber(meal.price))$"
        firstNationLabel.text = meal.nation1
        secondNationLabel.text = meal.nation2
        typeFoodLabel.text = meal.typeFood
        ratingLabel.text = meal.rating
        numberVoteLabel.text = "\(meal.totalVote)+"
        firstDeliveryLabel.text = meal.feeShip == 0 ? "Free" : "\(displayNumber(meal.feeShip))"
        secondDeliveryLabel.text = meal.feeShip == 0 ? "Delivery" : "Dollars"
        firstTimeDeliveryLabel.text = meal.time.replacingOccurrences(of: "min", with: "")
        secondTimeDeliveryLabel.text = "Minutes"
    }
    
    private func setUpTableView() {
        listMealForTypeTableView.delegate = self
        listMealForTypeTableView.dataSource = self
        listMealForTypeTableView.register(nibWithCellClass: ListMealForTypeTableViewCell.self)
    }
    
    private func updateCollectionView() {
        setUpCollectionView(collectionView: featureItemCollectionView)
        featureItemCollectionView.register(nibWithCellClass: FeaturedItemCollectionViewCell.self)
        
        setUpCollectionView(collectionView: typeMealCollectionView)
        typeMealCollectionView.register(nibWithCellClass: TypeMealCollectionViewCell.self)
    }
    
    private func setUpCollectionView(collectionView: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ScreenSize.scaleWidth(20)
        
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func updateDataWhenTappingMealByCategory() {
        guard let mealDB = viewModel.mealDetail else { return }
        
        viewModel.meal?.image = mealDB.imageMeal
        viewModel.meal?.name = mealDB.nameMeal
        viewModel.meal?.typeFood = mealDB.category
        imageMealImageView.sd_setImage(with: URL(string: mealDB.imageMeal))
        nameMealLabel.text = mealDB.nameMeal
        typeFoodLabel.text = mealDB.category
    }
    
    private func loadAPIListMealByCategory(categoryName: String) {
        HUD.show()
        viewModel.getAPIListMealByCategory(categoryName: categoryName) { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                HUD.dismiss()
                this.reloadDataTableView()
            } else {
                HUD.dismiss()
                this.showAlert(message: msg)
            }
        }
    }
    
    private func loadAPIDetailMeal(idMeal: String) {
        HUD.show()
        viewModel.getAPIDetailMealDB(idMeal: idMeal) { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                HUD.dismiss()
                this.updateDataWhenTappingMealByCategory()
                this.contentScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            } else {
                HUD.dismiss()
                this.showAlert(message: msg)
            }
        }
    }
    
    private func reloadDataTableView() {
        guard isViewLoaded else { return }
        listMealForTypeTableView.reloadData()
    }

    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func checkImageFullSizeButtonTouchUpInside(_ sender: Any) {
        guard let urlImage = viewModel.meal?.image else {return}
        let imageMealModalVC = ImageMealModalViewController(nibName: "ImageMealModalViewController", bundle: nil)
        imageMealModalVC.modalTransitionStyle = .coverVertical
        imageMealModalVC.modalPresentationStyle = .pageSheet
        imageMealModalVC.viewModel = ImageMealModalViewModel(imageString: urlImage)
        present(imageMealModalVC, animated: true, completion: nil)
    }
}

extension DetailMealViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSectionsTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ListMealForTypeTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAtSectionMealForCategory(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadAPIDetailMeal(idMeal: viewModel.listMealByCategory[indexPath.row].idMeal)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForCellTableView()
    }
}

extension DetailMealViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension DetailMealViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featureItemCollectionView {
            return viewModel.numberOfSectionsCollectionView(type: .featuredItem)
        } else {
            return viewModel.numberOfSectionsCollectionView(type: .typeFood)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featureItemCollectionView {
            let cell = collectionView.dequeueReusableCell(withClass: FeaturedItemCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtSectionFeaturedItem(indexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: TypeMealCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtSectionTypeMeal(indexPath: indexPath)            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == typeMealCollectionView {
            if let previousIndexPath = GlobalVariables.selectedIndexPath {
                let previousCell = typeMealCollectionView.cellForItem(at: previousIndexPath) as? TypeMealCollectionViewCell
                previousCell?.typeFoodLabel.textColor = Color.bodyTextColor
            }
            
            // Cập nhật ô được chọn
            GlobalVariables.selectedIndexPath = indexPath
            
            // Đổi màu ô hiện tại
            let currentCell = typeMealCollectionView.cellForItem(at: indexPath) as? TypeMealCollectionViewCell
            currentCell?.typeFoodLabel.textColor = Color.yellowColor
            GlobalVariables.indexNumber = indexPath.row
            loadAPIListMealByCategory(categoryName: viewModel.typeMeal[indexPath.row])
        } else {
            print("abcd")
        }
    }
}

extension DetailMealViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featureItemCollectionView {
            return CGSize(width: ScreenSize.scaleWidth(140), height: ScreenSize.scaleHeight(198))
        } else {
            let text = viewModel.typeMeal[indexPath.item]
            let label = UILabel()
            label.text = text
            label.numberOfLines = 1
            label.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(24))
            label.textColor = Color.bodyTextColor
            
            // Calculate the size that fits the label's text
            let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.frame.height))
            return CGSize(width: ScreenSize.scaleWidth(size.width + 20), height: collectionView.frame.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == featureItemCollectionView {
            return (14 / 375) * ScreenSize.screenWidth
        } else {
            return (23 / 375) * ScreenSize.screenWidth
        }
    }
}

extension DetailMealViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        
        if currentOffset <= 0 {
            // View at top - hiện view
            UIView.animate(withDuration: 0.3) {
                self.navigationBarView.layer.transform = CATransform3DIdentity
                self.navigationBarView.alpha = 1
            }
        } else if currentOffset > lastContentOffset {
            // Scroll Down - hide view
            UIView.animate(withDuration: 0.3) {
                self.navigationBarView.layer.transform = CATransform3DIdentity
                self.navigationBarView.alpha = 0
            }
        } else if currentOffset < lastContentOffset {
            // Scroll Up - Show view
            UIView.animate(withDuration: 0.3) {
                self.navigationBarView.layer.transform = CATransform3DIdentity
                self.navigationBarView.alpha = 1
            }
        }
        // Cập nhật lại lastContentOffset
        lastContentOffset = currentOffset
    }
}
