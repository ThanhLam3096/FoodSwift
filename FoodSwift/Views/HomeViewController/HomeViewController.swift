//
//  HomeViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/10/24.
//

import UIKit
import SVProgressHUD

class HomeViewController: BaseViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var headerHomeView: HeaderHomeView!
    @IBOutlet private weak var locationListTableView: UITableView!
    @IBOutlet private weak var randomImageCollectionView: UICollectionView!
    @IBOutlet private weak var sliderImagePageControl: UIPageControl!
    @IBOutlet private weak var featuredPartnersLabel: UILabel!
    @IBOutlet private weak var featuredPartnersSeeAllButton: UIButton!
    @IBOutlet private weak var featuredPartnersCollectionView: UICollectionView!
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var restaurantLabel: UILabel!
    @IBOutlet private weak var restaurantSeeAllButton: UIButton!
    @IBOutlet private weak var bestFoodOfRestaurntsCollectionView: UICollectionView!
    @IBOutlet private weak var allRestaurantLabel: UILabel!
    @IBOutlet private weak var allRestaurantSeeAllButton: UIButton!
    @IBOutlet private weak var allRestaurantTableView: UITableView!
    
    // MARK: - @NSLayoutConstraint
    @IBOutlet private weak var heightOfHeaderViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var leadingSpaceSliderImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceSliderImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceSliderImageConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfListNationFilterConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfListNationFilterConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfFeaturedPartnersCollectionViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfNationMealCollectionViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfBannerConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfBannerConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceOfPickRestaurantLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfAllRestaurantLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightListTableView: NSLayoutConstraint!
    @IBOutlet private weak var heightContentViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: HomeViewVM = HomeViewVM()
    var timer: Timer?
    var currentIndex = 0
    var pageControl: CustomPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func setUpUI() {
        setUpHeaderView()
        setUpTitleLabelAndTitleButton()
        setUpTableView()
        setUpCollectionView()
        setUpPageControl()
        setUpBannerImage()
    }
    
    override func setUpData() {
        loadAPIListFeaturePartners()
    }
    
    private func setUpHeaderView() {
        headerHomeView.delegate = self
        heightOfHeaderViewConstraint.constant = ScreenSize.scaleHeight(100)
    }
    
    private func setUpTitleLabelAndTitleButton() {
        setUpTitleLabel(label: featuredPartnersLabel, title: "Featured Partners")
        setUpSeeAllButton(seeAllButton: featuredPartnersSeeAllButton)
        
        setUpTitleLabel(label: restaurantLabel, title: "Best Picks Restaurants by team")
        setUpSeeAllButton(seeAllButton: restaurantSeeAllButton)
        topSpaceOfPickRestaurantLabelConstraint.constant = ScreenSize.scaleHeight(20)
        
        setUpTitleLabel(label: allRestaurantLabel, title: "All Restaurants")
        topSpaceOfAllRestaurantLabelConstraint.constant = ScreenSize.scaleHeight(34)
        setUpSeeAllButton(seeAllButton: allRestaurantSeeAllButton)
    }
    
    private func setUpTitleLabel(label: UILabel, title: String) {
        label.text = title
        label.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(24))
        label.textColor = Color.mainColor
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: ScreenSize.screenWidth / 2).isActive = true
    }
    
    private func setUpSeeAllButton(seeAllButton: UIButton) {
        seeAllButton.setAttributedTitle(NSAttributedString(string: "See all", attributes: [
            .font: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) as Any, .foregroundColor: Color.accentColor
        ]), for: .normal)
    }
    
    private func setUpBannerImage() {
        bannerImageView.layer.cornerRadius = 8
        heightOfBannerConstraint.constant = ScreenSize.scaleHeight(210)
        topSpaceOfBannerConstraint.constant = ScreenSize.scaleHeight(34)
    }
    
    private func setUpTableView() {
        locationListTableView.register(nibWithCellClass: LocationListTableViewCell.self)
        locationListTableView.isHidden = true
        locationListTableView.delegate = self
        locationListTableView.dataSource = self
        widthOfListNationFilterConstraint.constant = ScreenSize.scaleWidth(200)
        heightOfListNationFilterConstraint.constant = ScreenSize.scaleHeight(150)
        
        allRestaurantTableView.register(nibWithCellClass: ListAllResTableViewCell.self)
        allRestaurantTableView.separatorStyle = .none
        allRestaurantTableView.delegate = self
        allRestaurantTableView.dataSource = self
        allRestaurantTableView.isScrollEnabled = false
    }
    
    private func setUpCollectionView() {
        setUpRandomImageCollectionView()
        setUpFeaturedPartnersCollectionView(collectionView: featuredPartnersCollectionView)
        heightOfFeaturedPartnersCollectionViewConstraint.constant = ScreenSize.scaleHeight(254)
        setUpFeaturedPartnersCollectionView(collectionView: bestFoodOfRestaurntsCollectionView)
        heightOfNationMealCollectionViewConstraint.constant = ScreenSize.scaleHeight(254)
    }
    
    private func setUpRandomImageCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        randomImageCollectionView.collectionViewLayout = layout
        randomImageCollectionView.isPagingEnabled = true
        randomImageCollectionView.showsHorizontalScrollIndicator = false
        randomImageCollectionView.delegate = self
        randomImageCollectionView.dataSource = self
        randomImageCollectionView.layer.cornerRadius = 8
        randomImageCollectionView.heightAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(185)).isActive = true
        botSpaceSliderImageConstraint.constant = ScreenSize.scaleHeight(20)
        leadingSpaceSliderImageConstraint.constant = ScreenSize.scaleWidth(20)
        trailingSpaceSliderImageConstraint.constant = ScreenSize.scaleWidth(20)
        randomImageCollectionView.register(nibWithCellClass: SliderImageCollectionViewCell.self)
    }
    
    private func setUpFeaturedPartnersCollectionView(collectionView: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nibWithCellClass: FeaturedPartnersCollectionViewCell.self)
    }
    
    // MARK: - Page Control Setup
    func setUpPageControl() {
        startTimer()
        sliderImagePageControl.numberOfPages = viewModel.listSliderFoodImage.count
        sliderImagePageControl.currentPage = 0
        sliderImagePageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        sliderImagePageControl.tintColor = Color.tabBarColor
        sliderImagePageControl.pageIndicatorTintColor = Color.tabBarColor
        sliderImagePageControl.currentPageIndicatorTintColor = UIColor.white
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        let page = sender.currentPage
        let indexPath = IndexPath(item: page, section: 0)
        randomImageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - Timer Setup
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScrollImages), userInfo: nil, repeats: true)
    }
    
    @IBAction func seeAllFeaturedPartnersTouchUpInside(_ sender: Any) {
        let vc = FeaturePartnersViewController()
        vc.viewModel = viewModel.transferListFeaturePartNers()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func seeAllNationMealTouchUpInside(_ sender: Any) {
        let vc = FeaturePartnersViewController()
        vc.viewModel = viewModel.transferListNationMeal()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func autoScrollImages() {
        currentIndex += 1
        if currentIndex == viewModel.listSliderFoodImage.count {
            currentIndex = 0
        }
        let indexPath = IndexPath(item: currentIndex, section: 0)
        randomImageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        sliderImagePageControl.currentPage = currentIndex
    }
    
    private func loadAPIListRestaurants() {
        viewModel.getAPIListRestaurant { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                HUD.dismiss()
                this.updateViewTableView()
            } else {
                this.showAlert(message: msg)
            }
        }
    }
    
    private func updateViewTableView() {
        guard isViewLoaded else { return }
        heightListTableView.constant = CGFloat(ScreenSize.scaleHeight(292) * CGFloat(viewModel.numberOfRowsInSectionTableView(type: .restaurant)))
        let totalHeightOfCollectionView = ScreenSize.scaleHeight(185) + botSpaceSliderImageConstraint.constant + heightOfFeaturedPartnersCollectionViewConstraint.constant + heightOfNationMealCollectionViewConstraint.constant
        let spaceOfItem = topSpaceOfPickRestaurantLabelConstraint.constant + topSpaceOfAllRestaurantLabelConstraint.constant + ScreenSize.scaleHeight(200)
        heightContentViewConstraint.constant = heightOfHeaderViewConstraint.constant + totalHeightOfCollectionView + heightOfBannerConstraint.constant + topSpaceOfBannerConstraint.constant + spaceOfItem + heightListTableView.constant
        allRestaurantTableView.reloadData()
    }
    
    private func loadAPIListFeaturePartners() {
        HUD.show()
        viewModel.getAPIListFeaturePartners { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                this.loadAPIListNationFood()
            } else {
                this.showAlert(message: msg)
            }
        }
    }
    
    private func loadAPIListNationFood() {
        viewModel.getAPIListNationFood { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                this.updateCollectionView()
                this.loadAPIListRestaurants()
            } else {
                this.showAlert(message: msg)
            }
        }
    }
    
    private func updateCollectionView() {
        guard isViewLoaded else { return }
        featuredPartnersCollectionView.reloadData()
        bestFoodOfRestaurntsCollectionView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == locationListTableView {
            return viewModel.numberOfRowsInSectionTableView(type: .locaition)
        } else {
            return viewModel.numberOfRowsInSectionTableView(type: .restaurant)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == locationListTableView {
            let cell = tableView.dequeueReusableCell(withClass: LocationListTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtHeaderView(indexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withClass: ListAllResTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtListRestaurants(indexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == locationListTableView { 
            let location = viewModel.listLocation[indexPath.row]
            headerHomeView.viewModel = HeaderHomeVM(location: location)
            locationListTableView.isHidden = true
        } else {
            let item = viewModel.listRestaurants[indexPath.row]
            print("Check Info Restaurant : \(item.name)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == locationListTableView {
            return viewModel.heightForRowAtTableView(type: .locaition)
        } else {
            return viewModel.heightForRowAtTableView(type: .restaurant)
        }
    }
}

extension HomeViewController: HeaderHomeViewDelegate {
    func tappingInsideList(view: HeaderHomeView) {
        locationListTableView.isHidden = !locationListTableView.isHidden
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == randomImageCollectionView {
            return viewModel.numberOfRowsInSectionCollectionView(type: .slider)
        } else if collectionView ==  featuredPartnersCollectionView{
            return viewModel.numberOfRowsInSectionCollectionView(type: .featurePartner )
        } else {
            return viewModel.numberOfRowsInSectionCollectionView(type: .nationFood )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == randomImageCollectionView {
            let cell = collectionView.dequeueReusableCell(withClass: SliderImageCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtSlider(indexPath: indexPath)
            return cell
        } else if collectionView == featuredPartnersCollectionView {
            let cell = collectionView.dequeueReusableCell(withClass: FeaturedPartnersCollectionViewCell.self, for: indexPath)
            cell.delegate = self
            cell.viewModel = viewModel.cellForRowAtCollectionMeal(indexPath: indexPath, type: .featurePartner)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: FeaturedPartnersCollectionViewCell.self, for: indexPath)
            cell.delegate = self
            cell.viewModel = viewModel.cellForRowAtCollectionMeal(indexPath: indexPath, type: .nationFood)
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == randomImageCollectionView { 
            return CGSize(width: randomImageCollectionView.frame.width, height: randomImageCollectionView.frame.height)
        }
        else {
            return CGSize(width: ScreenSize.scaleWidth(200), height: ScreenSize.scaleHeight(254))
        }
    }
    
    // Dừng timer khi người dùng cuộn thủ công
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == randomImageCollectionView {
            timer?.invalidate()
        }
    }
    
    // Khởi động lại timer khi người dùng dừng cuộn
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == randomImageCollectionView {
            startTimer()
        }
    }
    
    // Cập nhật page control khi cuộn
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == randomImageCollectionView {
            let pageIndex = round(scrollView.contentOffset.x / view.frame.size.width)
            sliderImagePageControl.currentPage = Int(pageIndex)
            currentIndex = Int(pageIndex)
        }
    }
}

extension HomeViewController: FeaturedPartnersCollectionViewCellViewDelegate {
    func didTapImage(in cell: FeaturedPartnersCollectionViewCell, typeList: TypeList) {
        switch typeList {
        case .featurePartners:
            if let indexPath = featuredPartnersCollectionView.indexPath(for: cell) {
                ScreenName.detailMeal.viewModel = DetailMealViewModel(meal: viewModel.listMealFeaturePartners[indexPath.row])
            }
            ScreenName.detailMeal.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(ScreenName.detailMeal, animated: true)
        case .nation:
            if let indexPath = bestFoodOfRestaurntsCollectionView.indexPath(for: cell) {
                ScreenName.detailMeal.viewModel = DetailMealViewModel(meal: viewModel.listNationFood[indexPath.row])
            }
            ScreenName.detailMeal.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(ScreenName.detailMeal, animated: true)
        }
    }
}
