//
//  ImageMealModalViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/11/24.
//

import UIKit

class ImageMealModalViewController: UIViewController {
    
    @IBOutlet private weak var mealImageView: UIImageView!
    
    // MARK: - Properties
    var viewModel: ImageMealModalViewModel = ImageMealModalViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func updateImage() {
        guard let urlImage = viewModel.imageString else {return}
        mealImageView.sd_setImage(with: URL(string: urlImage))
    }
    
    @IBAction func dismissPresentTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
