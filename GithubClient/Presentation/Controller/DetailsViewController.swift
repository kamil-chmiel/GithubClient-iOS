//
//  DetailsViewController.swift
//  GithubClient
//
//  Created by Kamil Chmiel on 01.05.2018.
//  Copyright © 2018 Kamil Chmiel. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var pushedLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var privateLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    
    var repository: Repository? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        titleLabel.text = repository?.title
        descriptionLabel.text = repository?.description
        idLabel.text = idLabel.text! + " \(repository?.id ?? 0)"
        languageLabel.text = languageLabel.text! + " \(repository?.language ?? "-")"
        createdLabel.text = createdLabel.text! + " \(dateFormatter.string(from: (repository?.created)!))"
        updatedLabel.text = updatedLabel.text! + " \(dateFormatter.string(from: (repository?.updated)!))"
        pushedLabel.text = pushedLabel.text! + " \(dateFormatter.string(from: (repository?.pushed)!))"
        sizeLabel.text = sizeLabel.text! + " \(repository?.size ?? 0)KB"
        privateLabel.text = privateLabel.text! + " \(repository?.privacy ?? false)"
        licenseLabel.text = licenseLabel.text! + " \(repository?.license ?? "-")"
    }
}
