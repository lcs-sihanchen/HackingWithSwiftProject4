//
//  FirstViewController.swift
//  HackingWithSwiftProject4
//
//  Created by Chen, Sihan on 2020-03-22.
//  Copyright © 2020 Chen, Sihan. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController {

    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Website List"
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return websites.count
       }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)
        
        // This is what's shown in the cell (text)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
     
    // Have access to DetailView Controller
     if let VC = storyboard?.instantiateViewController(withIdentifier:"Detail") as? ViewController {
         
         // 2: success! Set its selectedImage property + number property and which picture property
        VC.theWebsites = websites
        VC.selectedWebsite = websites[indexPath.row]
         
         // 3: now push it onto the navigation controller
         navigationController?.pushViewController(VC, animated:
             true)
     } }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
