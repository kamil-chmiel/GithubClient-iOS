//
//  PickerPresenter.swift
//  GithubClient
//
//  Created by Kamil Chmiel on 04.05.2018.
//  Copyright © 2018 Kamil Chmiel. All rights reserved.
//

import Foundation

protocol PickerView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func showAlert(user: String)
    func setRepositories(repositories: [Repository])
}

class PickerPresenter {
    
    private var pickerView : PickerView?
    
    func attachView(view:PickerView){
        pickerView = view
    }
    
    func detachView() {
        pickerView = nil
    }
    
    func getRepositories(username: String) {
        pickerView?.startLoading()
        GithubAPI.url = "https://api.github.com/users/" + username + "/repos"
        let network = Network()
        let fetcher = RepositoriesFetcher(networking: network)
        fetcher.fetch { (repositories) in
            if repositories == nil {
                self.pickerView?.finishLoading()
                self.pickerView?.showAlert(user: username)
            }
            else {
                self.pickerView?.finishLoading()
                self.pickerView?.setRepositories(repositories: repositories!)
            }
        }
    }
}
