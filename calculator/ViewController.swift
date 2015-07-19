//
//  ViewController.swift
//  calculator
//
//  Created by Alain Gall on 7/5/15.
//  Copyright (c) 2015 Alain Gall. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var display: UILabel!
    var userIsTyping = false
    var brain = CalculatorBrain()

    
    
    
    @IBAction func appendDigit(sender: UIButton) {
        if (!(sender.currentTitle! == "." && (display.text!.rangeOfString(".") != nil) )){
            var digit: String
            if (sender.currentTitle! == "π"){
                digit = "\(M_PI)"
            }
            else {
                digit = sender.currentTitle!
                
            }
        
        if userIsTyping {
          display.text = display.text! + digit
          userIsTyping = true
        }
        else {
            display.text = digit
            userIsTyping = true
        }
        }
    }
    
    
   
    @IBAction func enter() {
        userIsTyping = false
        if let result = brain.pushOnStack(displayValue){
            displayValue = result
        } else{
            displayValue = 0
        }
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsTyping = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsTyping {
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        
      
        enter()
        
        }
    
    @IBAction func clear(sender: UIButton) {
        
    }
    
    
   
  

}


