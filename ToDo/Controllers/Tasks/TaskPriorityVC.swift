//
//  TaskPriorityVC.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/16/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

protocol TasKPriorityDelegate {
    func getPriority(priority: String, backGroundColor: UIColor)
}

class TaskPriorityVC: UIViewController {

    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var heightButton: UIButton!
    
    public var delegate: TasKPriorityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    func setViews() {
        Utilities.setRadiusButton(button: lowButton)
        Utilities.setRadiusButton(button: mediumButton)
        Utilities.setRadiusButton(button: heightButton)
    }
    
    @IBAction func lowAction(_ sender: UIButton) {
        delegate?.getPriority(priority: "Low", backGroundColor: sender.backgroundColor!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mediumAction(_ sender: UIButton) {
        delegate?.getPriority(priority: "Medium", backGroundColor: sender.backgroundColor!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func heightAction(_ sender: UIButton) {
        delegate?.getPriority(priority: "Height", backGroundColor: sender.backgroundColor!)
        self.dismiss(animated: true, completion: nil)
    }
}
