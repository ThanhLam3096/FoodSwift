//
//  SearchViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 4/10/24.
//

import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var searchTitleLabel: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var nationButton: UIButton!
    @IBOutlet private weak var categoryButton: UIButton!
    @IBOutlet private weak var resultSearchCollectionView: UICollectionView!
    @IBOutlet private weak var resultSearchEmptyView: UIView!
    @IBOutlet private weak var emptySearchTitleLabel: UILabel!
    
    @IBOutlet private weak var headerView2: UIView!
    @IBOutlet private weak var searchImageHeaderView2: UIImageView!
    @IBOutlet private weak var searchButtonHeaderView2: UIButton!
    @IBOutlet private weak var searchTitleLabelHeaderView2: UILabel!
    @IBOutlet private weak var nationAndCategoryCollectionView: UICollectionView!
    
    // MARK: - @IBOutlet RecentSearchView
    @IBOutlet private weak var recentSearchView: UIView!
    @IBOutlet private weak var recentSearchImageView: UIImageView!
    @IBOutlet private weak var recentSearchButton: UIButton!
    @IBOutlet private weak var cancelRecentSearchLabel: UILabel!
    @IBOutlet private weak var cancelRecentSearchButton: UIButton!
    @IBOutlet private weak var recentSearchTextField: UITextField!
    @IBOutlet private weak var recentSearchTableView: UITableView!
    
    // MARK: - WidthFrameViewConstraint
    
    // MARK: - HeightFrameViewConstraint
    @IBOutlet weak var heightOfHeaderViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfSearchViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfIconSearchConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfFilterButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfSearchHeaderView2Constraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfSearchHeaderView2ButtonConstraint: NSLayoutConstraint!
    
    // MARK: - TopAndBotFrameConstraint
    @IBOutlet private weak var topSpaceSearchTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceSearchViewLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceResultSearchCollectionViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceSearchHeaderView2ButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topSpaceOfFilterButtonWithHeaderViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var topSpaceOfFilterButtonWithHeaderView2Constraint: NSLayoutConstraint!
    
    // MARK: - LeadingTrailingFrameConstraint
    @IBOutlet private weak var leadingSpaceHeaderViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceHeaderViewConstraint: NSLayoutConstraint!
    
    // MARK: -NSLayoutConstraint RecentSearchView
    @IBOutlet weak var topSpaceOfSearchRecentButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthOfSearchRecentButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthOfCancelSearchRecentButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfCancelSearchRecentButtonConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: SearchViewControllerVM = SearchViewControllerVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func setUpUI() {
        setUpLabel()
        setUpFilterButton()
        setUpTextField()
        setUpCollectionView()
        setUpHeightFrameView()
        setUpTopBotFrameView()
        setUpLeadingTrailingFrameView()
        actionTappingHideKeyBoard()
        setUpRecentSearchView()
    }
    
    override func setUpData() {
        viewModel.getToHitorySearch()
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: searchTitleLabel, text: "Search", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(28)) ?? UIFont.systemFont(ofSize: 28), labelTextColor: Color.mainColor)
        
        setUpTextTitleFontTextColorOfLabel(label: emptySearchTitleLabel, text: "Enter Your Name Meal For Search...", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(30)) ?? UIFont.systemFont(ofSize: 28), labelTextColor: Color.accentColor)
        emptySearchTitleLabel.numberOfLines = 0
        
        setUpTextTitleFontTextColorOfLabel(label: searchTitleLabelHeaderView2, text: "Search", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(28)) ?? UIFont.systemFont(ofSize: 28), labelTextColor: Color.mainColor)
    }
    
    private func setUpFilterButton() {
        filterButton.setAttributedTitle(NSAttributedString(string: "Filter", attributes: [
            .font: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) as Any,
            .foregroundColor: Color.mainColor,
        ]), for: .normal)
        nationButton.setAttributedTitle(NSAttributedString(string: "Nation", attributes: [
            .font: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) as Any,
            .foregroundColor: Color.accentColor,
        ]), for: .normal)
        categoryButton.setAttributedTitle(NSAttributedString(string: "Category", attributes: [
            .font: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) as Any,
            .foregroundColor: Color.activeColor,
        ]), for: .normal)
    }
    
    private func setUpTextField() {
        searchTextField.delegate = self
        searchTextField.borderStyle = .none
        searchTextField.font = UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16))
        searchTextField.textColor = Color.bodyTextColor
        searchTextField.placeholder = "Search on foodly..."
    }
    
    private func setUpCollectionView() {
        resultSearchCollectionView.delegate = self
        resultSearchCollectionView.dataSource = self
        resultSearchCollectionView.register(nibWithCellClass: SearchCollectionViewCell.self)
        
        nationAndCategoryCollectionView.delegate = self
        nationAndCategoryCollectionView.dataSource = self
        nationAndCategoryCollectionView.register(nibWithCellClass: NationAndCategoryCollectionViewCell.self)
    }
    
    private func setUpHeightFrameView() {
        heightOfHeaderViewConstraint.constant = ScreenSize.scaleHeight(156)
        heightOfSearchViewConstraint.constant = ScreenSize.scaleHeight(48)
        heightOfIconSearchConstraint.constant = ScreenSize.scaleHeight(14)
        heightOfFilterButtonConstraint.constant = ScreenSize.scaleHeight(35)
        heightOfSearchHeaderView2ButtonConstraint.constant = ScreenSize.scaleHeight(17)
        heightOfSearchHeaderView2Constraint.constant = ScreenSize.scaleHeight(54)
    }
    
    private func setUpTopBotFrameView() {
        topSpaceSearchTitleLabelConstraint.constant = ScreenSize.scaleHeight(68)
        topSpaceSearchViewLabelConstraint.constant = ScreenSize.scaleHeight(10)
        topSpaceResultSearchCollectionViewConstraint.constant = ScreenSize.scaleHeight(20)
        topSpaceSearchHeaderView2ButtonConstraint.constant = ScreenSize.scaleHeight(20)
        topSpaceOfFilterButtonWithHeaderViewConstraint.constant = ScreenSize.scaleHeight(20)
        topSpaceOfFilterButtonWithHeaderView2Constraint.constant = ScreenSize.scaleHeight(20)
    }
    
    private func setUpLeadingTrailingFrameView() {
        leadingSpaceHeaderViewConstraint.constant = ScreenSize.scaleWidth(20)
        trailingSpaceHeaderViewConstraint.constant = ScreenSize.scaleWidth(20)
    }
    
    private func setUpRecentSearchView() {
        recentSearchView.isHidden = true
        recentSearchImageView.tintColor = Color.tabBarColor
        recentSearchTextField.borderStyle = .none
        recentSearchTextField.placeholder = "Search"
        recentSearchTextField.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(24))
        recentSearchTextField.textColor = Color.bodyTextColor
        recentSearchTextField.tintColor = Color.accentColor
        recentSearchTextField.delegate = self
        
        setUpTextTitleFontTextColorOfLabel(label: cancelRecentSearchLabel, text: "Cancel", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        cancelRecentSearchLabel.textAlignment = .right
        setUpFrameRecentSearchView()
        setUpRecentTableView()
    }
    
    private func setUpRecentTableView() {
        recentSearchTableView.delegate = self
        recentSearchTableView.dataSource = self
        recentSearchTableView.separatorStyle = .none
        recentSearchTableView.sectionHeaderHeight = 70
        recentSearchTableView.register(nibWithCellClass: SearchRecentTableViewCell.self)
        recentSearchTableView.register(headerFooterViewClassWith: SearchRecentHeaderTableView.self)
    }
    
    private func setUpFrameRecentSearchView() {
        topSpaceOfSearchRecentButtonConstraint.constant = ScreenSize.scaleHeight(10)
        widthOfSearchRecentButtonConstraint.constant = ScreenSize.scaleHeight(34)
        widthOfCancelSearchRecentButtonConstraint.constant = ScreenSize.scaleWidth(51)
        heightOfCancelSearchRecentButtonConstraint.constant = ScreenSize.scaleHeight(20)
    }
    
    
    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        recentSearchTextField.text = nil
        UIView.animate(withDuration: 0.5) {
            self.recentSearchView.isHidden = true
        }
    }
    
    @IBAction func filterButtonTouchUpInside(_ sender: Any) {
        let filterVC = FilterViewController(nibName: "FilterViewController", bundle: nil)
        filterVC.modalTransitionStyle = .coverVertical
        filterVC.modalPresentationStyle = .pageSheet
        filterVC.viewModel = FilterViewControllerVM(filterByNation: viewModel.flagsNationMeal, filterByCategory: viewModel.dishTypeMeal)
        let navController = UINavigationController(rootViewController: filterVC)
        present(navController, animated: true, completion: nil)
    }
    
    @IBAction func nationButtonTouchUpInside(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.headerView.isHidden = true
            self.headerView2.isHidden = false
            self.topSpaceOfFilterButtonWithHeaderViewConstraint.priority = UILayoutPriority(750)
            self.topSpaceOfFilterButtonWithHeaderView2Constraint.priority = UILayoutPriority(1000)
        }
        viewModel.isNation = true
        loadAPINationMeal()
        resultSearchEmptyView.isHidden = true
        resultSearchCollectionView.isHidden = true
        nationAndCategoryCollectionView.isHidden = false
    }
    
    @IBAction func categoryButtonTouchUpInside(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.headerView.isHidden = true
            self.headerView2.isHidden = false
            self.topSpaceOfFilterButtonWithHeaderViewConstraint.priority = UILayoutPriority(750)
            self.topSpaceOfFilterButtonWithHeaderView2Constraint.priority = UILayoutPriority(1000)
        }
        viewModel.isNation = false
        loadAPICategoryMeal()
        resultSearchEmptyView.isHidden = true
        resultSearchCollectionView.isHidden = true
        nationAndCategoryCollectionView.isHidden = false
    }
    
    @IBAction func searchNameMealTouchUpInside(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.headerView.isHidden = false
            self.headerView2.isHidden = true
            self.topSpaceOfFilterButtonWithHeaderViewConstraint.priority = UILayoutPriority(1000)
            self.topSpaceOfFilterButtonWithHeaderView2Constraint.priority = UILayoutPriority(750)
        }
        nationAndCategoryCollectionView.isHidden = true
        if viewModel.listResultSearchMealByName.isEmpty {
            resultSearchEmptyView.isHidden = false
            resultSearchCollectionView.isHidden = true
        } else {
            resultSearchEmptyView.isHidden = true
            resultSearchCollectionView.isHidden = false
        }
    }
    
    private func showDataSearchByNationAndCategory() {
        nationAndCategoryCollectionView.isHidden = true
        resultSearchEmptyView.isHidden = true
        resultSearchCollectionView.isHidden = false
    }
    
    private func tappingItemDetail(idMeal: String) {
        loadAPIDetailMeal(idMeal: idMeal)
    }
}

