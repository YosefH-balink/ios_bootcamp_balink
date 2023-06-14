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
            line1.text = String(calculaterLine1)
        }
    }
    
    var calculaterLine2: Double = 0  {
        didSet {
            line2.text = String(calculaterLine2)
        }
    }
    
    var preestAporater:Bool = false
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        line1.text = String(0)
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let num = Double(sender.currentTitle!)
        if aporatersType != "" && eqwalsPressed == true{
            calculaterLine1 = 0
            calculaterLine2 = 0
        }
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
    
    @IBAction func aporatersPressed(_ sender: UIButton) {
        aporatersType = (sender.currentTitle!)
        preestAporater = !preestAporater
        print(aporatersType)
        
        
    }
    var eqwalsPressed:Bool = false
    @IBAction func eqwals(_ sender: Any) {
        eqwalsPressed = true
        switch aporatersType {
        case "+":
            line2.text = String(calculaterLine1 + calculaterLine2)
            calculaterLine1 = 0
        case "-":
            line2.text = String(calculaterLine1 - calculaterLine2)
            calculaterLine1 = 0
        case "x":
            line2.text = String(calculaterLine1 * calculaterLine2)
            calculaterLine1 = 0
        case "/":
            line2.text = String(calculaterLine1 / calculaterLine2)
            calculaterLine1 = 0
        default: break
            
        }
        print(calculaterLine1,aporatersType,calculaterLine2)
        
    }
    
}

