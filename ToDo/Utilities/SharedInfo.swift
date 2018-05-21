//
//  SharedInfo.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/21/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import Foundation
import UIKit

class SharedInfo {
    
    static let sharedInstance: SharedInfo = {
        let instance = SharedInfo()
        return instance
    }()
    
    public var device: Device = Device.iPhone8
    
    func getDevice(view: UIView) {
        
        let height = view.frame.size.height
        
        if height == 736 {
            self.device = Device.iPhonePlus
        } else if height == 812 {
            self.device = Device.iPhoneX
        } else if height == 667 {
            self.device = Device.iPhone8
        }
    }
    
    //private init (){}
}
