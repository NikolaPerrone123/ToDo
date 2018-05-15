//
//  LogInVC.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/9/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let height = self.view.frame.size.height
        print("Height \(height)")
       setButton()
    }

    @IBAction func okAction(_ sender: UIButton) {
        
    }
    
    func setButton(){
        okButton.layer.cornerRadius = okButton.frame.size.height / 2
        okButton.layer.borderWidth = 2.0
    }
}
