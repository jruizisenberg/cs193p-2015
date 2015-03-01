//
//  ViewController.swift
//  Calculator
//
//  Created by Kyle Green on 2/25/15.
//  Copyright (c) 2015 Wistshire LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberInProgress = false
    var operandStack = Array<Double>()
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            numberInProgress = false
        }
    }
    
    @IBOutlet weak var display: UILabel!

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if numberInProgress {
            display.text = display.text! + digit
        } else {
            display.text = digit
            numberInProgress = true
        }
    }

    @IBAction func enter() {
        numberInProgress = false
        operandStack.append(displayValue)
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if numberInProgress {
            enter()
        }

        switch operation {
        case "×": performOperation {$1 * $0}
        case "÷": performOperation {$1 / $0}
        case "+": performOperation {$1 + $0}
        case "−": performOperation {$1 - $0}
        case "√": performOperation {sqrt($0)}
        default: break
        }
    }
    
    func performOperation(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
}

