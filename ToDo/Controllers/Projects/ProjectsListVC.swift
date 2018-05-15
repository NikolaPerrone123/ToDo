//
//  ProjectsListVC.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/13/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class ProjectsListVC: UIViewController {

    private let projectCellIdentifier = "ProjectTableViewCell"
    private let projectDetailsVC = "projectDetailsVC"
    private var projects = [String]()
    
    @IBOutlet weak var projectTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setArrayOfProjects()
        setTable()
    }
    
    func setTable() {
        self.projectTable.dataSource = self
        self.projectTable.delegate = self
        self.projectTable.estimatedRowHeight = UITableViewAutomaticDimension
        self.projectTable.register(UINib.init(nibName: projectCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: projectCellIdentifier)
        self.tabBarController?.tabBar.tintColor = UIColor.black
    }
    
    func setArrayOfProjects() {
        for _ in 1...20 {
            projects.append("A")
        }
    }
    
    @objc func viewDetailsAction() {
        let projectDetailsVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: self.projectDetailsVC) as! ProjectDetailsVC
        self.navigationController?.pushViewController(projectDetailsVC, animated: true)
    }
}

// MARK: Table View Data Source
extension ProjectsListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: projectCellIdentifier, for: indexPath) as! ProjectTableViewCell
        cell.viewDetailsButton.addTarget(self, action: #selector(viewDetailsAction), for: .touchUpInside)
        return cell
    }
}

// MARK: Table View Delegate
extension ProjectsListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select row at: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
