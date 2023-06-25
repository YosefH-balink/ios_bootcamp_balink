//
//  PostTitlesViewController.swift
//  BlogPostApp
//
//  Created by Balink on 25/06/2023.
//

import UIKit

class PostTitlesViewController:UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var posts:[Post]?
    
    @IBOutlet weak var titleTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            do {
                try posts = await DataService.shared.fetchPosts()
                titleTable.reloadData()
            } catch let error as ServerError {
                print(error)
            }
        }
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts?.count ?? 0
        }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
            cell.textLabel?.text = posts?[indexPath.row].title
            return cell
        }
}
