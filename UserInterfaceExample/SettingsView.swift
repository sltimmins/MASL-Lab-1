//
//  SettingsView.swift
//  UserInterfaceExample
//
//  Created by Caleb Moore on 9/13/22.
//  Copyright © 2022 Eric Larson. All rights reserved.
//

import UIKit

class SettingsView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    lazy var settings = {
        return SettingsModel.sharedInstance()
    }()
    
    lazy var imageModel:ImageModel = {
        return ImageModel.sharedInstance()
    }()
    
    let pickerData = ["Default","Red", "Green", "Blue", "Magenta"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch row {
        case 0:
            self.view.backgroundColor = UIColor.systemBackground
            self.settings.background = UIColor.systemBackground
            self.NewSettingsView.backgroundColor = UIColor.systemBackground
        case 1:
            self.view.backgroundColor = UIColor.red
            self.settings.background = UIColor.red
            self.NewSettingsView.backgroundColor = UIColor.red
        case 2:
            self.view.backgroundColor = UIColor.green
            self.settings.background = UIColor.green
            self.NewSettingsView.backgroundColor = UIColor.green
        case 3:
            self.view.backgroundColor = UIColor.blue
            self.settings.background = UIColor.blue
            self.NewSettingsView.backgroundColor = UIColor.blue
        case 4:
            self.view.backgroundColor = UIColor.magenta
            self.settings.background = UIColor.magenta
            self.NewSettingsView.backgroundColor = UIColor.magenta
        default:
            self.view.backgroundColor = UIColor.white
            self.settings.background = UIColor.white
            self.NewSettingsView.backgroundColor = UIColor.white
        }
        
    }

    @IBOutlet weak var Stepper: UIStepper!
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var PickerButton: UIButton!
    @IBOutlet weak var SegmentedControl: UISegmentedControl!

    
    @IBOutlet weak var SliderLabel: UILabel!
    @IBOutlet weak var StepperLabel: UILabel!
    @IBOutlet weak var SwitchLabel: UILabel!
    @IBOutlet weak var SegmentedControlLabel: UILabel!
    
    @IBOutlet weak var Picker: UIPickerView!
        
    @IBOutlet weak var NewSettingsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = settings.background
        self.NewSettingsView.backgroundColor = settings.background

        // Do any additional setup after loading the view.
        SwitchLabel.text = "Dark Mode"
        if(UIApplication.shared.keyWindow?.overrideUserInterfaceStyle == .dark){
            Switch.setOn(true, animated: true)
        } else {
            Switch.setOn(false, animated: true)
        }
        
        
        SliderLabel.text = "Slider Redness"
        SliderLabel.textColor = UIColor.init(red: 0, green: 0, blue: 1, alpha: 1)
        Slider.maximumValue = 255
        Slider.thumbTintColor = UIColor.init(red: 0, green: 0, blue: 1, alpha: 1)
        
        StepperLabel.text = "Minimum Amount of Images Shown: " + String(settings.imageAmount)
        Stepper.value = Double(settings.imageAmount)
        Stepper.maximumValue = Double(self.imageModel.imageNames.count)

        
        PickerButton.setTitle("Set Background Color", for: .normal)
        Picker.dataSource = self
        Picker.delegate = self
        Picker.isHidden = true
        
        SegmentedControlLabel.text = "Lock Dark Mode"
        SegmentedControl.setTitle("On", forSegmentAt: 0)
        SegmentedControl.setTitle("Off", forSegmentAt: 1)
        
    }
    
    @IBAction func FirstSecond(_ sender: Any) {
        switch SegmentedControl.selectedSegmentIndex
            {
            case 0:
                Switch.isEnabled = true
            case 1:
                Switch.isEnabled = false
            default:
                break
            }
    }
    
    @IBAction func SliderAction(_ sender: UISlider) {
        SliderLabel.textColor = UIColor.init(red: CGFloat((Slider.value)/255), green: 0, blue: 1-CGFloat((Slider.value)/255), alpha: 1)
        Slider.thumbTintColor = UIColor.init(red: CGFloat((Slider.value)/255), green: 0, blue: 1-CGFloat((Slider.value)/255), alpha: 1)
        Slider.tintColor = UIColor.init(red: CGFloat((Slider.value)/255), green: 0, blue: 1-CGFloat((Slider.value)/255), alpha: 1)
//        sender.setValue(round(sender.value), animated:true)
    }
    
    
    @IBAction func StepperAction(_ sender: Any) {

        self.settings.imageAmount = Int(Stepper.value)
        
        StepperLabel.text = "Minimum Amount of Images Shown: " + String(self.settings.imageAmount)
    }
    
    @IBAction func SwitchAction(_ sender: Any) {
        if(Switch.isOn){
            let window = UIApplication.shared.keyWindow
                    window?.overrideUserInterfaceStyle = .dark
        } else {
            let window = UIApplication.shared.keyWindow
                    window?.overrideUserInterfaceStyle = .light
        }
    }

    
    @IBAction func PickerButtonPress(_ sender: Any) {
        Picker.isHidden = !Picker.isHidden
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
