//
//  ViewController.swift
//  GithubClient
//
//  Created by Kamil Chmiel on 27.04.2018.
//  Copyright © 2018 Kamil Chmiel. All rights reserved.
//

import UIKit
import SVProgressHUD

class PickerViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    var fetchedRepositories: [Repository]? = []
    let presenter = PickerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }

    @IBAction func showPressed(_ sender: UIButton) {
        presenter.getRepositories(username: usernameField.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRepositories" {
            if let repositoriesVC = segue.destination as? RepositioriesViewController {
                repositoriesVC.listOfRepositories = fetchedRepositories!
            }
        }
    }
}

extension PickerViewController: PickerView {
    func startLoading() {
        SVProgressHUD.show()
    }
    
    func finishLoading() {
        SVProgressHUD.dismiss()
    }
    
    func showAlert(user: String) {
        let alert = UIAlertController(title: "Wrong username", message: "User \(user) does not exist", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setRepositories(repositories: [Repository]) {
        fetchedRepositories = repositories
        self.performSegue(withIdentifier: "goToRepositories", sender: nil)
    }
}

