//
//  SearchDetailVC.swift
//  My Grape Vine
//
//  Created by Daniel Martin (RIT Student) on 5/16/17.
//  Copyright © 2017 Daniel Martin (RIT Student). All rights reserved.
//

import UIKit

class SearchDetailVC: UIViewController {
    
    // - MARK - IBOutlets
    @IBOutlet weak var wineName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var wineImg: UIImageView!
    @IBOutlet weak var noImage: UILabel!
    
    var wine:AnyObject?
    var imageURL:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wineName.text = wine?["Name"] as? String
        wineName.adjustsFontSizeToFitWidth = true;
        
        
        getImageURL()
        print("\(imageURL)")
        if(imageURL != nil){
            if let checkedUrl = URL(string: imageURL) {
                wineImg.contentMode = .scaleAspectFit
                downloadImage(url: checkedUrl)
                noImage.isHidden = true
            }
        }
        
        
        //Chenge text for price
        if let costText = wine?["PriceRetail"] {
            if let unwrappedCost = costText {
                price.text = "$\(unwrappedCost)"
            }
        }
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK - Image Downloading Code -
    func getImageURL(){
        guard let vineyard = wine?["Vineyard"] as? [String: AnyObject] else{
            print("vineyard not found")
            return
        }
        
        if let tempURL = vineyard["ImageUrl"] as! String? {
            imageURL = tempURL
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.wineImg.image = UIImage(data: data)
            }
        }
    }
    
    // - MARK - IBActions
    @IBAction func viewOnWeb(_ sender: Any) {

            if let url = URL(string: (wine?["Url"])! as! String){
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
