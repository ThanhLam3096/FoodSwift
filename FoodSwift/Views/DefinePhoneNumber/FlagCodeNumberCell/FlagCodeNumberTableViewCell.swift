//
//  FlagCodeNumberTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 6/9/24.
//

import UIKit

final class FlagCodeNumberTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var flagUIImageView: UIImageView!
    @IBOutlet private weak var textNation: UILabel!
    
    //MARK: - Properties
    var viewModel: FlagCodeNumberCellVM? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textNation.font = UIFont.fontYugothicUIBold(ofSize: 14)
        textNation.textColor = Color.mainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        flagUIImageView.image = UIImage(named: viewModel.imgNation)
        textNation.text = viewModel.nation
    }
}
