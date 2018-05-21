//
//  Utilities.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/14/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import Foundation
import UIKit
import TTSegmentedControl

enum Device {
    case iPhone8
    case iPhonePlus
    case iPhoneX
}

open class Utilities: NSObject {
    
    class func setRadiusButton(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
    }
    
    class func setButtonWithoutBorder(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    class func setButtonWithSpecRadius(button: UIButton, radius: CGFloat) {
        button.layer.cornerRadius = radius
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
    }
    
    class func getDateFromDatePicker(datePicker: UIDatePicker) -> String {
        datePicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        print("Date: \(selectedDate)")
        return selectedDate
    }
    
    class func createSegmenStatusContorl(segment: TTSegmentedControl){
        segment.itemTitles = statusSegmentItems
        segment.allowChangeThumbWidth = false
        segment.containerBackgroundColor = orangeColorForTextField
        segment.selectedTextColor = UIColor.black
        segment.thumbGradientColors = [brownColorForButton]
        segment.thumbColor = brownColorForButton
        print("Segment radius: \(segment.cornerRadius)")
    }
    
    class func setConstraintsForTextView(heightConstraints: NSLayoutConstraint) {
        let device = SharedInfo.sharedInstance.device
        if device == .iPhonePlus || device == .iPhoneX {
            heightConstraints.constant = heightConstraints.constant + 60
        }
    }
    
    class func animateSpring(damping : CGFloat, velocity : CGFloat, view : UIView){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: UIViewAnimationOptions.curveEaseIn, animations: {
            view.layoutIfNeeded()
        }, completion: nil)
    }
    
    class func resizeDescriptionView(constraints: NSLayoutConstraint, textView : UITextView){
        let myTextHeight = CGFloat(ceilf(Float(Utilities.getLabelBoundsForTextfield(textView: textView).height))) + 12
        if myTextHeight >= minimumDescriptionHeight && myTextHeight <= maximumDescriptionHeight{
            constraints.constant = myTextHeight
            //self.animateSpring(damping: 0.6, velocity: 0.2)
        }
    }
    
    //Calculate how much height a text view text would take compared to the text lenght, font and textview width
    class func getLabelBoundsForTextfield(textView : UITextView) -> CGRect {
        let maximumLabelSize = CGSize(width: Double(textView.frame.size.width), height: Double.greatestFiniteMagnitude)
        _ = UInt8(NSStringDrawingOptions.truncatesLastVisibleLine.rawValue) | UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue)
        let attribute = [NSAttributedStringKey.font: textView.font!]
        return     textView.text!.boundingRect(with: maximumLabelSize,
                                               options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                               attributes: attribute,
                                               context: nil)
    }
}
