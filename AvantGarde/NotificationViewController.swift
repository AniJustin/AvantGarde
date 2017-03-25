//
//  NotificationViewController.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/19/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var Notification_TableView: UITableView!
    @IBOutlet weak var NotificationButton_Reference: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        ResponsePushNotification = "0"
//                let navigationArray: Array<UIViewController> = (self.navigationController?.viewControllers)! as [UIViewController]
//                print(navigationArray)
        // Do any additional setup after loading the view.
    }

    
    
    
    
 // func numberOfSections(in tableView: UITableView) -> Int {
  //      return 3
   // }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath)
        
        cell.textLabel?.text = "hai sahoo"
        
        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {

        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.navigationController?.pushViewController(secondViewController, animated: false)
        
        
    }
  // func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
   //     return "Section \(section)"
  //  }
    

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
