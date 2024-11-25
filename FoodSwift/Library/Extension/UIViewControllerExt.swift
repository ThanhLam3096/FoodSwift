//
//  UIViewControllerExt.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 15/10/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: App.String.connectAPI, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: App.String.alertAction, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showAlertCreateAccount(emailAccount: String, isSuccess: Bool) {
        let alert = UIAlertController(title: App.String.createAccount, message: emailAccount + (isSuccess ? " Success" : " Faild"), preferredStyle: .alert)
        let nextAction = UIAlertAction(title: isSuccess ? App.String.continueAction : App.String.cancelString, style: .default) { _ in
            if isSuccess {
                self.navigationController?.pushViewController(ScreenName.definePhoneNumber, animated: true)
            } else {
                return
            }
        }
        alert.addAction(nextAction)
        self.present(alert, animated: true)
    }
    
    func alertAddIntructions(completion: @escaping(String) -> Void) {
        if self.presentedViewController == nil {
            let alert = UIAlertController(title: App.String.titleAddInstructions, message: nil, preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.placeholder = "Add Here"
                textField.keyboardType = .default
            }
            
            let okAction = UIAlertAction(title: App.String.okString, style: .default) { _ in
                let addIntructionsString = alert.textFields?.first?.text
                guard let addIntructionsString = addIntructionsString else { return }
                completion(addIntructionsString)
            }
            
            alert.addAction(okAction)
            alert.addAction(UIAlertAction(title: App.String.cancelString, style: .destructive, handler: nil))
            self.present(alert, animated: true)
        } else {
            print("Alert is Already Show")
        }
    }
    
    func pushFromBottom(to viewController: UIViewController, from currentViewController: UIViewController) {
        // Tạo CATransition
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromTop
        currentViewController.navigationController?.view.layer.add(transition, forKey: kCATransition)
        currentViewController.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func popToPreviousScreen(from currentViewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromBottom
        currentViewController.navigationController?.view.layer.add(transition, forKey: kCATransition)
        currentViewController.navigationController?.popViewController(animated: false)
    }
}
