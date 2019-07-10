//
//  SecondViewController.swift
//  rush00_1
//
//  Created by Oleksandr MALTSEV on 6/30/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit

class SecondViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forumCell", for: indexPath) as? TableViewCell
        cell?.topic = topics[indexPath.row]
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(topics)
    }
 
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        self.tableView.reloadData()
//    }
}
