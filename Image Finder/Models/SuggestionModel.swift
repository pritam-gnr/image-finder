//
//  SuggestionModel.swift
//  Image Finder
//
//  Created by Pritam Hazra on 10/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import Foundation


/// Insert one searched key into the local DB for next time suggestion
/// - Parameter searchKey: the key to be inserted
func insertSuggestion(searchKey: String){
    createData(entityName: "Suggestions", dictionary: ["searchKey": searchKey])
}

/// Return previously searched text as suggestion if any
/// - Parameter searchKey: user given search key typed in searchbar
/// - Returns: Array of suggestion string
func readSuggestion(searchKey: String) -> [String] {
    let sortBy = [SortBy(key: "date", ascending: false)]
    var dictArray: [[String: Any]] = []
    if searchKey == "" {
        dictArray = ReadData(entityName: "Suggestions", fetchLimit: 10, sortBy: sortBy)
    } else {
        let search = [SearchQuery(key: "searchKey", value: searchKey)]
        dictArray = ReadData(entityName: "Suggestions", search: search, fetchLimit: 10, sortBy: sortBy)
    }
    var suggestionStrings: [String] = []
    for dict in dictArray {
        suggestionStrings.append(dict["searchKey"] as! String)
    }
    return suggestionStrings
}
