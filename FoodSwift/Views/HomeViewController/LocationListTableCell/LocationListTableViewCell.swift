//
//  LocationListTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/10/24.
//

import UIKit

class LocationListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var locationLabel: UILabel!
    
    //MARK: - Properties
    var viewModel: LocationListViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        locationLabel.font = UIFont.fontYugothicLight(ofSize: 20)
        locationLabel.textColor = Color.mainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        locationLabel.text = viewModel.location
    }
    
}
