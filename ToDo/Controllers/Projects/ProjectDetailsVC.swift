//
//  ProjectDetailsVC.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/14/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class ProjectDetailsVC: UIViewController {
    
    
    @IBOutlet weak var widthNameLabelConstraints: NSLayoutConstraint!
    @IBOutlet weak var heightDescriptionTextViewConstraints: NSLayoutConstraint!
    @IBOutlet weak var workersButton: UIButton!
    @IBOutlet weak var tasksButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        setViews()
    }
    
    func setViews() {
        setSpecificConstraints()
        Utilities.setRadiusButton(button: self.tasksButton)
        Utilities.setRadiusButton(button: self.workersButton)
        self.descriptionTextView.layer.cornerRadius = 15
    }
    
    func setSpecificConstraints() {
        let device = Utilities.getDevice(view: self.view)
        if device == .iPhonePlus {
            self.widthNameLabelConstraints.constant = self.widthNameLabelConstraints.constant + 16
            self.heightDescriptionTextViewConstraints.constant = self.heightDescriptionTextViewConstraints.constant + 30
        } else if device == .iPhoneX {
            self.heightDescriptionTextViewConstraints.constant = self.heightDescriptionTextViewConstraints.constant + 50
        }
    }
}
