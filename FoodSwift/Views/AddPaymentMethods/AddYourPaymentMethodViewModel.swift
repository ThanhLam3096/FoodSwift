//
//  AddYourPaymentMethodViewModel.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/11/24.
//

import Foundation

final class AddYourPaymentMethodViewModel {
    
    func formatCardNumber(currentText: String, range: NSRange, replacementString string: String) -> String {
        // Lấy text hiện tại và thêm ký tự mới
        var updatedText = currentText
        if let textRange = Range(range, in: currentText) {
            updatedText = updatedText.replacingCharacters(in: textRange, with: string)
        }
        
        // Loại bỏ tất cả dấu cách hiện có để định dạng lại
        let strippedText = updatedText.replacingOccurrences(of: " ", with: "")
        
        // Giới hạn ký tự tối đa (16 ký tự số thẻ)
        guard strippedText.count <= 16 else { return currentText }
        
        // Chia chuỗi thành các nhóm 4 ký tự
        var formattedText = ""
        for (index, character) in strippedText.enumerated() {
            if index != 0 && index % 4 == 0 {
                formattedText += " "
            }
            formattedText.append(character)
        }
        
        return formattedText
    }
    
    func formatCardExpired(currentText: String, range: NSRange, replacementString string: String) -> String {
        // Lấy text hiện tại và thêm ký tự mới
        var updatedText = currentText
        if let textRange = Range(range, in: currentText) {
            updatedText = updatedText.replacingCharacters(in: textRange, with: string)
        }
        
        // Loại bỏ tất cả dấu cách hiện có để định dạng lại
        let strippedText = updatedText.replacingOccurrences(of: "/", with: "")
        
        // Giới hạn ký tự tối đa (16 ký tự số thẻ)
        guard strippedText.count <= 4 else { return currentText }
        
        // Xử lý phần tháng (MM)
        var formattedText = ""
        if strippedText.count >= 2 {
            var monthSubstring = String(strippedText.prefix(2))
            if let month = Int(monthSubstring), month > 12 {
                monthSubstring = "12" // Đặt giá trị thành "12" nếu vượt quá
            }
            formattedText = monthSubstring
        } else {
            formattedText = strippedText // Nếu chưa đủ 2 ký tự thì giữ nguyên
        }
        
        // Thêm dấu gạch chéo và phần năm (YY) nếu có
        if strippedText.count > 2 {
            let yearSubstring = strippedText.suffix(from: strippedText.index(strippedText.startIndex, offsetBy: 2))
            formattedText += "/" + yearSubstring
        }
        
        return formattedText
    }
    
    func formatCardCVCNumber(currentText: String, range: NSRange, replacementString string: String) -> String {
        var updatedText = currentText
        if let textRange = Range(range, in: currentText) {
            updatedText = updatedText.replacingCharacters(in: textRange, with: string)
        }
        let strippedText = updatedText.replacingOccurrences(of: "/", with: "")
        guard strippedText.count <= 3 else { return currentText }
        
        var formattedText = ""
        for (index, character) in strippedText.enumerated() {
            formattedText.append(character)
        }
        
        return formattedText
    }
}
