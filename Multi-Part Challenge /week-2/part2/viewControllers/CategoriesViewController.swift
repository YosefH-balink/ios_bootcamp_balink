//
//  CategoriesViewController.swift
//  part2
//
//  Created by Balink on 22/06/2023.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    var name:String?
    var products:[Product]?
    var categories:[String] = []
    var unique:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self,  forCellReuseIdentifier: "productCell")
        
        for product in products! {
            categories.append(product.category!)
        }
        unique = Array(Set(categories))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unique.count
    }
    
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        cell.textLabel?.text = unique[indexPath.row]
        return cell
    }
}
