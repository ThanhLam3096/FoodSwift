//
//  CardScannerViewControllerVM.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/12/24.
//

import AVFoundation
import Vision

final class CardScannerViewControllerVM: NSObject {
    // MARK: - Properties
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    
    // MARK: - Callbacks
    var onError: ((String) -> Void)?
    var onCardScanned: ((CardDetails) -> Void)?
    var onCameraSetupComplete: ((AVCaptureVideoPreviewLayer) -> Void)?
    
    // MARK: - Camera Setup
    func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video) else {
            onError?("Can't Connect Camera")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .userInitiated))
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
            
            if let connection = videoOutput.connection(with: .video) {
                connection.videoOrientation = .portrait
                connection.isVideoMirrored = false
            }
            

            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            
            onCameraSetupComplete?(previewLayer)
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.captureSession.startRunning()
            }
        } catch {
            onError?("Failed To Setting Camera")
        }
    }
    
    func startScanning() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    func stopScanning() {
        captureSession.stopRunning()
    }
    
    // MARK: - Card Recognition
    private func findCardNumber(in text: String) -> String? {
        let pattern = "\\b\\d{4}[- ]?\\d{4}[- ]?\\d{4}[- ]?\\d{4}\\b"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(text.startIndex..., in: text)
        
        if let match = regex?.firstMatch(in: text, range: range) {
            let cardNumber = (text as NSString).substring(with: match.range)
            return cardNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        }
        return nil
    }
    
    private func findExpiryDate(in text: String) -> (month: Int, year: Int)? {
        let pattern = "\\b(0[1-9]|1[0-2])/([0-9]{2}|20[2-9][0-9])\\b"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(text.startIndex..., in: text)
        
        if let match = regex?.firstMatch(in: text, range: range) {
            let expiryText = (text as NSString).substring(with: match.range)
            let components = expiryText.split(separator: "/")
            if let month = Int(components[0]),
               var year = Int(components[1]) {
                if year < 100 {
                    year += 2000
                }
                return (month, year)
            }
        }
        return nil
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
extension CardScannerViewControllerVM: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  let self = self else { return }
            
            var cardNumber: String?
            var expiryDate: (month: Int, year: Int)?
            
            for observation in observations {
                guard let text = observation.topCandidates(1).first?.string else { continue }
                
                if cardNumber == nil {
                    cardNumber = self.findCardNumber(in: text)
                }
                
                if expiryDate == nil {
                    expiryDate = self.findExpiryDate(in: text)
                }
                
                if let number = cardNumber, let expiry = expiryDate {
                    DispatchQueue.main.async {
                        let card = CardDetails(
                            number: number,
                            expiryMonth: expiry.month,
                            expiryYear: expiry.year
                        )
                        self.onCardScanned?(card)
                    }
                    return
                }
            }
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = false
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            .perform([request])
    }
}
