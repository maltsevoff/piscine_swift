//
//  TableViewCell.swift
//  day05
//
//  Created by Oleksandr MALTSEV on 7/1/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    
    var place: String? {
        didSet {
            if let pl = place {
                placeLabel.text = pl
            }
        }
    }

}
