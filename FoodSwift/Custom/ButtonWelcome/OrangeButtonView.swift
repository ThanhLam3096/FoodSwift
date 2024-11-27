//
//  WelcomeButtonView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 30/4/24.
//

import UIKit
import AVFoundation

class OrangeButtonView: UIView {

    @IBOutlet private var orangeButtonView: UIView!
    @IBOutlet private weak var startButton: UIButton!
    weak var delegate: OrangeButtonViewViewDelegate?
    
    //MARK: - Properties
    var audioPlayer: AVAudioPlayer?
    var viewModel: OrangeButtonViewModel? {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIView()
        preloadSound()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUIView()
        preloadSound()
    }
    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("OrangeButtonView", owner: self, options: nil)
        self.addSubview(orangeButtonView)
        orangeButtonView.frame = self.bounds
        orangeButtonView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        startButton.setAttributedTitle(NSAttributedString(string: "GET STARTED", attributes: [
            .font: UIFont.fontYugothicUIBold(ofSize: ScreenSize.scaleHeight(14)) as Any
        ]), for: .normal)
        startButton.backgroundColor =  Color.activeColor
        startButton.layer.cornerRadius = 8
    }
    
    @IBAction func getStartButtonTouchUpInside(_ sender: Any) {
        playSound()
        if let delegate = delegate {
            delegate.tappingInsideButton(view: self)
        }
    }
    
    func setButtonTitle(_ title: String) {
        startButton.setAttributedTitle(NSAttributedString(string: title, attributes: [
            .font: UIFont.fontYugothicUIBold(ofSize: ScreenSize.scaleHeight(14)) as Any
        ]), for: .normal)
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        var price: String = ""
        if let totalPriceMeal = viewModel.totalPriceMeal {
            price = "($\(displayNumber(totalPriceMeal)))"
        } else {
            price = ""
        }
        startButton.setAttributedTitle(NSAttributedString(string: "\(viewModel.title) " + price, attributes: [
            .font: UIFont.fontYugothicUIBold(ofSize: ScreenSize.scaleHeight(14)) as Any,
            .foregroundColor: Color.bgColor
        ]), for: .normal)
        startButton.isEnabled = viewModel.isEnableButton
        startButton.backgroundColor = viewModel.isEnableButton ? Color.activeColor : Color.activeColor.withAlphaComponent(0.5)
    }
    
    private func preloadSound() {
        guard let url = Bundle.main.url(forResource: "ting_ting", withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    private func playSound() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.audioPlayer?.play()
        }
    }
}

protocol OrangeButtonViewViewDelegate: AnyObject {
    func tappingInsideButton(view: OrangeButtonView)
}
