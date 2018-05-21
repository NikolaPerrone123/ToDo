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
    @IBOutlet weak var expandArrowButton: UIButton!
    
    private var sharedInfo = SharedInfo.sharedInstance
    private var shouldExpand = true
    private var initTextViewConstraints = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    func setViews() {
        setSpecificConstraints()
        Utilities.setRadiusButton(button: self.workersButton)
        Utilities.setRadiusButton(button: self.tasksButton)
        Utilities.setRadiusButton(button: self.createButton)
        self.descriptionTextView.layer.cornerRadius = 15
        self.descriptionTextView.delegate = self
        self.initTextViewConstraints = heightDescriptiontTextViewConstraints.constant
    }
    
    func setSpecificConstraints(){
        if sharedInfo.device == .iPhonePlus {
            self.widthTitleTextFieldConstraints.constant = self.widthTitleTextFieldConstraints.constant + 45
            self.heightDescriptiontTextViewConstraints.constant = self.heightDescriptiontTextViewConstraints.constant + 45
        } else if sharedInfo.device == .iPhoneX {
            self.heightDescriptiontTextViewConstraints.constant = self.heightDescriptiontTextViewConstraints.constant + 50
        }
    }
    
    func animateSpring(damping : CGFloat, velocity : CGFloat){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func expandAction(_ sender: UIButton) {
        if shouldExpand == true {
            Utilities.resizeDescriptionView(constraints: self.heightDescriptiontTextViewConstraints, textView: self.descriptionTextView)
            self.expandArrowButton.imageView!.image! = #imageLiteral(resourceName: "collapse_arrow")
            self.animateSpring(damping: 0.5, velocity: 0.6)
        } else {
            self.heightDescriptiontTextViewConstraints.constant = initTextViewConstraints
            self.expandArrowButton.imageView!.image! = #imageLiteral(resourceName: "expand_arrow")
            self.animateSpring(damping: 0.5, velocity: 0.6)
        }
        shouldExpand = !shouldExpand
    }
}

// MARK: Text View Delegate
extension ProjectCreateEditVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.descriptionTextView {
            Utilities.resizeDescriptionView(constraints: self.heightDescriptiontTextViewConstraints, textView: self.descriptionTextView)
            animateSpring(damping: 0.5, velocity: 0.6)
            shouldExpand = false
        }
    }
    
}
