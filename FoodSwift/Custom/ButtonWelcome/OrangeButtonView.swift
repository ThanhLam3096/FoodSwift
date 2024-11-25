//
//  WelcomeButtonView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 30/4/24.
//

import UIKit
import AVFoundation
import AudioToolbox

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
//        preloadSound()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUIView()
//        preloadSound()
    }
    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("OrangeButtonView", owner: self, options: nil)
        self.addSubview(orangeButtonView)
        orangeButtonView.frame = self.bounds
        orangeButtonView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        startButton.setAttributedTitle(NSAttributedString(string: "GET STARTED", attributes: [
            .font: UIFont.fontYugothicUIBold(ofSize: ScreenSize.scaleHeight(14)) as Any
        ]), for: .normal)
        startButton.backgroundColor = UIColor(red: 238/255, green: 167/255, blue: 52/255, alpha: 1.0)
        startButton.layer.cornerRadius = 8
    }
    
    @IBAction func getStartButtonTouchUpInside(_ sender: Any) {
//        playSound()
        playSoundWithSystemSound()
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
            .font: UIFont.fontYugothicUIBold(ofSize: ScreenSize.scaleHeight(14)) as Any
        ]), for: .normal)

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
    
    private func playSoundWithSystemSound() {
        if let soundURL = Bundle.main.url(forResource: "ting_ting", withExtension: "mp3") {
            var soundID: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
            AudioServicesPlaySystemSound(soundID)
        }
    }
}

protocol OrangeButtonViewViewDelegate: AnyObject {
    func tappingInsideButton(view: OrangeButtonView)
}
