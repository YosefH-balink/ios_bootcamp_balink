//
//  CustomTodoAlert.swift
//  TODO List App
//
//  Created by Balink on 21/06/2023.
//

import UIKit

class CustomTodoView: UIView {

    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    @IBOutlet weak var close: UIButton!
    
    var todo: todo!{
        didSet{
            todoLabel?.text = todo.title
            isDoneSwitch?.isOn = todo.isDone
        }
    }
    
    
    
//    var todoTitle: String? {
//           get { return todoLabel?.text }
//           set { todoLabel?.text = newValue }
//       }
    
//    @IBAction func isDone(_ sender: UISwitch) {
//        if sender.isOn == true {
//
//        } else {
//
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = initSubviews()
    }

     @discardableResult func initSubviews() -> UIView {
         let view = Bundle.main.loadNibNamed("CustomTodoView", owner: self, options: nil)![0] as! UIView
         view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         view.frame = self.bounds
         addSubview(view)
         return view
     }
}
