//
//  FeaturePartnersViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 19/10/24.
//

import UIKit

class FeaturePartnersViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var featurePartnersCollectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: FeaturePartnersViewControllerVM = FeaturePartnersViewControllerVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func setUpUI() {
        setUpNavigation()
        setUpCollectionView()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Featured Partners"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpCollectionView() {
        featurePartnersCollectionView.delegate = self
        featurePartnersCollectionView.dataSource = self
        featurePartnersCollectionView.register(nibWithCellClass: DetailFeaturePartnersCollectionViewCell.self)
    }

    @objc func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FeaturePartnersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: DetailFeaturePartnersCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAtSection(indexPath: indexPath)
        return cell
    }
}

extension FeaturePartnersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (160 / 375) * ScreenSize.screenWidth, height: (348 / 812) * ScreenSize.screenHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
