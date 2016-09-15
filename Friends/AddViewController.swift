//
//  AddViewController.swift
//  Friends
//
//  Created by Philip on 9/15/16.
//  Copyright © 2016 Philip Vo. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descLabel: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    var friendToEdit: Friend?
    
    weak var delegate: AddViewControllerDelegate?
    weak var cancelButtonDelegate: CancelButtonDelegate?
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        if let friend = friendToEdit {
//            friend.img = UIImagePNGRepresentation(imgView.imag)
            friend.imgurl = "NA"
            friend.name = nameLabel.text!
            friend.desc = nameLabel.text!
            delegate?.addViewController(self, didFinishEditingFriend: friend)
        } else {
//            let friend = Friend()
            print("In addview")
            //            friend.img = UIImagePNGRepresentation(imgView.imag)
            let friend = [nameLabel.text!, descLabel.text!]
//            friend.imgurl! = "NA"
//            friend.name! = nameLabel.text!
//            friend.desc! = des
            delegate?.addViewController(self, didFinishAddingFriend: friend)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgView.contentMode = .ScaleAspectFit
            imgView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
//        imgView = friendToEdit?.img
        nameLabel.text = friendToEdit?.name
        descLabel.text = friendToEdit?.desc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
