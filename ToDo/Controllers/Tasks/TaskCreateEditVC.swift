//
//  TaskCreateEditVC.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/15/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class TaskCreateEditVC: UIViewController {
    
    @IBOutlet weak var choosePriorityButton: UIButton!
    @IBOutlet weak var assigneeWorkerButton: UIButton!
    @IBOutlet weak var addAtachementButton: UIButton!
    @IBOutlet weak var projectButton: UIButton!
    @IBOutlet weak var subTaskButton: UIButton!
    @IBOutlet weak var workerButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var estimateDateButton: UIButton!
    @IBOutlet weak var createDateButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var attachedItemsLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var descriptionTextViewConstraints: NSLayoutConstraint!
    @IBOutlet weak var bottomDatePickerConstraints: NSLayoutConstraint!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var submitDateButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private var open: Bool = true
    private var beginBottomConstraintsDatePicker: CGFloat?
    private var device: Device = Device.iPhone8

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        beginBottomConstraintsDatePicker = bottomDatePickerConstraints.constant
    }
    
    func setViews(){
        self.device = Utilities.getDevice(view: self.view)
        setButtons()
        descriptionTextView.layer.cornerRadius = 15
        setSpecConstraints()
        addGesture()
    }
    
    func setButtons(){
        Utilities.setRadiusButton(button: projectButton)
        Utilities.setRadiusButton(button: subTaskButton)
        Utilities.setRadiusButton(button: workerButton)
        Utilities.setButtonWithSpecRadius(button: estimateDateButton, radius: 15)
        Utilities.setButtonWithSpecRadius(button: createDateButton, radius: 15)
        Utilities.setButtonWithSpecRadius(button: submitDateButton, radius: 15)
        Utilities.setButtonWithSpecRadius(button: choosePriorityButton, radius: 15)
        Utilities.setButtonWithSpecRadius(button: assigneeWorkerButton, radius: 15)
        Utilities.setButtonWithSpecRadius(button: addAtachementButton, radius: 15)
        Utilities.setButtonWithSpecRadius(button: createButton, radius: 15)
    }
    
    func setSpecConstraints() {
        
        if device == .iPhonePlus || device == .iPhoneX {
            self.descriptionTextViewConstraints.constant = self.descriptionTextViewConstraints.constant + 60
        }
    }
    
    func addGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presOverlayAction))
        self.overlayView.addGestureRecognizer(gesture)
    }
    
    // MARK: Animation for Date Picker
    func openDatePicker(open: Bool) {
        if open == true {
            if self.device == .iPhoneX {
                self.bottomDatePickerConstraints.constant = 40
                self.overlayView.isHidden = false
            } else {
                self.bottomDatePickerConstraints.constant = 0
                self.overlayView.isHidden = false
            }
        } else {
            self.bottomDatePickerConstraints.constant = beginBottomConstraintsDatePicker!
            self.overlayView.isHidden = true
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Actions
    @IBAction func changePriorityAction(_ sender: UIButton) {
        
    }
    
    @IBAction func submitDateAction(_ sender: UIButton) {
        openDatePicker(open: open)
        open = !open
    }
    
    @IBAction func createDateAction(_ sender: UIButton) {
        openDatePicker(open: open)
        open = !open
    }
    
    @IBAction func estimateDateAction(_ sender: UIButton) {
        openDatePicker(open: open)
        open = !open
    }
    
    @objc func presOverlayAction(){
        openDatePicker(open: open)
        open = !open
    }
}
