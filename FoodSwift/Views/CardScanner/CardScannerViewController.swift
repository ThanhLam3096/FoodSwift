//
//  CardScannerViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/12/24.
//

import UIKit
import AVFoundation
import Vision

// MARK: - Protocols
protocol CardScannerViewControllerDelegate: AnyObject {
    func cardScanner(_ scanner: CardScannerViewController, didFinishWith card: CardDetails)
    func cardScannerDidCancel(_ scanner: CardScannerViewController)
}

final class CardScannerViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var scannerOverlayView: UIView!
    @IBOutlet private weak var instructionLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    
    // MARK: - Properties
    private let viewModel = CardScannerViewControllerVM()
    weak var delegate: CardScannerViewControllerDelegate?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.setupCamera()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Cập nhật mask layer khi view thay đổi kích thước
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: view.bounds)
        path.append(UIBezierPath(rect: scannerOverlayView.frame).reversing())
        maskLayer.path = path.cgPath
        overlayView.layer.mask = maskLayer
        
        // Cập nhật frame của previewLayer
        previewLayer?.frame = view.bounds
    }
    
    private func setupBindings() {
        viewModel.onError = { [weak self] message in
            self?.showAlert(message: message)
        }
        
        viewModel.onCardScanned = { [weak self] card in
            guard let self = self else { return }
            self.viewModel.stopScanning()
            self.delegate?.cardScanner(self, didFinishWith: card)
            self.dismiss(animated: true)
        }
        
        viewModel.onCameraSetupComplete = { [weak self] previewLayer in
            self?.previewLayer = previewLayer
            DispatchQueue.main.async {
                guard let self = self else { return }
                // Cấu hình previewLayer
                previewLayer.frame = self.view.bounds
                previewLayer.videoGravity = .resizeAspectFill
                // Thêm vào layer đầu tiên
                self.view.layer.insertSublayer(previewLayer, at: 0)
            }
        }
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .black
        
        // Setup scanner overlay view
        scannerOverlayView.translatesAutoresizingMaskIntoConstraints = false
        scannerOverlayView.layer.borderColor = UIColor.white.cgColor
        scannerOverlayView.layer.borderWidth = 2
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Center horizontally and vertically
            scannerOverlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scannerOverlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // The width is 85% of the screen width.
            scannerOverlayView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            // The width-to-height ratio of a credit card is 1.59:1.
            scannerOverlayView.widthAnchor.constraint(equalTo: scannerOverlayView.heightAnchor, multiplier: 1.59)
        ])
        
        // Setup overlay mask
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: view.bounds)
        path.append(UIBezierPath(rect: scannerOverlayView.frame).reversing())
        maskLayer.path = path.cgPath
        overlayView.layer.mask = maskLayer
        addScanAnimation()
    }
    
    private func addScanAnimation() {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = UIColor.white.cgColor
        animation.toValue = UIColor.green.cgColor
        animation.duration = 1.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        scannerOverlayView.layer.add(animation, forKey: "borderColor")
    }
    
    // MARK: - Actions
    @IBAction private func closeButtonTapped(_ sender: UIButton) {
        viewModel.stopScanning()
        delegate?.cardScannerDidCancel(self)
        dismiss(animated: true)
    }
}
