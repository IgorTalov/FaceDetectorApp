//
//  ViewController.swift
//  FaceDetectorTest
//
//  Created by Игорь Талов on 24.09.16.
//  Copyright © 2016 Игорь Талов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var faceButton: UIButton!
    
    var isDetect: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage.init(named:"Passengers.jpg")
        isDetect = false
        // Do any additional setup after loading the view, typically from a nib.
        self.faceButton.layer.cornerRadius = 5
        self.faceButton.alpha = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func faceDetect()  {
        
        if (isDetect == true) {
            for view in imageView.subviews {
                view.removeFromSuperview()
            }
            isDetect = false
            return
        }
        
        guard let personImage = CIImage(image: imageView.image!) else {
            return
        }
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector.featuresInImage(personImage)
        
        // Convert CIImage Coordinate to UIView Coordinate
        let ciImageSize = personImage.extent.size
        var transform = CGAffineTransformMakeScale(1, -1)
        transform = CGAffineTransformTranslate(transform, 0, -ciImageSize.height)
        
        for face in faces as! [CIFaceFeature] {
            
            print("Found Bbounds are \(face.bounds)")
            
            var faceViewBounds = CGRectApplyAffineTransform(face.bounds, transform)
            
            let viewSize = imageView.bounds.size
            let scale = min(viewSize.width / ciImageSize.width,
                            viewSize.height / ciImageSize.height)
            let offsetX = (viewSize.width - ciImageSize.width * scale) / 2
            let offsetY = (viewSize.height - ciImageSize.height * scale) / 2
            
            faceViewBounds = CGRectApplyAffineTransform(faceViewBounds, CGAffineTransformMakeScale(scale, scale))
            faceViewBounds.origin.x += offsetX
            faceViewBounds.origin.y += offsetY
            
            let faceBox = UIView(frame: faceViewBounds)
            
            faceBox.layer.borderWidth = 3
            faceBox.layer.cornerRadius = 10
            faceBox.layer.borderColor = UIColor.redColor().CGColor
            faceBox.backgroundColor = UIColor.clearColor()
            imageView.addSubview(faceBox)
            isDetect = true
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
        }
    }

    @IBAction func faceDetectAction(sender: AnyObject) {
        print("Face Detect")
        faceDetect()
    }
}

