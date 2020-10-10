//
//  Utility.swift
//  SahibRestaurant
//
//  Created by Pritam Hazra on 11/08/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    /// <#Description#>
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - msg: <#msg description#>
    ///   - controller: <#controller description#>
    ///   - okClicked: <#okClicked description#>
    /// - Returns: <#description#>
    class func showAlertView(title : String, msg :String, controller:UIViewController, okClicked : @escaping ()->()){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            print("OK")
            okClicked()
        }

        alertController.addAction(okAction);
        controller.present(alertController, animated: true, completion: nil)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - msg: <#msg description#>
    ///   - controller: <#controller description#>
    ///   - okTitle: <#okTitle description#>
    ///   - cancelTitle: <#cancelTitle description#>
    ///   - okClicked: <#okClicked description#>
    ///   - cancelClicked: <#cancelClicked description#>
    /// - Returns: <#description#>
    class func showAlertView(title : String, msg :String, controller:UIViewController, okTitle: String = "OK", cancelTitle: String = "Cancel", okClicked : @escaping ()->(), cancelClicked : @escaping ()->()){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: okTitle, style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            print("OK")
            okClicked()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            print("Cancel")
            cancelClicked()
        }
        cancelAction.setValue(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), forKey: "titleTextColor")

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    
    /// Current Scene Delegate
    /// - Returns: Current Scene Delegate
    class func getSceneDelegate() -> SceneDelegate {
        let windowScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let sceneDelegate = windowScene.delegate as! SceneDelegate
        return sceneDelegate
    }

    /// Find Top most ViewController
    /// - Returns: Current Top Viewcontroller in the window
    class func getTopViewController() -> UIViewController {
        
        var viewController = UIViewController()
        
        if let vc =  getSceneDelegate().window?.rootViewController {
            
            viewController = vc
            var presented = vc
            
            while let top = presented.presentedViewController {
                presented = top
                viewController = top
            }
        }
        return viewController
    }
}
