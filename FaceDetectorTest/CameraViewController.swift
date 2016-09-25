//
//  CameraViewController.swift
//  FaceDetectorTest
//
//  Created by Игорь Талов on 25.09.16.
//  Copyright © 2016 Игорь Талов. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    let imagePicker = UIImagePickerController ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takePhoto(sender: AnyObject){
        
    }
}
