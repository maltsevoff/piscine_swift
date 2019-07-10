//
//  SecondViewController.swift
//  day02
//
//  Created by Oleksandr MALTSEV on 6/26/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "backSegue" {
//            if let vc = segue.destination as? ViewController {
//                vc.title = "Back from 2nd view"
//            }
//        }
//    }
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var desc: UITextView!
    
    @IBAction func pressedDoneButton(_ sender: UIBarButtonItem) {
        if name.text != "" {
            let formattedDate = DateFormatter()
            formattedDate.dateStyle = DateFormatter.Style.short
            print("\(name.text!) \(formattedDate.string(from: date.date)) \(desc.text!)")
            Data.people.append((name.text!, formattedDate.string(from: date.date), desc.text!))
            performSegue(withIdentifier: "backSegue", sender: "Foo")
        }
    }
    
    @IBAction func backButton() {
        performSegue(withIdentifier: "backSegue", sender: "Foo")
    }   
}
