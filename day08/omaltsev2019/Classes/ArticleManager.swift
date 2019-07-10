//
//  ArticleManager.swift
//  omaltsev2019_Example
//
//  Created by Oleksandr MALTSEV on 7/4/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import CoreData

public class ArticleManager {
    
    public init () {
    }
    
    public let context: NSManagedObjectContext = {
        let urlsFM = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let appDocDirectory = urlsFM.last!
        let bundle = Bundle(for: ArticleManager.self)
        let modelURL = bundle.url(forResource: "article", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        let url = appDocDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    public func save() {
        do {
            try context.save()
        } catch let error {
            print ("Errror \(error.localizedDescription)")
        }
    }
    
    public func newArticle() -> Article {
        let article = Article(context: context)
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print("Error \(error.localizedDescription)")
//        }
        return article
    }
    
    public func getAllArticles() -> [Article] {
        var articles: [Article]!
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        context.performAndWait {
            articles = try! self.context.fetch(request) as! [Article]
        }
        return articles
    }
    
    public func getArticles(withLang lang: String) -> [Article] {
        var articles: [Article] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        request.predicate = NSPredicate(format: "language==%@", lang)
        do {
            try articles = self.context.fetch(request) as! [Article]
        } catch let error as NSError {
            print ("Errror \(error.localizedDescription)")
        }
        return articles
    }
    
    public func getArticles(containString str: String) -> [Article] {
        var articles: [Article] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        request.predicate = NSPredicate(format: "content CONTAINS[C] %@", str)
        do {
            try articles = context.fetch(request) as! [Article]
        } catch let error as NSError {
            print ("Error \(error.localizedDescription)")
        }
        return articles
    }
    
    public func removeArticle(_ article: Article) {
        context.delete(article)
        self.save()
        /*var articles: [Article] = []
        articles = getAllArticles()
        do {
            let index = try articles.index(of: article)!
            articles.remove(at: index)
            try context.save()
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }*/
    }
}
