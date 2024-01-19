//
//  ToDoListTableViewCell.swift
//  ToDoListUIKit
//
//  Created by stu on 2024/1/16.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var showPriorityImage: UIImageView!
    
    @IBOutlet weak var todoTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
