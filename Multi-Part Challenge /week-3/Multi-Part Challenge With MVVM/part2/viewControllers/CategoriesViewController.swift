//
//  CategoriesViewController.swift
//  part2
//
//  Created by Balink on 22/06/2023.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    var categoriesViewModle: CategoriesViewModle?
    var categories:[String]?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self,  forCellReuseIdentifier: "productCell")
        Task {
            do {
                categoriesViewModle = CategoriesViewModle()
                categories = await categoriesViewModle?.fetchCategories()!
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        cell.textLabel?.text =  categories?[indexPath.row]
        return cell
    }
}

