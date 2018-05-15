//
//  TasksListVC.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/13/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit
import TTSegmentedControl

class TasksListVC: UIViewController {
    
    @IBOutlet weak var okSearchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var segmentControl: TTSegmentedControl!
    
    private let segmentTitles = ["To Do", "Active", "Test", "Done"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setSegmentControl()
    }
    
    override func viewDidLayoutSubviews() {
        setViews()
    }
    
    func setViews() {
        Utilities.setButtonWithoutBorder(button: okSearchButton)
    }
    
    func setSegmentControl() {
        segmentControl.itemTitles = segmentTitles
        segmentControl.allowChangeThumbWidth = false
        segmentControl.containerBackgroundColor = orangeColorForTextField
        segmentControl.selectedTextColor = UIColor.black
        segmentControl.thumbGradientColors = [brownColorForButton]
        segmentControl.thumbColor = brownColorForButton
    }
}
