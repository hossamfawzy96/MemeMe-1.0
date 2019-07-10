//
//  MemeMeController-ImagePicker.swift
//  ImagePicker
//
//  Created by Hossameldien Hamada on 7/9/19.
//  Copyright © 2019 Hossameldien Hamada. All rights reserved.
//

import Foundation
import UIKit

extension MemeMeController{
    
    //MARK:- ImagePickercontrollerDelegate Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imagePickerView.image = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePickerView.image = originalImage
        }
        
        dismiss(animated: true, completion: {self.enableButtons(true)})
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK:- Controller Initialization
    func setImagePickerController(_ album: Bool){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
        if(album){
            pickerController.allowsEditing = true
        }
    }
}
