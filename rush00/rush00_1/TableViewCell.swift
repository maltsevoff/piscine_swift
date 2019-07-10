//
//  TableViewCell.swift
//  rush00_1
//
//  Created by Oleksandr MALTSEV on 6/30/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
     
    var topic: (Topic)? {
        didSet {
            if let t = topic {
                loginLabel.text = t.author
                dataLabel.text = t.date
                nameLabel.text = t.title
            }
        }
    }
}
