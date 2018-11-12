//
//  DoneCell.swift
//  todoapp
//
//  Created by Preyansh Kotecha on 11/2/18.
//  Copyright © 2018 preyansh. All rights reserved.
//

import UIKit

class DoneCell: UITableViewCell {
    
    
    @IBOutlet weak var completedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