extension SearchViewController {
    private func actionTappingHideKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == resultSearchCollectionView {
            return viewModel.numberOfItemSections(type: .searchName)
        } else {
            return viewModel.numberOfItemSections(type: .nation)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == resultSearchCollectionView {
            let cell = collectionView.dequeueReusableCell(withClass: SearchCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtSectionSearchByName(indexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: NationAndCategoryCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtSectionNationCategory(indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == resultSearchCollectionView {
            tappingItemDetail(idMeal: viewModel.listResultSearchMealByName[indexPath.row].idMeal)
        } else {
            if viewModel.isNation {
                loadAPIMealByNationName(nationMeal: viewModel.titleNationCategoryMeal[indexPath.row])
            } else {
                loadAPIMealByCategoryName(categoryMeal: viewModel.titleNationCategoryMeal[indexPath.row])
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
//        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        cell.layer.transform = CATransform3DRotate(CATransform3DIdentity, 1, 1, 1, 1)
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
//            cell.layer.transform = CATransform3DRotate(CATransform3DIdentity, 0, 0, 0, 0)
        })
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == resultSearchCollectionView {
            return CGSize(width: ScreenSize.scaleWidth(160), height: ScreenSize.scaleHeight(200))
        } else {
            return CGSize(width: ScreenSize.scaleWidth(160), height: ScreenSize.scaleHeight(160))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ScreenSize.scaleWidth(15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ScreenSize.scaleHeight(15)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemRecentSearch()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SearchRecentTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAtItemRecentSearch(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScreenSize.scaleHeight(30)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerCell = tableView.dequeueReusableHeaderFooterView(withClass: SearchRecentHeaderTableView.self)
        headerCell.delegate = self
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ScreenSize.scaleHeight(34)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField == searchTextField else {return}
        UIView.animate(withDuration: 0.5) {
            self.recentSearchView.isHidden = false
            self.dismissKeyboard()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.recentSearchTextField.becomeFirstResponder()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField == recentSearchTextField, let text = textField.text else { return false }
        loadAPISearchMealName(nameMeal: text)
        resultSearchCollectionView.isHidden = false
        recentSearchView.isHidden = true
        searchTextField.text = textField.text
        viewModel.saveToHistorySearch(history: text)
        recentSearchTableView.reloadData()
        dismissKeyboard()
        return true
    }
}

// Call Data API
extension SearchViewController {
    private func reloadCollectionView() {
        resultSearchCollectionView.reloadData()
    }
    
    private func loadAPISearchMealName(nameMeal: String) {
        HUD.show()
        viewModel.getAPISearchMealDB(name: nameMeal) { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                HUD.dismiss()
                this.reloadCollectionView()
            } else {
                HUD.dismiss()
                this.resultSearchCollectionView.isHidden = true
                this.emptySearchTitleLabel.text = "Can't Find Your Food..."
            }
        }
    }
    
    private func loadAPINationMeal() {
        HUD.show()
        viewModel.getAPINationMeal { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                HUD.dismiss()
                this.nationAndCategoryCollectionView.reloadData()
            } else {
                HUD.dismiss()
            }
        }
    }
    
    private func loadAPICategoryMeal() {
        HUD.show()
        viewModel.getAPICategoryMeal { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                HUD.dismiss()
                this.nationAndCategoryCollectionView.reloadData()
            } else {
                HUD.dismiss()
            }
        }
    }
    
    private func loadAPIMealByNationName(nationMeal: String) {
        HUD.show()
        viewModel.getAPIMealByNation(nationName: nationMeal) { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                HUD.dismiss()
                this.showDataSearchByNationAndCategory()
                this.reloadCollectionView()
            } else {
                HUD.dismiss()
            }
        }
    }
    
    private func loadAPIMealByCategoryName(categoryMeal: String) {
        HUD.show()
        viewModel.getAPIMealByCategory(categoryName: categoryMeal) { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                HUD.dismiss()
                this.showDataSearchByNationAndCategory()
                this.reloadCollectionView()
            } else {
                HUD.dismiss()
            }
        }
    }
    
    private func loadAPIDetailMeal(idMeal: String) {
//        HUD.show()
        viewModel.getAPIDetailMealDB(idMeal: idMeal) { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                guard let meal = this.viewModel.mealDetail, let navi = this.navigationController else {return}
                let detailScreen = ScreenName.detailMeal
                detailScreen.viewModel = DetailMealViewModel(meal: meal)
                detailScreen.hidesBottomBarWhenPushed = true
                navi.pushViewController(detailScreen, animated: true)
            } else {
                this.showAlert(message: msg)
            }
        }
    }
}

extension SearchViewController: SearchRecentHeaderTableViewDelegate {
    func tappingInsideButton(view: SearchRecentHeaderTableView) {
        viewModel.clearAllHitorySearch()
        recentSearchTableView.reloadData()
    }
}
