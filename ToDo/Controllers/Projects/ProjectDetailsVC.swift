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
    @IBOutlet weak var expandButton: UIButton!
    
    private var sharedInfo = SharedInfo.sharedInstance
    private var shouldExpand = true
    private var initTextViewHeightConstraints = CGFloat()
    
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
        initTextViewHeightConstraints = heightDescriptionTextViewConstraints.constant
    }
    
    func animateSpring(damping : CGFloat, velocity : CGFloat){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func expandAction(_ sender: UIButton) {
        if shouldExpand == true {
            Utilities.resizeDescriptionView(constraints: self.heightDescriptionTextViewConstraints, textView: self.descriptionTextView)
            self.expandButton.imageView!.image! = #imageLiteral(resourceName: "collapse_arrow")
            self.animateSpring(damping: 0.5, velocity: 0.6)
        } else {
            self.heightDescriptionTextViewConstraints.constant = initTextViewHeightConstraints
            self.expandButton.imageView!.image! = #imageLiteral(resourceName: "expand_arrow")
            self.animateSpring(damping: 0.5, velocity: 0.6)
        }
        shouldExpand = !shouldExpand
    }
    
    
    func setSpecificConstraints() {
        if sharedInfo.device == .iPhonePlus {
            self.widthNameLabelConstraints.constant = self.widthNameLabelConstraints.constant + 16
            self.heightDescriptionTextViewConstraints.constant = self.heightDescriptionTextViewConstraints.constant + 30
        } else if sharedInfo.device == .iPhoneX {
            self.heightDescriptionTextViewConstraints.constant = self.heightDescriptionTextViewConstraints.constant + 50
        }
    }
}
