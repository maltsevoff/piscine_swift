//
//  ShapeClass.swift
//  day06
//
//  Created by Oleksandr MALTSEV on 7/2/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit

class ShapeClass: UIView {
    
    var figure: UIView?
    
    init (location: CGPoint) {
//        var circle = false
        let width: CGFloat = 100
        let height: CGFloat = 100
        super.init(frame: CGRect(x: location.x - (width / 2), y: location.y - (height / 2), width: width, height: height))
        figure = UIView(frame: CGRect(x: location.x - (width / 2), y: location.y - (height / 2), width: width, height: height))
        let randomColor = Int(arc4random_uniform(6))
        switch randomColor {
        case 0:
            figure?.backgroundColor = .red
        case 1:
            figure?.backgroundColor = .green
        case 2:
            figure?.backgroundColor = .gray
        case 3:
            figure?.backgroundColor = .blue
        case 4:
            figure?.backgroundColor = .yellow
        case 5:
            figure?.backgroundColor = .purple
        default:
            print("Error in Select Color")
        }
        
        let randomShape = Int(arc4random_uniform(2))
        switch randomShape {
        case 0:
            figure?.layer.cornerRadius = (figure?.frame.size.width ?? 2) / 2
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
