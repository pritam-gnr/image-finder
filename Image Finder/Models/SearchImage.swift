//
//  SearchImage.swift
//  Image Finder
//
//  Created by Pritam Hazra on 08/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import Foundation
import ProgressHUD

/// Image Details Model: will holds the details of individuala image
struct ImageDetails: Codable {
    var id: Int?
    var pageURL: String?
    var type, tags: String?
    var previewURL: String?
    var previewWidth, previewHeight: Int?
    var webformatURL: String?
    var webformatWidth, webformatHeight: Int?
    var largeImageURL: String?
    var imageWidth, imageHeight, imageSize, views: Int?
    var downloads, favorites, likes, comments: Int?
    var userID: Int?
    var user: String?
    var userImageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, favorites, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
}

/// The response model of each search API calling
struct SearchImageResponse: Codable {
    var total: Int?
    var totalHits: Int?
    var hits: [ImageDetails]?
}


/// It will search image from Pixabay with search key and page no, if page is greater than 1
/// - Parameters:
///   - searchString: User given search input
///   - page: internally managed page no if total page greater than 1, default 1
///   - completion: Will be called after getting result
func searchImage(searchString: String, page: Int = 1, _ completion: @escaping (Bool,SearchImageResponse?)->Void){
    let escapedString : String = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    let urlString = BASE_URL + "?key=" + API_KEY + "&image_type=photo&page=\(page)&q=\(escapedString)"
    
    ProgressHUD.show()
    callGetAPI(urlString) { (status, errorMessage, response: SearchImageResponse?) in
        ProgressHUD.dismiss()
        if !status {
            print(errorMessage)
            Utility.showAlertView(title: "Error", msg: errorMessage, controller: Utility.getTopViewController()) {}
            completion(false, nil)
            return
        }
        guard let searchResponse = response else {
            Utility.showAlertView(title: "Error", msg: "An internal error occured", controller: Utility.getTopViewController()) {}
            completion(false, nil)
            return
        }
        completion(true, searchResponse)
    }
}
