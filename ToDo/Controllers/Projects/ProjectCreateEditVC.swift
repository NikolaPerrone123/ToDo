//
//  ProjectCreateEditVC.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/14/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class ProjectCreateEditVC: UIViewController {

    @IBOutlet weak var widthTitleTextFieldConstraints: NSLayoutConstraint!
    @IBOutlet weak var heightDescriptiontTextViewConstraints: NSLayoutConstraint!
    @IBOutlet weak var workersButton: UIButton!
    @IBOutlet weak var tasksButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = self.view.frame.size.height
        print("Height \(height)")
        setViews()
    }
    
    func setViews() {
        setSpecificConstraints()
        Utilities.setRadiusButton(button: self.workersButton)
        Utilities.setRadiusButton(button: self.tasksButton)
        Utilities.setRadiusButton(button: self.createButton)
        self.descriptionTextView.layer.cornerRadius = 15
    }
    
    func setSpecificConstraints(){
        let device = Utilities.getDevice(view: self.view)
        if device == .iPhonePlus {
            self.widthTitleTextFieldConstraints.constant = self.widthTitleTextFieldConstraints.constant + 45
            self.heightDescriptiontTextViewConstraints.constant = self.heightDescriptiontTextViewConstraints.constant + 45
        } else if device == .iPhoneX {
            self.heightDescriptiontTextViewConstraints.constant = self.heightDescriptiontTextViewConstraints.constant + 50
        }
    }
    
}
