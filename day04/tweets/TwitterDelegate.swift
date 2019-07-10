//
//  TwitterDelegate.swift
//  tweets
//
//  Created by Oleksandr MALTSEV on 6/28/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import Foundation

protocol APITwitterDelegate {
    func Tweets (tweet: [Tweet])
    func error (error: NSError)
}

class APIController {
    weak var delegate: APITwitterDelegate?
    let token: String = ""
}
