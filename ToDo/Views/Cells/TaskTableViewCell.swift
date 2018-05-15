//
//  TaskTableViewCell.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/15/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var dataCreatedLabel: UILabel!
    @IBOutlet weak var assignedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
