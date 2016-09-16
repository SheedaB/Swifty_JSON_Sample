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
    
    enum ReadFileFromResourcesError: ErrorType {
        
        case FileDoesNotExist
        case FailedToLoadData
        case FailedToConvertData
    }
    
    func readFileFromResources(fileName: String, fileType: String, encoding: NSStringEncoding = NSUTF8StringEncoding) -> String {
        
        let absoluteFilePath = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        
        if let absoluteFilePath = absoluteFilePath {
            
            if let fileData = NSData.init(contentsOfFile: absoluteFilePath) {
                
                if let fileAsString = NSString(data: fileData, encoding: encoding) {
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return socialPosts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("socialTableViewCell", forIndexPath: indexPath) as! SocialTableViewCell
        
        cell.sharesText.text = String(socialPosts[indexPath.row].shares)
        cell.descText.text = socialPosts[indexPath.row].desc
        cell.socialIcon.image = UIImage(named: socialPosts[indexPath.row].type)
        
        return cell
    }

}

    