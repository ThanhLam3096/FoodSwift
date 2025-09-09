//
//  FilterViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 15/11/24.
//

import UIKit

class FilterViewController: BaseViewController {
    
    // MARK: -IBOutlet
    @IBOutlet private weak var filterCollectionView: UICollectionView!
    @IBOutlet private weak var applyFilterButtonView: OrangeButtonView!
    
    // MARK: NSLayoutConstraint
    @IBOutlet private weak var leadingSpaceOfCollectionViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfCollectionViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bottomSpaceApplyFilterButtonViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfApplyFilterButtonViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: FilterViewControllerVM = FilterViewControllerVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getDataSearchFilterToLocal()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func setUpUI() {
        setUpNavigation()
        setUpFrame()
        setUpCollectionView()
        applyFilterButtonView.viewModel = OrangeButtonViewModel(title: "APPLY FILTERS")
        applyFilterButtonView.delegate = self
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Filter"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc func leftAction() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setUpFrame() {
        heightOfApplyFilterButtonViewConstraint.constant = ScreenSize.scaleHeight(48)
        bottomSpaceApplyFilterButtonViewConstraint.constant = ScreenSize.scaleHeight(30)
        leadingSpaceOfCollectionViewConstraint.constant = ScreenSize.scaleWidth(20)
        trailingSpaceOfCollectionViewConstraint.constant = ScreenSize.scaleWidth(20)
    }
    
    private func setUpCollectionView() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.showsVerticalScrollIndicator = false
        filterCollectionView.register(nibWithCellClass: NationAndCategoryFilterCollectionViewCell.self)
        filterCollectionView.register(nibWithCellClass: PriceRangeCollectionViewCell.self)
        
        let layout = createLayout()
        filterCollectionView.collectionViewLayout = layout
        filterCollectionView.allowsSelection = true
        
        let headerNib = UINib(nibName: "HeaderFilterCollectionReusableView", bundle: .main)
        filterCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderFilter")
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0, 1:
                return self.createNationsAndCategoriesSection()
            case 2:
                return self.createPriceRangeSection()
            default:
                return nil
            }
        }
    }
    
    func createNationsAndCategoriesSection() -> NSCollectionLayoutSection {
        // Header width height
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(ScreenSize.scaleHeight(50)))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        // Width height của cell
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(80),
            heightDimension: .absolute(ScreenSize.scaleHeight(38))
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Width height của nhóm cell
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(ScreenSize.scaleHeight(38))
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(ScreenSize.scaleWidth(12))
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.interGroupSpacing = ScreenSize.scaleHeight(15)
        section.boundarySupplementaryItems = [header] // them header
        return section
    }
    
    func createPriceRangeSection() -> NSCollectionLayoutSection {
        // Header width height
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(ScreenSize.scaleHeight(50)))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        // Width height của cell
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ScreenSize.scaleHeight(64)),
            heightDimension: .absolute(ScreenSize.scaleHeight(64))
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Width height của nhóm cell
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2.0),
            heightDimension: .absolute(ScreenSize.scaleHeight(64))
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(ScreenSize.scaleWidth(12))

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header] // them header
        section.interGroupSpacing = ScreenSize.scaleWidth(12)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: ScreenSize.scaleWidth(12))
        return section
    }
}

extension FilterViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection()
    }
}

