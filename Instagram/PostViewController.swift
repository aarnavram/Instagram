//
//  PostViewController.swift
//  Instagram
//
//  Created by Aarnav Ram on 21/03/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

class PostViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var textfieldInput: UITextField!

    @IBOutlet weak var previewImage: PFImageView!
    var show:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textfieldInput.textColor = UIColor.white
        self.view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if show {
            let vcc = UIImagePickerController()
            vcc.delegate = self
            vcc.allowsEditing = true
            vcc.sourceType = UIImagePickerControllerSourceType.camera
            
            let vcp = UIImagePickerController()
            vcp.delegate = self
            vcp.allowsEditing = true
            vcp.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            
            let alertController = UIAlertController(title: "Camera or Library", message: "Choose Camera or Library", preferredStyle: .actionSheet)
            let CameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                self.present(vcc, animated: true, completion: nil)
            }
            let PhotoAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                self.present(vcp, animated: true, completion: nil)
                
            }
            alertController.addAction(CameraAction)
            alertController.addAction(PhotoAction)
            present(alertController, animated: true) {
                //dismiss it
            }
        }
    }
    var originalImage:UIImage!
    var editedImage:UIImage!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        show = false
        originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        previewImage.image = editedImage

        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        //getPosts()
        
    }
    
    @IBAction func onViewPressed(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func onDismissPressed(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.previewImage, animated: true)
                Post.postUserImage(image: editedImage, withCaption: textfieldInput.text) { (success:Bool, error: Error?) in
                    MBProgressHUD.hide(for: self.previewImage, animated: true)
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
