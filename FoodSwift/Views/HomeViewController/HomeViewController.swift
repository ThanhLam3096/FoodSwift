//
//  HomeViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/10/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var headerHomeView: HeaderHomeView!
    @IBOutlet private weak var locationListTableView: UITableView!
    @IBOutlet private weak var randomImageCollectionView: UICollectionView!
    @IBOutlet private weak var sliderImagePageControl: UIPageControl!
    @IBOutlet private weak var featuredPartnersLabel: UILabel!
    @IBOutlet private weak var featuredPartnersSeeAllButton: UIButton!
    @IBOutlet private weak var featuredPartnersCollectionView: UICollectionView!
    @IBOutlet private weak var restaurantLabel: UILabel!
    @IBOutlet private weak var restaurantSeeAllButton: UIButton!
    @IBOutlet private weak var bestFoodOfRestaurntsCollectionView: UICollectionView!
    @IBOutlet private weak var allRestaurantLabel: UILabel!
    @IBOutlet private weak var allRestaurantSeeAllButton: UIButton!
    @IBOutlet private weak var allRestaurantTableView: UITableView!
    @IBOutlet private weak var heightListTableView: NSLayoutConstraint!
    @IBOutlet private weak var heightContentViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: HomeViewVM = HomeViewVM()
    var timer: Timer?
    var currentIndex = 0
    var pageControl: CustomPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpUI() {
        setUpTableView()
        setUpRandomImageCollectionView()
        setUpFeaturedPartnersCollectionView(collectionView: featuredPartnersCollectionView)
        setUpFeaturedPartnersCollectionView(collectionView: bestFoodOfRestaurntsCollectionView)
        setUpPageControl()
        headerHomeView.delegate = self
        
        setUpTitleLabel(label: featuredPartnersLabel, title: "Featured Partners")
        setUpSeeAllButton(seeAllButton: featuredPartnersSeeAllButton)
        
        setUpTitleLabel(label: restaurantLabel, title: "Best Picks Restaurants by team")
        setUpSeeAllButton(seeAllButton: restaurantSeeAllButton)
        
        setUpTitleLabel(label: allRestaurantLabel, title: "All Restaurants")
        setUpSeeAllButton(seeAllButton: allRestaurantSeeAllButton)
        heightContentViewConstraint.constant = CGFloat(1500 + (282 * (viewModel.numberOfRowsInSectionListRestaurants() - 1)))
    }
    
    private func setUpTitleLabel(label: UILabel, title: String) {
        label.text = title
        label.font = UIFont.fontYugothicUISemiBold(ofSize: 24)
        label.textColor = UIColor(hex: "#010F07")
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: ScreenSize.screenWidth / 2).isActive = true
    }
    
    private func setUpSeeAllButton(seeAllButton: UIButton) {
        seeAllButton.setAttributedTitle(NSAttributedString(string: "See all", attributes: [
            .font: UIFont.fontYugothicRegular(ofSize: 16) as Any, .foregroundColor: UIColor(hex: "#F8B64C")
        ]), for: .normal)
    }
    
    private func setUpTableView() {
        locationListTableView.register(nibWithCellClass: LocationListTableViewCell.self)
        locationListTableView.isHidden = true
        locationListTableView.delegate = self
        locationListTableView.dataSource = self
        
        allRestaurantTableView.register(nibWithCellClass: ListAllResTableViewCell.self)
        allRestaurantTableView.delegate = self
        allRestaurantTableView.dataSource = self
        allRestaurantTableView.isScrollEnabled = false
        heightListTableView.constant = CGFloat(282 * viewModel.numberOfRowsInSectionListRestaurants())
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
        sliderImagePageControl.tintColor = UIColor(hex: "#979797")
        sliderImagePageControl.pageIndicatorTintColor = UIColor(hex: "#979797")
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
    
    @objc func autoScrollImages() {
        currentIndex += 1
        if currentIndex == viewModel.listSliderFoodImage.count {
            currentIndex = 0
        }
        let indexPath = IndexPath(item: currentIndex, section: 0)
        randomImageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        sliderImagePageControl.currentPage = currentIndex
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
            return viewModel.numberOfRowsInSectionHeaderView()
        } else {
            return viewModel.numberOfRowsInSectionListRestaurants()
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
            let item = dummyRestaurant.listAllRes[indexPath.row]
            print("Check Info Restaurant : \(item.name)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == locationListTableView {
            return viewModel.heightForRowAtHeaderView()
        } else {
            return viewModel.heightForRowAtListRestaurants()
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
            return viewModel.numberOfRowsInSectionSlider()
        } else {
            return viewModel.numberOfRowsInSectionFeaturedPartners()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == randomImageCollectionView {
            let cell = collectionView.dequeueReusableCell(withClass: SliderImageCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtSlider(indexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: FeaturedPartnersCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtFeaturedPartners(indexPath: indexPath)
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
            return CGSize(width: 200, height: featuredPartnersCollectionView.frame.height)
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
