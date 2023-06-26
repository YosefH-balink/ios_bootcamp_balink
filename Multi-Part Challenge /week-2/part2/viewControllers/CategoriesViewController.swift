//
//  CategoriesViewController.swift
//  part2
//
//  Created by Balink on 22/06/2023.
//

import UIKit

class CategoriesViewController: UITableViewController {
   
    var products:[Product]?
    var categories:[String] = []
    var unique:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // sends the token to server to retrieve listt of products
        Task {
            do {
                if let token = UserDefaults.standard.string(forKey: "token") {
                    print("token-->", token)
                    try products = await DataService.shared.getProducts(token: token)
                    print("products----", products!)
                    for product in products! {
                        categories.append(product.category!)
                    }
                    unique = Array(Set(categories))
                    print("unique---->",  unique)
//                    DispatchQueue.main.async {
//                        self.view.reloadInputViews()
//                    }
                }
            } catch let error as ServerError {
               // showAlert(message: error.message)
            }
        }
        tableView.register(UITableViewCell.self,  forCellReuseIdentifier: "productCell")
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
