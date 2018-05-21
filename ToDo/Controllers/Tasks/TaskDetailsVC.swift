//
//  TaskDetailsVC.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/15/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit
import TTSegmentedControl

class TaskDetailsVC: UIViewController {
    
    @IBOutlet weak var attachmentsButton: UIButton!
    @IBOutlet weak var projectButton: UIButton!
    @IBOutlet weak var subTaskButton: UIButton!
    @IBOutlet weak var workersButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var estimateTimeLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var assigneLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var expnadArrowButton: UIButton!
    
    @IBOutlet weak var heightTextViewConstraint: NSLayoutConstraint!
    
    private var shouldExpand = true
    private var initTextViewHeightConstraint = CGFloat()
    private var attachmentsIdentifierVC = "taskAttachedVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    func setViews(){
        Utilities.setConstraintsForTextView(heightConstraints: heightTextViewConstraint)
        Utilities.setRadiusButton(button: projectButton)
        Utilities.setRadiusButton(button: subTaskButton)
        Utilities.setRadiusButton(button: workersButton)
        Utilities.setButtonWithSpecRadius(button: attachmentsButton, radius: 15)
        Utilities.setButtonWithSpecRadius(button: editButton, radius: 15)
        self.descriptionTextView.layer.cornerRadius = 15
        initTextViewHeightConstraint = self.heightTextViewConstraint.constant
    }
    
    func animateSpring(damping : CGFloat, velocity : CGFloat){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    
    @IBAction func expandAction(_ sender: UIButton) {
        if shouldExpand == true {
            Utilities.resizeDescriptionView(constraints: self.heightTextViewConstraint, textView: self.descriptionTextView)
            self.expnadArrowButton.imageView!.image! = #imageLiteral(resourceName: "collapse_arrow")
            self.animateSpring(damping: 0.5, velocity: 0.6)
        } else {
            self.heightTextViewConstraint.constant = initTextViewHeightConstraint
            self.expnadArrowButton.imageView!.image! = #imageLiteral(resourceName: "expand_arrow")
            self.animateSpring(damping: 0.5, velocity: 0.6)
        }
        shouldExpand = !shouldExpand
    }
    
    @IBAction func attachmentsAction(_ sender: UIButton) {
        let attachmentVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: attachmentsIdentifierVC) as! TaskAttachedVC
        self.navigationController?.pushViewController(attachmentVC, animated: true)
    }
}

