//
//  ViewController.swift
//  TODO List App
//
//  Created by Balink on 18/06/2023.
//

import UIKit

class TodoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func addTodo(_ sender: UIBarButtonItem) {
        showAlert()
    }
    
    var todos:[Todos]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchTodos() {
        do {
            self.todos = try context.fetch(Todos.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodos()
        self.title = "Todo List"
        collectionView.dataSource = self
        collectionView.delegate = self
    }
 //for retaning the proper layout even after rotating the screen
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todos?.count ?? 0
    }
  //setting the cell's color and text
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoCell", for: indexPath)  as! TodoCollectionViewCell
        cell.backgroundColor = UIColor(
             red: .random(in: 0...1),
             green: .random(in: 0...1),
             blue: .random(in: 0...1),
             alpha: 0.3)
        cell.setup(todo: todos![indexPath.item])
        return cell
    }
 //seting the collectionView size and columns numbers
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let abjustedWidth = collectionViewWidth - spaceBetweenCells
        let width:CGFloat = floor(abjustedWidth / columns)
        return CGSize(width: width, height: 100)
    }
//seting the alert foe adding a new todo
    @objc private func showAlert() {
        let alert = UIAlertController(
              title: "Add Todo",
              message: "Add a new todo to your list",
              preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Enter A New Todo"
            field.returnKeyType = .continue
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // adding new todo to todo array in UserDefaults
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {_ in
            guard let fields =  alert.textFields, let todo = fields.first else {return}
            guard let newTodo = todo.text, !newTodo.isEmpty else {return}
            
            // create a new todo object
            let addTodo = Todos(context: self.context)
            addTodo.title = newTodo
            addTodo.id = UUID()
            // save the data
            do {
              try  self.context.save()
            } catch {
                
            }
            // Re-fetch the data
            self.fetchTodos()
        }))
        present(alert, animated: true)
    }
}
