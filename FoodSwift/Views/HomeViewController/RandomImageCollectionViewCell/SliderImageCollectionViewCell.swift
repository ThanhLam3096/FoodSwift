//
//  SliderImageCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 10/10/24.
//

import UIKit

class SliderImageCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOulet
    @IBOutlet private weak var imageSliderUIImage: UIImageView!
    
    //MARK: - Properties
    var viewModel: SliderImageCollectionViewCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageSliderUIImage.contentMode = .scaleAspectFill
        imageSliderUIImage.clipsToBounds = true
        imageSliderUIImage.frame = contentView.bounds
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        imageSliderUIImage.image = UIImage(named: viewModel.image)
    }
}
