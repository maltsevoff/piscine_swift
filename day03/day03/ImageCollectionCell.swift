//
//  ImageCollectionCell.swift
//  day03
//
//  Created by Oleksandr MALTSEV on 6/27/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var image: Data?
    {
        didSet {
//            let url = URL(string: image!)
//                let data = try? Data(contentsOf: url!)
            imageView.image = UIImage(data: image!)
        }
    }
}
