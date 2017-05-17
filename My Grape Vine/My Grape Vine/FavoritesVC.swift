//
//  FavoritesVC.swift
//  My Grape Vine
//
//  Created by Daniel Martin (RIT Student) on 4/26/17.
//  Copyright © 2017 Daniel Martin (RIT Student). All rights reserved.
//

import UIKit

class FavoritesVC: UITableViewController {
    
    var favArray:[Wine]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        favArray = WineData.sharedData.favorites
        
        let fileName = "favorites.archive"
        let pathToFile = FileManager.filePathInDocumentsDirectory(fileName: fileName)
        
        if FileManager.default.fileExists(atPath: pathToFile.path){
            print("Opened \(pathToFile)")
            //load in bookmarks
            WineData.sharedData.favorites = NSKeyedUnarchiver.unarchiveObject(withFile: pathToFile.path) as! [Wine]
        }else{
            print("Could not find \(pathToFile)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favArray = WineData.sharedData.favorites
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveFavs(){
        WineData.sharedData.favorites = favArray
        let pathToFile = FileManager.filePathInDocumentsDirectory(fileName: "favorites.archive")
        _ = NSKeyedArchiver.archiveRootObject(favArray, toFile: pathToFile.path)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = favArray[indexPath.row].wine["Name"] as? String
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let url = URL(string: favArray[indexPath.row].wine["Url"] as! String){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(
                    url,
                    options:[:],
                    completionHandler: {
                        (success) in
                        print("Open \(url.description) - success = \(success)")
                }
                )
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favArray.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        saveFavs()
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let bookmarkToMove = favArray.remove(at: fromIndexPath.row)
        favArray.insert(bookmarkToMove, at: to.row)
        saveFavs()
    }
    
}
