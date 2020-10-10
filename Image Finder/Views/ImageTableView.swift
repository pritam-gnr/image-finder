//
//  ImageTableView.swift
//  Image Finder
//
//  Created by Pritam Hazra on 09/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import UIKit

class ImageTableView: UITableView {

    // MARK: - Variables
    private var refresh = UIRefreshControl()
    var images: [ImageDetails] = []
    var currentPage: Int = 1
    var total: Int = 0
    private var searchKey: String = ""
    private var callingAPI: Bool = false
    private var statusLabel: UILabel!
    
    // MARK: - Functions
    private func addRefreshControll(){
        refresh.attributedTitle = NSAttributedString(string: "Refreshing...")
        refresh.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.addSubview(refresh)
    }
    
    @objc private func refresh(_ sender: UIRefreshControl?) {
       // Code to refresh table view
        if searchKey != "" {
            searchImageFor(searchKey)
        }
        refresh.endRefreshing()
    }
    
    
    private func setUpStatusLabel(){
        statusLabel = UILabel()
        statusLabel.frame = CGRect(x: 30, y: 30, width: self.bounds.width - 60, height: 100)
        statusLabel.numberOfLines = 0
        statusLabel.textColor = .systemGray
        statusLabel.font = UIFont.systemFont(ofSize: 16)
        statusLabel.text = "Search Awsome Images..."
        statusLabel.textAlignment = .center
        self.addSubview(statusLabel)
    }
    
    
    /// Initial Setup of the tableview to be called after initialization
    public func setUp(){
        self.register(UINib(nibName: "ImageTableViewCell", bundle: Bundle(for: ImageTableViewCell.self)), forCellReuseIdentifier: "ImageTableViewCell")
        self.delegate = self
        self.dataSource = self
        addRefreshControll()
        setUpStatusLabel()
    }
    
    
    /// Search Images with specified text
    /// - Parameters:
    ///   - searchString: user specified text
    ///   - shouldInsert: Bool that specify if it should be inserted into db or not. Default true
    public func searchImageFor(_ searchString: String, shouldInsert: Bool = true){
        searchKey = searchString
        if callingAPI { return }
        callingAPI = true
        searchImage(searchString: searchString) { (status, searchImageResponse) in
            self.callingAPI = false
            if !status{ return }
            guard let total = searchImageResponse?.total else {
                return
            }
            self.total = total
            self.currentPage = 1
            guard let hits = searchImageResponse?.hits else {
                return
            }
            self.statusLabel.isHidden = true
            self.images = hits
            if self.images.count == 0 {
                self.statusLabel.isHidden = false
                self.statusLabel.text = "sorry! No image found."
            } else if shouldInsert {
                insertSuggestion(searchKey: self.searchKey)
            }
            self.reloadData()
        }
    }
    
    
    /// Load next page if any
    public func loadNextPage(){
        if callingAPI { return }
        callingAPI = true
        currentPage += 1
        searchImage(searchString: searchKey, page: currentPage) { (status, searchImageResponse) in
            self.callingAPI = false
            if !status{ return }
            guard let hits = searchImageResponse?.hits else {
                return
            }
            self.images.append(contentsOf: hits)
            self.reloadData()
        }
    }
}
