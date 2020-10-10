//
//  SuggestionTableViewCell.swift
//  Image Finder
//
//  Created by Pritam Hazra on 10/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import UIKit

class SuggestionTableViewCell: UITableViewCell {

    //MARK: - Variables
    
    //MARK: - Outlets
    @IBOutlet weak var suggestionLabel: UILabel!
    
    //MARK: - Fuctions
    
    /// To Set the suggestion in the cell
    /// - Parameter suggestion: Suggestion String
    func setUI(suggestion: String) {
        suggestionLabel.text = suggestion
    }
}
