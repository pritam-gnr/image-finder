//
//  ImageTableViewCell.swift
//  Image Finder
//
//  Created by Pritam Hazra on 09/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageTableViewCell: UITableViewCell {

    //MARK: - Variables
    
    //MARK: - Outlets
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var downloads: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    
    
    //MARK: - Fuctions
    
    /// To set the image details in the cell
    /// - Parameter item: details of the image
    func setUI(item: ImageDetails) {
        imagePreview.image = #imageLiteral(resourceName: "default-placeholder-image")
        if (item.previewURL ?? "") != "" {
            imagePreview.af.setImage(withURL: URL(string: item.previewURL ?? "")!, runImageTransitionIfCached: true, completion: nil)
        }else{
            imagePreview.image = #imageLiteral(resourceName: "default-placeholder-image")
        }
        userImage.image = #imageLiteral(resourceName: "dummy450x450")
        if (item.userImageURL ?? "") != "" {
            userImage.af.setImage(withURL: URL(string: item.userImageURL ?? "")!, runImageTransitionIfCached: true, completion: nil)
        }else{
            userImage.image = #imageLiteral(resourceName: "dummy450x450")
        }
        name.text = item.user
        tags.text = item.tags
        views.text = "\(item.views ?? 0)"
        downloads.text = "\(item.downloads ?? 0)"
        likes.text = "\(item.likes ?? 0)"
        comments.text = "\(item.comments ?? 0)"
    }
    
}
