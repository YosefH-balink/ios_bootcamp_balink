//
//  ViewController.swift
//  FetchPostsFromAPI
//
//  Created by Balink on 19/06/2023.
//

import UIKit

class ViewController: UIViewController {

    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get post from DataService
        
        Task{
             do{
                 posts = try await DataService.shared.fetchPosts()
                 print(posts)
             }catch{
                  print(error)
             }
        }
//        DataService.fetchPosts(onFetch: { result in
//            DispatchQueue.main.async {
//                switch result {
//                   case .success(let posts):
//                     self.posts = posts
//                    // need to add posts to TabelView and update the view
//                   case .failure(let error):
//                    // add alert to user
//                    print(error)
//                }
//            }
//        })
    }
}

