//
//  Utilities.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/14/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import Foundation
import UIKit

enum Device {
    case iPhone8
    case iPhonePlus
    case iPhoneX
}

open class Utilities: NSObject {
    
    class func getDevice(view: UIView) -> Device {
        
        let height = view.frame.size.height
        var device = Device.iPhone8
        
        if height == 716 {
             device = Device.iPhonePlus
        } else if height == 812 {
             device = Device.iPhoneX
        } else if height == 667 {
             device = Device.iPhone8
        }
        return device
    }
    
    class func setRadiusButton(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
    }
    
    class func setButtonWithoutBorder(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.borderColor = UIColor.black.cgColor
    }
}
