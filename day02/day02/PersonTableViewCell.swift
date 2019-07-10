//
//  PersonTableViewCell.swift
//  day02
//
//  Created by Oleksandr MALTSEV on 6/27/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var person: (String, String, String)? {
        didSet {
            if let p = person {
                nameLabel?.text = p.0
                yearLabel?.text = p.1
                descriptionLabel?.text = p.2
            }
        }
    }
}
