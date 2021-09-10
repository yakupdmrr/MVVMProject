//
//  Utility.swift
//  MVVMProject
//
//  Created by Yakup Demir on 17.07.2021.
//

import Foundation
import UIKit
class Utility {
    
    static let instance = Utility()
    func makeAlert(title:String,message:String,uiViewController:UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        uiViewController.present(alert, animated: true, completion: nil)
            
    }
}
