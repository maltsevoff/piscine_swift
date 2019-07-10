//
//  Article+CoreDataProperties.swift
//  omaltsev2019_Example
//
//  Created by Oleksandr MALTSEV on 7/4/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }
    
    override public var description: String {
        return "T: \(title ?? "error")\nContent: \(content ?? "error")\nLang: \(language ?? "error")\n"
    }
    
    @NSManaged public var content: String?
    @NSManaged public var title: String?
    @NSManaged public var language: String?
    @NSManaged public var image: NSData?
    @NSManaged public var creation_date: NSDate?
    @NSManaged public var mod_date: NSDate?
}
