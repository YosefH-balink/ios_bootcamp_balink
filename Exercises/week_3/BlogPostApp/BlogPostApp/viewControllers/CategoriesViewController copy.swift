////
////  CategoriesViewController.swift
////  part2
////
////  Created by Balink on 22/06/2023.
////
//
//import UIKit
//
//class CategoriesViewController: UITableViewController {
//    
//    var posts:[Post]?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self,  forCellReuseIdentifier: "titleCell")
//
//        Task{
//            do {
//                try posts = await DataService.shared.fetchPosts()
//            } catch let error as ServerError {
//                print(error)
//            }
//        }
//        
//    }
//  
//    
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts?.count ?? 0
//    }
//    
//    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
//        cell.textLabel?.text = posts?[indexPath.row].title
//        return cell
//    }
//}
