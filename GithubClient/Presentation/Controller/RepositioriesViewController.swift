//
//  RepositioriesViewController.swift
//  GithubClient
//
//  Created by Kamil Chmiel on 29.04.2018.
//  Copyright © 2018 Kamil Chmiel. All rights reserved.
//

import UIKit

class RepositioriesViewController: UITableViewController {

    var listOfRepositories: [Repository] = []
    var pickedReposity: Repository? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.rowHeight = 65
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfRepositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let repositoryCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        repositoryCell.title.text = listOfRepositories[indexPath.row].title
        repositoryCell.desc.text = listOfRepositories[indexPath.row].description

        return repositoryCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pickedReposity = listOfRepositories[indexPath.row]
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.repository = self.pickedReposity
            }
        }
    }

}
