//
//  TypeMealCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/10/24.
//

import UIKit

class TypeMealCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var typeFoodLabel: UILabel!
    
    //MARK: - Properties
    var viewModel: TypeMealCollectionCellVM? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }
    
    private func setUpUI() {
        typeFoodLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 24)
        typeFoodLabel.textColor = UIColor(hex: "#868686")
        typeFoodLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func updateView() {
        guard let vm = viewModel else { return }
        typeFoodLabel.text = vm.typeMealTitle
        if vm.indexPath == 0 {
            typeFoodLabel.textColor = UIColor(hex: "#FFD15C")
        } else {
            typeFoodLabel.textColor = UIColor(hex: "#868686")
        }
    }
}
