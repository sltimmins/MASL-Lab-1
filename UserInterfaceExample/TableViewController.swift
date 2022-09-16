//
//  TableViewController.swift
//  UserInterfaceExample
//
//  Created by Eric Larson on 9/3/20.
//  Copyright © 2020 Eric Larson. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    lazy var settings = {
        return SettingsModel.sharedInstance()
    }()

    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(popModal), userInfo: nil, repeats: true)
        
    }
    
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageNameCell", for: indexPath)
            cell.backgroundColor = settings.background
            
            // Configure the cell...
            if let name = (self.imageModel.imageNames[indexPath.row] as AnyObject).getName() as? String {
                cell.textLabel!.text = name
            }
            
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ViewAll", for: indexPath)
            cell.backgroundColor = settings.background
            
            // Configure the cell...
            cell.textLabel?.text = "All Image"
            cell.detailTextLabel?.text = "Summary"
            
            return cell
        }else {
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
