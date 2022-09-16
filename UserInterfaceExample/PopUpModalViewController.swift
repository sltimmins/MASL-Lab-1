//
//  PopUpModalViewController.swift
//  UserInterfaceExample
//
//  Created by Wyatt Saltzman on 9/14/22.
//  Copyright © 2022 Eric Larson. All rights reserved.
//

import UIKit

class PopUpModalViewController: UIViewController {
    lazy var settings = {
        return SettingsModel.sharedInstance()
    }()
    var count = 11
    var timer:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = settings.background
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    // function to count down the timer
    @objc func updateCounter() {
        if count > 0 {
            //print("\(count) seconds until the explosion")
            count -= 1
            countDownLabel.text = String(count)
            }
        else{
            // if timer runs out it resets the app settings
            countDownLabel.text = "SIKE :)"
            self.settings.background = UIColor.systemBackground
            self.view.backgroundColor = UIColor.systemBackground
            self.settings.imageAmount = 1
            timer?.invalidate()
        }
    }
    
    @IBOutlet weak var theImage: UIImageView!
    
    @IBAction func returnToRootVC(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBOutlet weak var countDownLabel: UILabel!
}
