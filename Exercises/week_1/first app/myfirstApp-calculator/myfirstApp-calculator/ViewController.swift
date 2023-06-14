//
//  ViewController.swift
//  myfirstApp-calculator
//
//  Created by Balink on 13/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var line1: UITextField!
    @IBOutlet weak var line2: UITextField!
    
    var calculaterLine1: Double = 0 {
        didSet {
          //  line1.text = String(format:"%0.0f", calculaterLine1)
            line1.text = String(calculaterLine1)
        }
    }
    var calculaterLine2: Double = 0  {
        didSet {
         //   line2.text = String(format:"%0.0f", calculaterLine2)
            line2.text = String(calculaterLine2)
        }
    }
  // action when a number is pressed to show in view
    @IBAction func numberPressed(_ sender: UIButton) {
        var num = Double(sender.currentTitle!)

        if !preestAporater{
            if calculaterLine1 == 0 {
                calculaterLine1 = num!
            }else{
                calculaterLine1 *= 10
                calculaterLine1 += num!
            }
        }
        else{
            if calculaterLine2 == 0 {
                calculaterLine2 = num!
            }else{
                calculaterLine2 *= 10
                calculaterLine2 += num!
            }
        }
    }
    
    var aporatersType: String = ""
    var preestAporater:Bool = false
    //action when a aporater is pressed
    @IBAction func aporatersPressed(_ sender: UIButton) {
        aporatersType = (sender.currentTitle!)
        preestAporater = !preestAporater
    }
    
    var history:[String] = []
    var eqwalsPressed:Bool = false
    var sum:Double = 0
    // action when the eqwals is pressed
    @IBAction func eqwals(_ sender: Any) {
        eqwalsPressed = true
        switch aporatersType {
        case "+":
            sum = calculaterLine1 + calculaterLine2
        case "-":
            sum = calculaterLine1 - calculaterLine2
        case "x":
            sum = calculaterLine1 * calculaterLine2
        case "/":
            sum = calculaterLine1 / calculaterLine2
        default: break
            
        }
        history.append("\(calculaterLine1) \(aporatersType) \(calculaterLine2) = \(sum)")
        calculaterLine2 = sum
        calculaterLine1 = 0
        line1.text = ""
    }
    // action when the clear is pressed
    @IBAction func clear(_ sender: Any) {
        preestAporater = false
        calculaterLine1 = 0
        calculaterLine2 = 0
        line2.text = ""
    }
}

