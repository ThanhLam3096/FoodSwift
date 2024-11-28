//
//  KeyBoardObserver.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/11/24.
//

import Foundation
import UIKit

class KeyboardObserver {
    // Khai báo closure để callback khi bàn phím hiện hoặc ẩn
    var onKeyboardWillShow: ((_ keyboardHeight: CGFloat) -> Void)?
    var onKeyboardWillHide: (() -> Void)?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            onKeyboardWillShow?(keyboardHeight)  // Gọi callback khi bàn phím hiện
        }
    }
    
    @objc private func keyboardWillHide() {
        onKeyboardWillHide?()  // Gọi callback khi bàn phím ẩn
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
