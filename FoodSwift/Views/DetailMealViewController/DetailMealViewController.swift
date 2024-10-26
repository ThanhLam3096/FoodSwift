//
//  DetailMealViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 21/10/24.
//

import UIKit

class DetailMealViewController: BaseViewController {

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
    
    // MARK: - Properties
    var viewModel: DetailMealViewModel = DetailMealViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        updateInfoView()
    }
    
    override func setUpUI() {
        updateUILabel()
        
        backButton.setTitle("", for: .normal)
        shapeButton.setTitle("", for: .normal)
        searchButton.setTitle("", for: .normal)
        takeAwayButton.setAttributedTitle(NSAttributedString(string: "TAKE AWAY", attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: 12) as Any,
            .foregroundColor: UIColor(hex: "#EEA734")
        ]), for: .normal)
        takeAwayButton.layer.cornerRadius = 6
        takeAwayButton.layer.borderWidth = 1
        takeAwayButton.layer.borderColor = CGColor.hexStringToCGColor(hex: "#EEA734")
        
        setUpTableView()
        updateCollectionView()
    }
    
    override func setUpData() {
        loadAPIListMealByCategory(categoryName: viewModel.typeMeal[0])
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
        secondDeliveryLabel.text = meal.feeShip == 0 ? "" : "Dollars"
        firstTimeDeliveryLabel.text = meal.time.replacingOccurrences(of: "min", with: "")
        secondTimeDeliveryLabel.text = "Minutes"
    }
    
    private func updateUILabel() {
        setUpLabel(label: nameMealLabel, labelFont: UIFont.fontYugothicUISemiBold(ofSize: 24) ?? UIFont.systemFont(ofSize: 24), labelColor: UIColor(hex: "#000000"))
        setUpLabel(label: priceMealLabel, labelFont: UIFont.fontYugothicRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), labelColor: UIColor(hex: "#868686"))
        setUpLabel(label: firstNationLabel, labelFont: UIFont.fontYugothicRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), labelColor: UIColor(hex: "#868686"))
        setUpLabel(label: secondNationLabel, labelFont: UIFont.fontYugothicRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), labelColor: UIColor(hex: "#868686"))
        setUpLabel(label: typeFoodLabel, labelFont: UIFont.fontYugothicRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), labelColor: UIColor(hex: "#868686"))
        setUpLabel(label: ratingLabel, labelFont: UIFont.fontYugothicLight(ofSize: 12) ?? UIFont.systemFont(ofSize: 12), labelColor: UIColor(hex: "#010F07"))
        setUpLabel(label: numberVoteLabel, labelFont: UIFont.fontYugothicLight(ofSize: 12) ?? UIFont.systemFont(ofSize: 12), labelColor: UIColor(hex: "#010F07"))
        setUpLabel(label: firstDeliveryLabel, labelFont: UIFont.fontYugothicLight(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), labelColor: UIColor(hex: "#010F07"))
        setUpLabel(label: firstTimeDeliveryLabel, labelFont: UIFont.fontYugothicLight(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), labelColor: UIColor(hex: "#010F07"))
        setUpLabel(label: secondDeliveryLabel, labelFont: UIFont.fontYugothicRegular(ofSize: 12) ?? UIFont.systemFont(ofSize: 12), labelColor: UIColor(hex: "#010F07"))
        setUpLabel(label: secondTimeDeliveryLabel, labelFont: UIFont.fontYugothicRegular(ofSize: 12) ?? UIFont.systemFont(ofSize: 12), labelColor: UIColor(hex: "#010F07"))
        setUpLabel(label: listFeatureLabel, labelFont: UIFont.fontYugothicLight(ofSize: 20) ?? UIFont.systemFont(ofSize: 20), labelColor: UIColor(hex: "#010F07"))
    }
    
    private func setUpLabel(label: UILabel, labelFont: UIFont, labelColor: UIColor) {
        label.font = labelFont
        label.textColor = labelColor
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
        layout.minimumLineSpacing = 20
        
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
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
    
    private func reloadDataTableView() {
        guard isViewLoaded else { return }
        listMealForTypeTableView.reloadData()
    }

    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
            if let previousIndexPath = viewModel.selectedIndexPath {
                let previousCell = typeMealCollectionView.cellForItem(at: previousIndexPath) as? TypeMealCollectionViewCell
                previousCell?.typeFoodLabel.textColor = UIColor(hex: "#868686")
            }
            
            // Cập nhật ô được chọn
            viewModel.selectedIndexPath = indexPath
            
            // Đổi màu ô hiện tại
            let currentCell = typeMealCollectionView.cellForItem(at: indexPath) as? TypeMealCollectionViewCell
            currentCell?.typeFoodLabel.textColor = UIColor(hex: "#FFD15C")
            
            loadAPIListMealByCategory(categoryName: viewModel.typeMeal[indexPath.row])
        } else {
            print("abcd")
        }
    }
}

extension DetailMealViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featureItemCollectionView {
            return CGSize(width: (140 / 375) * ScreenSize.screenWidth, height: (198 / 812) * ScreenSize.screenHeight)
        } else {
            let text = viewModel.typeMeal[indexPath.item]
            let label = UILabel()
            label.text = text
            label.numberOfLines = 1
            label.font = UIFont.fontYugothicUISemiBold(ofSize: 28)
            label.textColor = UIColor(hex: "#868686")
            
            // Calculate the size that fits the label's text
            let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.frame.height))
            return CGSize(width: size.width, height: collectionView.frame.height)
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