extension FilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionFilter = FilterViewControllerVM.TypeFilter(rawValue: section) else {
            return 0
        }
        return viewModel.numberOfItemInSection(typeFilter: sectionFilter)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionFilter = FilterViewControllerVM.TypeFilter(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        switch sectionFilter {
        case .nation:
            let cell = collectionView.dequeueReusableCell(withClass: NationAndCategoryFilterCollectionViewCell.self, for: indexPath)
            if viewModel.listIndexFilterChooseByNation.contains(indexPath) {
                cell.backgroundColor = Color.accentColor
                cell.filterTitleLabel.textColor = Color.bgColor
            } else {
                cell.backgroundColor = UIColor(hex: "#F1F1F1")
                cell.filterTitleLabel.textColor = Color.bodyTextColor
            }
            cell.layer.cornerRadius = 6
            cell.viewModel = viewModel.cellForRowAtSectionCollection(indexPath: indexPath, sectionFilterType: sectionFilter)
            return cell
        case .category:
            let cell = collectionView.dequeueReusableCell(withClass: NationAndCategoryFilterCollectionViewCell.self, for: indexPath)
            if viewModel.listIndexFilterChooseByCategory.contains(indexPath) {
                cell.backgroundColor = Color.accentColor
                cell.filterTitleLabel.textColor = Color.bgColor
            } else {
                cell.backgroundColor = UIColor(hex: "#F1F1F1")
                cell.filterTitleLabel.textColor = Color.bodyTextColor
            }
            cell.layer.cornerRadius = 6
            cell.viewModel = viewModel.cellForRowAtSectionCollection(indexPath: indexPath, sectionFilterType: sectionFilter)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withClass: PriceRangeCollectionViewCell.self, for: indexPath)
            if viewModel.listIndexFilterChooseByPriceRange.contains(indexPath) {
                cell.backgroundColor = Color.accentColor
                cell.priceRangeLabel.textColor = Color.bgColor
            } else {
                cell.backgroundColor = UIColor(hex: "#F1F1F1")
                cell.priceRangeLabel.textColor = Color.bodyTextColor
            }
            cell.layer.cornerRadius = ScreenSize.scaleHeight(32)
            cell.viewModel = viewModel.cellForRowAtPriceRangeSectionCollection(indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionFilter = FilterViewControllerVM.TypeFilter(rawValue: indexPath.section) else { return }
        switch sectionFilter {
        case .nation:
            let cell = filterCollectionView.cellForItem(at: indexPath) as? NationAndCategoryFilterCollectionViewCell
            guard let cell = cell else { return }
            if viewModel.listFilterChooseByNation.contains(viewModel.filterByNation[indexPath.row]) {
                cell.backgroundColor = UIColor(hex: "#F1F1F1")
                cell.filterTitleLabel.textColor = Color.bodyTextColor
                viewModel.unSaveDataFilterByNation(indexPath: indexPath)
                viewModel.unSaveDataIndexFilterByNation(indexPath: indexPath)
            } else {
                cell.backgroundColor = Color.accentColor
                cell.filterTitleLabel.textColor = Color.bgColor
                viewModel.saveDataFilterByNation(indexPath: indexPath)
            }
        case .category:
            let cell = filterCollectionView.cellForItem(at: indexPath) as? NationAndCategoryFilterCollectionViewCell
            guard let cell = cell else { return }
            if viewModel.listFilterChooseByCategory.contains(viewModel.filterByCategory[indexPath.row]) {
                cell.backgroundColor = UIColor(hex: "#F1F1F1")
                cell.filterTitleLabel.textColor = Color.bodyTextColor
                viewModel.unSaveDataFilterByCategory(indexPath: indexPath)
                viewModel.unSaveDataIndexFilterByCategory(indexPath: indexPath)
            } else {
                cell.backgroundColor = Color.accentColor
                cell.filterTitleLabel.textColor = Color.bgColor
                viewModel.saveDataFilterByCategory(indexPath: indexPath)
            }
        case .priceRange:
            let cell = filterCollectionView.cellForItem(at: indexPath) as? PriceRangeCollectionViewCell
            guard let cell = cell else { return }
            if viewModel.listFilterChooseByPriceRange.contains(viewModel.filterByPriceRange[indexPath.row]) {
                cell.backgroundColor = UIColor(hex: "#F1F1F1")
                cell.priceRangeLabel.textColor = Color.bodyTextColor
                viewModel.unSaveDataFilterByPriceRange(indexPath: indexPath)
                viewModel.unSaveDataIndexFilterByPriceRange(indexPath: indexPath)
            } else {
                cell.backgroundColor = Color.accentColor
                cell.priceRangeLabel.textColor = Color.bgColor
                viewModel.saveDataFilterByPriceRange(indexPath: indexPath)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: ScreenSize.scaleHeight(50))
        }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionFilter = FilterViewControllerVM.TypeFilter(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderFilter", for: indexPath) as! HeaderFilterCollectionReusableView
        headerCell.delegate = self
        headerCell.viewModel = viewModel.cellForHeaderOfSectionCollection(sectionFilterType: sectionFilter)
        return headerCell
    }
}

extension FilterViewController: HeaderFilterDelegate {
    func tappingInsideButton(view: HeaderFilterCollectionReusableView) {
        guard let vm = view.viewModel else { return }
        switch vm.headerType {
        case .nationHeader:
            viewModel.clearDataFilterNation()
            filterCollectionView.reloadSections(IndexSet(integer: 0))
        case .categoryHeader:
            viewModel.clearDataFilterCategory()
            filterCollectionView.reloadSections(IndexSet(integer: 1))
        default:
            viewModel.clearDataFilterPriceRange()
            filterCollectionView.reloadSections(IndexSet(integer: 2))
        }
    }
}

extension FilterViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        viewModel.saveDataSearchFilterToLocal()
        dismiss(animated: true, completion: nil)
    }
}
