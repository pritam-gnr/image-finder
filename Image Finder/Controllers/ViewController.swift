//
//  ViewController.swift
//  Image Finder
//
//  Created by Pritam Hazra on 08/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Variables
    private var loaded: Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var imageTableView: ImageTableView!
    @IBOutlet weak var imageSearchBar: UISearchBar!
    @IBOutlet weak var suggestionTableView: SuggestionTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !loaded {
            imageTableView.setUp()
            imageSearchBar.delegate = self
            suggestionTableView.setUp()
            suggestionTableView.suggestionDelegate = self
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
            loaded = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            suggestionTableView.frame.size.height = keyboardRectangle.origin.y - suggestionTableView.frame.origin.y
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        suggestionTableView.checkForSuggestions()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        suggestionTableView.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        suggestionTableView.checkForSuggestions(searchKey: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        imageTableView.searchImageFor(searchBar.text ?? "")
        searchBar.resignFirstResponder()
        suggestionTableView.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        suggestionTableView.isHidden = true
    }
}

extension ViewController: SuggestionTableViewDelegate {
    func suggestionDidSelect(searchKey: String) {
        imageTableView.searchImageFor(searchKey, shouldInsert: false)
        imageSearchBar.resignFirstResponder()
        suggestionTableView.isHidden = true
    }
}
