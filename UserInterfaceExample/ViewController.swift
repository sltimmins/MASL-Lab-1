//
//  ViewController.swift
//  UserInterfaceExample
//
//  Created by Eric Larson on 9/2/20.
//  Copyright © 2020 Eric Larson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    lazy var settings = {
        return SettingsModel.sharedInstance()
    }()
    
    lazy var imageModel = {
        return ImageModel.sharedInstance()
    }()
    
    lazy private var imageView: UIImage? = {
        return self.imageModel.getImageWithName(displayImageName)
    }()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var CharacterImage: UIImageView!
    @IBOutlet weak var CharacterName: UILabel!
    @IBOutlet weak var CharacterBio: UITextView!
    
    var displayImageName = "Eric"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = settings.background
        self.CharacterImage.contentMode = .scaleAspectFit
        if self.imageView != nil {
            self.CharacterImage.image = self.imageView!
        }
        self.CharacterName.text = displayImageName
        self.CharacterBio.text = self.imageModel.getCharacter(displayImageName).getBio()
        
//        if let size = self.imageView?.image?.size{
//            self.scrollView.addSubview(self.imageView!)
//            self.scrollView.contentSize = size
//            self.scrollView.minimumZoomScale = 0.1
//            self.scrollView.delegate = self
//        }
        
    }
    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return self.imageView
//    }
    
    


}

