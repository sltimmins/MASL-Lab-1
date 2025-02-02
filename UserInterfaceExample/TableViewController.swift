//
//  TableViewController.swift
//  UserInterfaceExample
//
//  Created by Eric Larson on 9/3/20.
//  Copyright © 2020 Eric Larson. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // Lazy instantiation of settings
    lazy var settings = {
        return SettingsModel.sharedInstance()
    }()
    
    // Create the timer
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 45, target: self, selector: #selector(popModal), userInfo: nil, repeats: true)
        
    }
    
    // Updates the view with the correct settings (takes a second tho)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.view.backgroundColor = settings.background
        self.tableView.reloadData()
    }
    
    @objc func popModal(){
        //print("Start the bomb")
        performSegue(withIdentifier: "goToBomb", sender: self)
//        timer?.invalidate()
    }
    
    // Lazy instantiation of the imageModel
    lazy var imageModel:ImageModel = {
        return ImageModel.sharedInstance()
    }()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if settings.imageAmount <= self.imageModel.imageNames.count{
                return settings.imageAmount
            } else {
                return self.imageModel.imageNames.count
            }
            
        }
        
        return 1
    }

    
    // Set up the cells in the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 { // For the individual characters
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageNameCell", for: indexPath)
            cell.backgroundColor = settings.background
            
            // Configure the cell...
            if let name = (self.imageModel.imageNames[indexPath.row] as AnyObject).getName() as? String {
                cell.textLabel!.text = name
            }
            
            return cell
        }else if indexPath.section == 1 { // For the summary/colleciton view
            let cell = tableView.dequeueReusableCell(withIdentifier: "ViewAll", for: indexPath)
            cell.backgroundColor = settings.background
            
            // Configure the cell...
            cell.textLabel?.text = "All Image"
            cell.detailTextLabel?.text = "Summary"
            
            return cell
        }else { // For the settings cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "Settings", for: indexPath)
            cell.backgroundColor = settings.background
            
            // Configure the cell...
            cell.textLabel?.text = "Settings"
//            cell.detailTextLabel?.text = "Settings"
            
            return cell
        }
    }
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? ViewController,
           let cell = sender as? UITableViewCell,
           let name = cell.textLabel?.text {
                vc.displayImageName = name
        }
    }
    

}
