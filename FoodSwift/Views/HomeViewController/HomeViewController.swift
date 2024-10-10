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
        setUpPageControl()
        headerHomeView.delegate = self
    }
    
    private func setUpTableView() {
        locationListTableView.register(nibWithCellClass: LocationListTableViewCell.self)
        locationListTableView.isHidden = true
        locationListTableView.delegate = self
        locationListTableView.dataSource = self
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
        return viewModel.numberOfRowsInSectionHeaderView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LocationListTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAtHeaderView(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = viewModel.listLocation[indexPath.row]
        headerHomeView.viewModel = HeaderHomeVM(location: location)
        locationListTableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAtHeaderView()
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
        return viewModel.numberOfRowsInSectionSlider()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: SliderImageCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAtSlider(indexPath: indexPath)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // Dừng timer khi người dùng cuộn thủ công
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    // Khởi động lại timer khi người dùng dừng cuộn
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    // Cập nhật page control khi cuộn
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.size.width)
        sliderImagePageControl.currentPage = Int(pageIndex)
        currentIndex = Int(pageIndex)
    }
}

