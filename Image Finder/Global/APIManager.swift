//
//  NetworkManager.swift
//  Image Finder
//
//  Created by Pritam Hazra on 08/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import Foundation
import Alamofire

/// Base Url for search Image
let BASE_URL = "https://pixabay.com/api/"

/// Pixabay API Key for search Image
let API_KEY = "18622286-237b0ee15e59ddd770d8604be"


/// Will call GET API
/// - Parameters:
///   - urlString: the total get url to be called, nothing will be modified inside
///   - completion: return the Data of type T, which is generic and codable
func callGetAPI<T:Codable>(_ urlString: String, _ completion: @escaping (Bool,String,T?) -> Void){
    
    let request = AF.request(urlString, method: .get)
    
    request.responseDecodable(of: T.self) { (response) in
        guard let res = response.value else {
            completion(false, response.error?.errorDescription ?? "", nil)
            return }
        completion(true, "Success", res)
    }
}


