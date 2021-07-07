//
//  UIViewController+Extension.swift
//  PolymathLabs TechnicalChallenge
//
//  Created by Dion Dula on 2/26/21.
//

import UIKit
extension UIViewController {
    
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
