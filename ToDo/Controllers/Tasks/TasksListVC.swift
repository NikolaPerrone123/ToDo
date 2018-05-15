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
    @IBOutlet weak var tasksTableView: UITableView!
    
    private let segmentTitles = ["To Do", "Active", "Test", "Done"]
    private let taskCellIdentifier = "TaskTableViewCell"
    private var tasks = ["1","2","3","f","f","g","g","g"]
    private let taskCreateEditVCIdentifier = "taskCreateEditVC"
    private let taskDetailsVCIdentifier = "taskDetailsVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setViews()
    }
    
    func setViews() {
        Utilities.setButtonWithoutBorder(button: okSearchButton)
        setSegmentControl()
        setTableView()
    }
    
    func setSegmentControl() {
        segmentControl.itemTitles = segmentTitles
        segmentControl.allowChangeThumbWidth = false
        segmentControl.containerBackgroundColor = orangeColorForTextField
        segmentControl.selectedTextColor = UIColor.black
        segmentControl.thumbGradientColors = [brownColorForButton]
        segmentControl.thumbColor = brownColorForButton
    }
    
    func setTableView(){
        self.tasksTableView.delegate = self
        self.tasksTableView.dataSource = self
        self.tasksTableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.tasksTableView.register(UINib.init(nibName: taskCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: taskCellIdentifier)
    }
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        let addCreateVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: taskCreateEditVCIdentifier) as! TaskCreateEditVC
        self.navigationController?.pushViewController(addCreateVC, animated: true)
    }
}

// MARK: Table View Data Source
extension TasksListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: taskCellIdentifier, for: indexPath) as! TaskTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: Table View Delegate
extension TasksListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select \(indexPath.row)")
        let taskDetailsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: taskDetailsVCIdentifier) as! TaskDetailsVC
        self.navigationController?.pushViewController(taskDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tasksTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
