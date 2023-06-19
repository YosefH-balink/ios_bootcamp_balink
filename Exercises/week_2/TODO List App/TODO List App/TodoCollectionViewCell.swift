//
//  TodoCollectionViewCell.swift
//  TODO List App
//
//  Created by Balink on 18/06/2023.
//

import UIKit

class TodoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var todo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    func setup(todo:ToDoItem){
        self.todo.text = todo.title
    }
}
