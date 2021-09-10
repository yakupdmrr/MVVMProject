//
//  Extensions.swift
//  MVVMProject
//
//  Created by Yakup Demir on 17.07.2021.
//

import Foundation
import UIKit

extension UIButton{
    @IBInspectable var cornerRadius:CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
