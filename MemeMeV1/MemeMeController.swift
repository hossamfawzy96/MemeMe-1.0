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
   
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetText()
        setupTextFields(upperTextField)
        setupTextFields(lowerTextField)
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
    
    func  setupTextFields(_ textField: UITextField){
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = textFieldsDelegate
        textField.adjustsFontSizeToFitWidth = true
    }
}

