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
        if let value = displayValue{
            displayValue = brain.pushOnStack(value)
        }
        else{
            displayValue = 0
        }
    }
    
    var displayValue: Double?{
        get{
            if let number = NSNumberFormatter().numberFromString(display.text!){
                return number.doubleValue
            }
            else {
               return nil
            }
            
        }
        set{
            if let text = newValue{
                display.text = "\(text)"
                userIsTyping = false
            }
            else {
                display.text = ""
                userIsTyping = false
            }
            
            
            
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
        brain.empty()
        displayValue = 0
    }
    
    
   
  

}


