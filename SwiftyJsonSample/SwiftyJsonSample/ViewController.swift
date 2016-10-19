//
//  ViewController.swift
//  SwiftyJsonSample
//
//  Created by Rasheda Jacobs on 9/8/16.
//  Copyright © 2016 Rasheda Babatunde. All rights reserved.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
   
 
    
    struct SocialPost {
        let type: String
        let shares: Int
        let desc: String
    }
    
    var socialPosts = [SocialPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        parseSocial_Activity()
        
      //  loadJSONData()
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum ReadFileFromResourcesError: Error {
        
        case fileDoesNotExist
        case failedToLoadData
        case failedToConvertData
    }
    
    func readFileFromResources(_ fileName: String, fileType: String, encoding: String.Encoding = String.Encoding.utf8) -> String {
        
        let absoluteFilePath = Bundle.main.path(forResource: fileName, ofType: fileType)
        
        if let absoluteFilePath = absoluteFilePath {
            
            if let fileData = try? Data.init(contentsOf: URL(fileURLWithPath: absoluteFilePath)) {
                
                if let fileAsString = NSString(data: fileData, encoding: encoding.rawValue) {
                    return fileAsString as String
                } else {
                    print("readFileFromResources failed on: \(fileName). Failed to convert data to String!")
                    return  ""
                }
                
            } else {
                print("readFileFromResources failed on: \(fileName). Failed to load any data!")
                return  ""
            }
        }
        
        print("readFileFromResources failed on: \(fileName). File does not exist!")
        return  ""
    }

    func parseSocial_Activity() {
        
        let jsonString = readFileFromResources("social_activity", fileType: ".json")
        
        let json = JSON.parse(jsonString)
        
        for socialActivity in json["socialActivity"].arrayValue {
            
            let type = socialActivity["type"].stringValue
            let shares = socialActivity["shares"].intValue
            let desc = socialActivity["desc"].stringValue

            print("type = \(type), shares = \(shares), desc = \(desc)")

            socialPosts.append(SocialPost(type: type, shares: shares, desc: desc))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return socialPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "socialTableViewCell", for: indexPath) as! SocialTableViewCell
        
        cell.sharesText.text = String(socialPosts[(indexPath as NSIndexPath).row].shares)
        cell.descText.text = socialPosts[(indexPath as NSIndexPath).row].desc
        cell.socialIcon.image = UIImage(named: socialPosts[(indexPath as NSIndexPath).row].type)
        
        return cell
    }

}

    
