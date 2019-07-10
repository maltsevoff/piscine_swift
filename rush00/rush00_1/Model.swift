//
//  Model.swift
//  rush00_1
//
//  Created by Oleksandr MALTSEV on 6/30/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import Foundation

struct Topic {
    var title: String?
    var author: String?
    var date: String?
}

struct InsideTopic {
    var title: String?
    var author: String?
    var date: String?
    var topicText: String?
}

var topics: [Topic] = []
