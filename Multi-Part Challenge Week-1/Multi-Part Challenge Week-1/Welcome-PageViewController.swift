//
//  Welcome-PageViewController.swift
//  Multi-Part Challenge Week-1
//
//  Created by Balink on 15/06/2023.
//
let members = ["Yonathan Goriachnick=yonig@balink.net", "Alexander Bord=alexanderb@balink.net", "Amiram Elzam=amirame@balink.net", "Avraham Lewensohn=avrahaml@balink.net", "Benjamin Halimi=benjaminh@balink.net", "Eliachar Feig=eliacharf@balink.net", "Emmanuel Berdugo=emmanuelb@balink.net", "Ethan Benzennou=ethanb@balink.net", "Laura Atlan=lauraat@balink.net", "Mendi Brami=mendib@balink.net", "Moishie Krohn=moshek@balink.net", "Yakov Touati=yakovt@balink.net", "Yankel Melloul=yankelm@balink.net", "Yitzchak Schechter=yitzchaks@balink.net", "Yona Harel=yonah@balink.net", "Yosef Heifetz=yosefh@balink.net"]

import UIKit

class Welcome_PageViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCall", for: indexPath)
        cell.textLabel?.text =  members[indexPath.row].components(separatedBy: "=")[0]
        cell.imageView?.image = UIImage(named: "BA-Link")
        cell.detailTextLabel?.text = members[indexPath.row].components(separatedBy: "=")[1]
        cell.accessoryType = .none //.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "BA-Link Members"
    }
    
    public var name: String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome \(self.name ?? "" )"
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var nameLabel: UILabel!
   

}
