//
//  PostTitlesViewController.swift
//  BlogPostApp
//
//  Created by Balink on 25/06/2023.
//

import UIKit
import Combine



class PostTitlesViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleTable: UITableView!
    
    var viewModel = PostTitlesViewModelWithCombine()
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getPostFromServer()
        cancellable = viewModel.objectWillChange.sink(receiveValue: { [weak self] in
            DispatchQueue.main.async {
                self?.titleTable.reloadData()
            }
        })
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getnumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        cell.textLabel?.text = viewModel.getCellTitle(index: indexPath.row).getTitle()
        return cell
    }
    
    
    
    
    
    
    
    
    
//    var myTitles: PostTitlesViewModel?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        Task{
//            do {
//                myTitles = PostTitlesViewModel()
//                try await myTitles?.getPostTitles()
//                titleTable.reloadData()
//            } catch let error as ServerError {
//                print(error)
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return  myTitles?.getnumberOfRows() ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
//        cell.textLabel?.text = myTitles?.getCellTitle(index: indexPath.row).getTitle()
//        return cell
//    }
}
