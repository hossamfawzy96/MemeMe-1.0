//
//  TextFieldsDelegate.swift
//  ImagePicker
//
//  Created by Hossameldien Hamada on 7/7/19.
//  Copyright © 2019 Hossameldien Hamada. All rights reserved.
//

import Foundation
import UIKit

class TextFieldsDelegate: NSObject, UITextFieldDelegate{
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        var _ = self.textFieldShouldReturn(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField.text == ""{
            if(textField.accessibilityLabel == "UPPER"){
                textField.text = "TOP"
            }else{
                textField.text = "BOTTOM"
            }
        }
        textField.resignFirstResponder()
        
        return true;
    }
}
