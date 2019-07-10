//
//  Meme.swift
//  MemeMeV1
//
//  Created by Hossameldien Hamada on 7/10/19.
//  Copyright © 2019 Hossameldien Hamada. All rights reserved.
//

import Foundation
import UIKit
extension MemeMeController{
   
    //MARK:- Structs
    struct Meme{
        let topText: String
        let bottomText: String
        let originalImage: UIImage
        let memedImage: UIImage
    }
    
    //MARK:- Generate Meme
    func generateMemedImage() -> UIImage {
        
        // Hide toolbars
        hideToolbars(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbars
        hideToolbars(false)
        
        
        return memedImage
    }
    
    //MARK:- Save Meme
    func save(){
        let _ = Meme(topText: upperTextField.text!, bottomText: lowerTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
    }
    
}
