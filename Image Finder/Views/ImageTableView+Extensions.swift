//
//  ImageTableView+Extensions.swift
//  Image Finder
//
//  Created by Pritam Hazra on 09/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import Foundation
import UIKit
import Lightbox

extension ImageTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        cell.setUI(item: images[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openImageViewer(page: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == images.count {
            if total > images.count{
                loadNextPage()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        Utility.getTopViewController().view.endEditing(true)
    }
}

/// For ImageViewer
extension ImageTableView {
    
    /// Creates An array of LightboxImage
    /// - Returns: <#description#>
    func createImagesArray() -> [LightboxImage] {
        var lightboxImages: [LightboxImage] = []
        for image in images {
            let lightboxImage = LightboxImage(imageURL: URL(string: image.largeImageURL ?? "")!)
            lightboxImages.append(lightboxImage)
        }
        return lightboxImages
    }
    
    
    /// Open Image Viewer with specific image shown and can slide the next and previous image
    /// - Parameter page: the index of image to be shown initially
    func openImageViewer(page: Int)  {
        // Create an instance of LightboxController.
        let controller = LightboxController()
        controller.images = createImagesArray()
        // Use dynamic background.
        controller.dynamicBackground = true
        controller.goTo(page)
        // Present your controller.
        Utility.getTopViewController().present(controller, animated: true, completion: nil)
        
    }
}
