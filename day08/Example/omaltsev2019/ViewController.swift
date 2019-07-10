//
//  ViewController.swift
//  omaltsev2019
//
//  Created by maltsevoff on 07/04/2019.
//  Copyright (c) 2019 maltsevoff. All rights reserved.
//

import UIKit
import CoreData
import omaltsev2019


class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        var articles = manager.getAllArticles()
        print("All: \(articles)")
        article1()
        article2()
        article3()
        article4()
        manager.removeArticle(articles.last!)
        articles = manager.getArticles(containString: "hello")
        print("All2: \(articles.count)")
        manager.save()
//        manager.removeArticle(articles[0])
//        articles = manager.getAllArticles()
//        print("All3: \(articles)")
    }
    
    @IBAction func currentCountBtn(_ sender: UIButton) {
        let articles = manager.getAllArticles()
        resultLabel.text = "\(articles.count)"
        print(articles)
    }
    let manager = ArticleManager()
    
    func article1 () {
        let article = manager.newArticle()
        article.title = "Title1"
        article.content = "Content of 1"
        article.language = "en"
    }

    func article2 () {
        let article = manager.newArticle()
        article.title = "Title2"
        article.content = "Content of 2"
        article.language = "rus"
    }

    func article3 () {
        let article = manager.newArticle()
        article.title = "Title3"
        article.content = "Content of 3"
        article.language = "en"
    }

    func article4 () {
        let article = manager.newArticle()
        article.title = "Title3"
        article.content = "Content of 3"
        article.language = "en"
    }

}

