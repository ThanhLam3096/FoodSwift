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
    @IBOutlet private weak var resultSearchCollectionView: UICollectionView!
    @IBOutlet private weak var emptySearchTitleLabel: UILabel!
    
    // MARK: - WidthFrameViewConstraint
    
    // MARK: - HeightFrameViewConstraint
    @IBOutlet weak var heightOfHeaderViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfSearchViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfIconSearchConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfFilterButtonConstraint: NSLayoutConstraint!
    
    // MARK: - TopAndBotFrameConstraint
    @IBOutlet private weak var topSpaceSearchTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceSearchViewLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceResultSearchCollectionViewConstraint: NSLayoutConstraint!
    
    // MARK: - LeadingTrailingFrameConstraint
    @IBOutlet private weak var leadingSpaceHeaderViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceHeaderViewConstraint: NSLayoutConstraint!
    
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
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: searchTitleLabel, text: "Search", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(28)) ?? UIFont.systemFont(ofSize: 28), labelTextColor: Color.mainColor)
        
        setUpTextTitleFontTextColorOfLabel(label: emptySearchTitleLabel, text: "Enter Your Name Meal For Search...", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(30)) ?? UIFont.systemFont(ofSize: 28), labelTextColor: Color.accentColor)
        emptySearchTitleLabel.numberOfLines = 0
    }
    
    private func setUpFilterButton() {
        filterButton.setAttributedTitle(NSAttributedString(string: "Filter", attributes: [
            .font: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) as Any,
            .foregroundColor: Color.mainColor,
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
    }
    
    private func setUpHeightFrameView() {
        heightOfHeaderViewConstraint.constant = ScreenSize.scaleHeight(156)
        heightOfSearchViewConstraint.constant = ScreenSize.scaleHeight(48)
        heightOfIconSearchConstraint.constant = ScreenSize.scaleHeight(14)
        heightOfFilterButtonConstraint.constant = ScreenSize.scaleHeight(35)
    }
    
    private func setUpTopBotFrameView() {
        topSpaceSearchTitleLabelConstraint.constant = ScreenSize.scaleHeight(68)
        topSpaceSearchViewLabelConstraint.constant = ScreenSize.scaleHeight(10)
        topSpaceResultSearchCollectionViewConstraint.constant = ScreenSize.scaleHeight(20)
    }
    
    private func setUpLeadingTrailingFrameView() {
        leadingSpaceHeaderViewConstraint.constant = ScreenSize.scaleWidth(20)
        trailingSpaceHeaderViewConstraint.constant = ScreenSize.scaleWidth(20)
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
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: SearchCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAtSection(indexPath: indexPath)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.scaleWidth(160), height: ScreenSize.scaleHeight(198))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ScreenSize.scaleWidth(15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ScreenSize.scaleHeight(15)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loadAPISearchMealName(nameMeal: textField.text ?? "")
        resultSearchCollectionView.isHidden = textField.text == "" ? true : false
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
}
