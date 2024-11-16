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
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func setUpUI() {
        setUpNavigation()
        setUpFrame()
        setUpCollectionView()
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
        self.navigationController?.popViewController(animated: true)
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
        filterCollectionView.register(nibWithCellClass: NationAndCategoryFilterCollectionViewCell.self)
        filterCollectionView.register(nibWithCellClass: PriceRangeCollectionViewCell.self)
        
        let layout = createLayout()
        filterCollectionView.collectionViewLayout = layout
        
        let headerNib = UINib(nibName: "HeaderFilterCollectionReusableView", bundle: .main)
        filterCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderFilter")
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createNationsSection(titles: self.viewModel.filterByNation)
            case 1:
                return self.createCategoriesSection(titles: self.viewModel.filterByCategory)
            case 2:
                return self.createPriceRangeSection()
            default:
                return nil
            }
        }
    }
    
    func calculateTextWidth(text: String, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: ScreenSize.scaleHeight(38)) // Chiều cao cố định
        let boundingBox = text.boundingRect(
            with: constraintSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return boundingBox.width // add ceil(boundingBox.width) Làm tròn chiều rộng
    }
    
    func createNationsSection(titles: [String]) -> NSCollectionLayoutSection {
        
        // Header width height
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(ScreenSize.scaleHeight(50)))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        // Width height của cell
        let items: [NSCollectionLayoutItem] = titles.map { title in
            let textWidth = calculateTextWidth(text: title, font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(12)))
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(textWidth + ScreenSize.scaleWidth(41)), // Thêm padding
                heightDimension: .absolute(ScreenSize.scaleHeight(38))
            )
            return NSCollectionLayoutItem(layoutSize: itemSize)
        }
    
        // Width height của nhóm cell
        let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(ScreenSize.scaleHeight(38))
                    ),
                    subitems: items
                )
        group.interItemSpacing = .fixed(ScreenSize.scaleWidth(10)) // space left right giữa các cell

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.interGroupSpacing = ScreenSize.scaleHeight(15) // space cách top bot giữa các cell
        section.boundarySupplementaryItems = [header] // them header
        return section
    }
    
    func createCategoriesSection(titles: [String]) -> NSCollectionLayoutSection {
        // Header width height
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(ScreenSize.scaleHeight(50)))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        // Width height của cell
        let items: [NSCollectionLayoutItem] = titles.map { title in
            let textWidth = calculateTextWidth(text: title, font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(12)))
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.3), // Thêm padding
                heightDimension: .absolute(ScreenSize.scaleHeight(38))
            )
            return NSCollectionLayoutItem(layoutSize: itemSize)
        }

        // Width height của nhóm cell
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(ScreenSize.scaleHeight(38))
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: items)
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
        case .nation, .category:
            let cell = collectionView.dequeueReusableCell(withClass: NationAndCategoryFilterCollectionViewCell.self, for: indexPath)
            cell.backgroundColor = UIColor(hex: "#F1F1F1")
            cell.viewModel = viewModel.cellForRowAtSectionCollection(indexPath: indexPath, sectionFilterType: sectionFilter)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withClass: PriceRangeCollectionViewCell.self, for: indexPath)
            cell.backgroundColor = UIColor(hex: "#F1F1F1")
            cell.layer.cornerRadius = ScreenSize.scaleHeight(32)
            cell.viewModel = viewModel.cellForRowAtPriceRangeSectionCollection(indexPath: indexPath)
            return cell
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


//extension FilterViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let sectionFilter = FilterViewControllerVM.TypeFilter(rawValue: indexPath.section) else {
//            return CGSize(width: 0, height: 0)
//        }
//        switch sectionFilter {
//        case .nation:
//            var text = ""
//            text = viewModel.filterByNation[indexPath.item]
//            let label = UILabel()
//            label.text = text
//            label.numberOfLines = 1
//            label.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12))
//            label.textColor = Color.bodyTextColor
//            // Calculate the size that fits the label's text
//            let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.frame.height))
//            return CGSize(width: ScreenSize.scaleWidth(size.width + ScreenSize.scaleWidth(22)), height: ScreenSize.scaleHeight(38))
//        case .category:
//            var text = ""
//            text = viewModel.filterByCategory[indexPath.item]
//            let label = UILabel()
//            label.text = text
//            label.numberOfLines = 1
//            label.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12))
//            label.textColor = Color.bodyTextColor
//            // Calculate the size that fits the label's text
//            let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.frame.height))
//            return CGSize(width: ScreenSize.scaleWidth(size.width + ScreenSize.scaleWidth(22)), height: ScreenSize.scaleHeight(38))
//        default: return CGSize(width: ScreenSize.scaleHeight(64), height: ScreenSize.scaleHeight(64))
//        }
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return ScreenSize.scaleHeight(15) // Khoảng cách giữa các dòng
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return ScreenSize.scaleWidth(5) // Khoảng cách giữa các item
//    }
//}

extension FilterViewController: HeaderFilterDelegate {
    func tappingInsideButton(view: HeaderFilterCollectionReusableView) {
        guard let viewModel = view.viewModel else { return }
        switch viewModel.headerType {
        case .nationHeader:
            print("this is first header")
        default:
            print("this is second header")
        }
    }
}
