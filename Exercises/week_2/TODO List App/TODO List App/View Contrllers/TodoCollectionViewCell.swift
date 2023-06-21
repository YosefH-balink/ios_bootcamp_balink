//
//  TodoCollectionViewCell.swift
//  TODO List App
//
//  Created by Balink on 18/06/2023.
//

import UIKit

class TodoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var todo: UILabel!
    
    @IBOutlet weak var isDone: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    func setup(todo:Todos ){
        self.todo.text = todo.title
        self.isDone.isOn = todo.completed
    }
}
