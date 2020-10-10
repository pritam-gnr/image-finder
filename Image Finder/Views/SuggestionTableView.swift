//
//  SuggestionTableView.swift
//  Image Finder
//
//  Created by Pritam Hazra on 10/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import UIKit

class SuggestionTableView: UITableView {
    
    // MARK: - Variables
    var suggestions: [String] = []
    public var suggestionDelegate: SuggestionTableViewDelegate?
    
    // MARK: - Function
    
    /// Initial Setup of the tableview to be called after initialization
    public func setUp(){
        self.register(UINib(nibName: "SuggestionTableViewCell", bundle: Bundle(for: SuggestionTableViewCell.self)), forCellReuseIdentifier: "SuggestionTableViewCell")
        self.delegate = self
        self.dataSource = self
    }
    
    
    /// Check if any suggestion exist in local db starting with given key
    /// - Parameter searchKey: the user typed text
    public func checkForSuggestions(searchKey: String = "") {
        suggestions = readSuggestion(searchKey: searchKey)
        if suggestions.count > 0 {
            self.isHidden = false
        } else {
            self.isHidden = true
        }
        self.reloadData()
    }
}

protocol SuggestionTableViewDelegate {
    
    /// Whenever user select an suggestion this method will be called
    /// - Parameter searchKey: the suggestion text
    func suggestionDidSelect(searchKey:String)
}

