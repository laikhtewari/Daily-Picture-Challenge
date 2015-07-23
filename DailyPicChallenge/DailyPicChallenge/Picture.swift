//
//  Picture.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 7/21/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit

typealias PictureCallback = UIImage? -> Void

class Picture : NSObject {
    
    /** View controller on which AlertViewController and UIImagePickerController are presented */
    weak var viewController: UIViewController!
    var callback: PictureCallback
    var imagePickerController: UIImagePickerController?
    
    
    init(viewController: UIViewController, callback: PictureCallback) {
        self.viewController = viewController
        self.callback = callback
        
        super.init()
        
        showPhotoSourceSelection()
    }
    
    func showPhotoSourceSelection() {
        if (UIImagePickerController.isCameraDeviceAvailable(.Rear)) {
                self.showImagePickerController(.Camera)
        }
    }
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
}

extension Picture: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        viewController.dismissViewControllerAnimated(false, completion: nil)
        
        callback(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}