//
//  ViewController.swift
//  myfirstApp-calculator
//
//  Created by Balink on 13/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var line1: UITextField!
    @IBOutlet weak var line2: UITextField!
    
    
    var calculaterLine1: Double = 0 {
        didSet {
            line1.text = String(format:"%0.0f", calculaterLine1)
        }
    }
    
    var calculaterLine2: Double = 0  {
        didSet {
            line2.text = String(format:"%0.0f", calculaterLine2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let num = Double(sender.currentTitle!)

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
    @IBAction func aporatersPressed(_ sender: UIButton) {
        aporatersType = (sender.currentTitle!)
        preestAporater = !preestAporater
    }
    
    var eqwalsPressed:Bool = false
    @IBAction func eqwals(_ sender: Any) {
        eqwalsPressed = true
        switch aporatersType {
        case "+":
            calculaterLine2 = calculaterLine1 + calculaterLine2
            calculaterLine1 = 0
        case "-":
            calculaterLine2 = calculaterLine1 - calculaterLine2
            calculaterLine1 = 0
        case "x":
            calculaterLine2 = calculaterLine1 * calculaterLine2
            calculaterLine1 = 0
        case "/":
            line2.text = String(calculaterLine1 / calculaterLine2)
            calculaterLine1 = 0
        default: break
            
        }
        line1.text = ""
        print(calculaterLine1,aporatersType,calculaterLine2)
    }
    
    @IBAction func clear(_ sender: Any) {
        preestAporater = false
        calculaterLine1 = 0
        calculaterLine2 = 0
        line2.text = ""
    }
}

