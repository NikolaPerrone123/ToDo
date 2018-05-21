//
//  TaskCreateEditVC.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/15/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit
import TTSegmentedControl

class TaskCreateEditVC: UIViewController {
    
    // UIViews
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
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var submitDateButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segmentControl: TTSegmentedControl!
    
    // Constraints
    @IBOutlet weak var descriptionTextViewConstraints: NSLayoutConstraint!
    @IBOutlet weak var bottomDatePickerConstraints: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextViewHeight: NSLayoutConstraint!


    private var open: Bool = true
    private var beginBottomConstraintsDatePicker: CGFloat?
    private var shouldResizeTextView = true
    private var dateTag: Int = 0
    private let priorityVCIdentifier = "taskPriorityVC"
    private let attachedVCIdentifier = "taskAttachedVC"
    private var attachedImages = [UIImage]()
    private var sharedInfo = SharedInfo.sharedInstance
    private var initTextViewHeightConstraint = CGFloat()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        
    }
    
    func setViews(){
        beginBottomConstraintsDatePicker = bottomDatePickerConstraints.constant
        self.descriptionTextView.delegate = self
        setButtons()
        descriptionTextView.layer.cornerRadius = 15
        setSpecConstraints()
        addGesture()
        Utilities.createSegmenStatusContorl(segment: segmentControl)
        initTextViewHeightConstraint = self.descriptionTextViewHeight.constant
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
        
        if sharedInfo.device == .iPhonePlus || sharedInfo.device == .iPhoneX {
            self.descriptionTextViewConstraints.constant = self.descriptionTextViewConstraints.constant + 60
        }
    }
    
    func addGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presOverlayAction))
        self.overlayView.addGestureRecognizer(gesture)
    }
    
    func animateSpring(damping : CGFloat, velocity : CGFloat){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: Animation for Date Picker
    func openDatePicker(open: Bool) {
        if open == true {
            if sharedInfo.device == .iPhoneX {
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
        let priorityVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: priorityVCIdentifier) as! TaskPriorityVC
        priorityVC.delegate = self
        present(priorityVC, animated: true, completion: nil)
    }
    
    @IBAction func submitDateAction(_ sender: UIButton) {
        openDatePicker(open: open)
        open = !open
        let dateString = Utilities.getDateFromDatePicker(datePicker: datePicker)
        dateTag == 1 ? createDateButton.setTitle("    " + dateString, for: .normal) : estimateDateButton.setTitle("    " + dateString, for: .normal)
        dateTag = 0
    }
    
    @IBAction func createDateAction(_ sender: UIButton) {
        openDatePicker(open: open)
        open = !open
        dateTag = 1
    }
    
    @IBAction func estimateDateAction(_ sender: UIButton) {
        openDatePicker(open: open)
        open = !open
        dateTag = 2
    }
    
    @IBAction func addAtachedAction(_ sender: UIButton) {
        let taskAtachedVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: attachedVCIdentifier) as! TaskAttachedVC
        taskAtachedVC.delegate = self
        taskAtachedVC.imagesData = self.attachedImages
        self.navigationController?.pushViewController(taskAtachedVC, animated: true)
    }
    
    @IBAction func expandTextViewAction(_ sender: Any) {
        if self.shouldResizeTextView == true {
            Utilities.resizeDescriptionView(constraints: self.descriptionTextViewHeight, textView: self.descriptionTextView)
            self.arrowButton.imageView!.image = UIImage(named: "collapse_arrow")
            self.animateSpring(damping: 0.5, velocity: 0.6)
        } else {
            self.descriptionTextViewHeight.constant = initTextViewHeightConstraint
            self.arrowButton.imageView!.image = UIImage(named: "expand_arrow")
            self.animateSpring(damping: 0.5, velocity: 0.6)
        }
        self.shouldResizeTextView = !shouldResizeTextView
    }
    
    @objc func presOverlayAction(){
        openDatePicker(open: open)
        open = !open
    }
}

extension TaskCreateEditVC: TasKPriorityDelegate {
    func getPriority(priority: String, backGroundColor: UIColor) {
         self.choosePriorityButton.setTitle(priority, for: .normal)
        self.choosePriorityButton.backgroundColor = backGroundColor
    }
}

extension TaskCreateEditVC: TaskAttachedDelegate {
    func getImages(images: [UIImage]) {
        self.attachedItemsLabel.text = attachmentCountText + String(images.count)
        self.attachedImages = images
    }
}

extension TaskCreateEditVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.descriptionTextView {
            self.shouldResizeTextView = false
            Utilities.resizeDescriptionView(constraints: self.descriptionTextViewHeight, textView: self.descriptionTextView)
            self.animateSpring(damping: 0.5, velocity: 0.6)
        }
    }
}

