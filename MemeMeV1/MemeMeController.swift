//
//  ViewController.swift
//  ImagePicker
//
//  Created by Hossameldien Hamada on 7/7/19.
//  Copyright © 2019 Hossameldien Hamada. All rights reserved.
//

import UIKit

class MemeMeController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    
    // MARK:- Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var lowerTextField: UITextField!
    @IBOutlet weak var upperTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    //MARK:- Constants
    let textFieldsDelegate = TextFieldsDelegate()
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBold", size: 40)!,
        .strokeWidth:  NSNumber(-3.0)]
    
    //MARK:- Variables
    var memedImage: UIImage!
    
    //MARK:- Structs
    struct Meme{
        let topText: String
        let bottomText: String
        let originalImage: UIImage
        let memedImage: UIImage
    }
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetText()
        
        upperTextField.defaultTextAttributes = memeTextAttributes
        upperTextField.textAlignment = NSTextAlignment.center
        upperTextField.delegate = textFieldsDelegate
        upperTextField.adjustsFontSizeToFitWidth = true
       
        lowerTextField.defaultTextAttributes = memeTextAttributes
        lowerTextField.textAlignment = NSTextAlignment.center
        lowerTextField.delegate = textFieldsDelegate
        lowerTextField.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        enableButtons(false)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    //MARK:- Actions
    @IBAction func imagePickerAlbum(_ sender: Any) {
        setImagePickerController(true)
    }
    
    
    @IBAction func imagePickerCamera(_ sender: Any) {
        setImagePickerController(false)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        controller.completionWithItemsHandler = { activity, success, items, error in
            if(success){
                self.save()
            }
            self.performCancel()
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
      performCancel()
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
    
    //MARK:- Functions
    func hideToolbars(_ isHidden: Bool){
        topToolbar.isHidden = isHidden
        bottomToolbar.isHidden = isHidden
    }
    
    func enableButtons(_ isEnabled: Bool){
        cancelButton.isEnabled = isEnabled
        shareButton.isEnabled = isEnabled
    }
    
    func resetText(){
        upperTextField.text = "TOP"
        lowerTextField.text = "BOTTOM"
    }
    
    func performCancel(){
        imagePickerView.image = nil
        resetText()
        enableButtons(false)
    }
}

