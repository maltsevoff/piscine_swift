//
//  ViewController.swift
//  ex02
//
//  Created by Oleksandr MALTSEV on 6/24/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!
    
    var stillTyping = false
    var dotIsPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray.count > 1 && valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                 displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        
        print(number)
        if (displayResultLabel.text?.count)! < 20 {
            if stillTyping && currentInput != 0 {
                displayResultLabel.text = displayResultLabel.text! + number
            } else {
                displayResultLabel.text = number
                stillTyping = true
            }
        }
    }
    
    @IBAction func equalitySighPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        dotIsPlaced = false
        print(sender.currentTitle!)
        switch operationSign {
        case "➕":
            operateWithTwoOperands{$0 + $1}
        case "➖":
            operateWithTwoOperands{$0 - $1}
        case "✖️":
            operateWithTwoOperands{$0 * $1}
        case "➗":
            operateWithTwoOperands{$0 / $1}
        default: break
        }
        if sender.currentTitle == "=" {
            firstOperand = 0
            secondOperand = 0
            stillTyping = false
            operationSign = ""
        }
    }
    
    @IBAction func operandPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        operationSign = ""
        dotIsPlaced = false
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        print(sender.currentTitle!)
        currentInput = -currentInput
        stillTyping = true
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResultLabel.text = "0."
        }
    }
}
