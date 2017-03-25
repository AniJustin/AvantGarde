//
//  RegisterViewController.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/7/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit
import CoreLocation
var InterNetCheckingFlag : Int!
class RegisterViewController: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate {
    var locationManager:CLLocationManager!
    var userLatitude : String!
    var userLongitude : String!
    
var kbHeight: CGFloat!
    var username : String!
    var gotoNextPage : String!
    //let locationManager = CLLocationManager()
    @IBOutlet weak var EnterButton_Reference: UIButton!
    @IBOutlet weak var passcodetextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         InterNetCheckingFlag = 0
//spa90932040
     passcodetextField.text = "spa46454607"
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
        
        
      passcodetextField.delegate = self
       
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
          self.view.frame.origin.y -= 150
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
          self.view.frame.origin.y += 150
          passcodetextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passcodetextField.resignFirstResponder()
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            let alert = UIAlertController(title: "Alert", message: "Please Check your internet", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            InterNetCheckingFlag = 1
            
        case .online(.wwan):
            print("Connected via WWAN")
            InterNetCheckingFlag = 0
        case .online(.wiFi):
            print("Connected via WiFi")
            InterNetCheckingFlag = 0
        }
        if InterNetCheckingFlag == 0
        {
            webServiceCalling()
        }
        return true
    }
    


    @IBAction func passcodeEnterButton_Action(_ sender: Any) {
        
        passcodetextField.resignFirstResponder()
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            let alert = UIAlertController(title: "Alert", message: "Please Check your internet", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            InterNetCheckingFlag = 1
            
        case .online(.wwan):
            print("Connected via WWAN")
            InterNetCheckingFlag = 0
        case .online(.wiFi):
            print("Connected via WiFi")
            InterNetCheckingFlag = 0
        }
        if InterNetCheckingFlag == 0
        {
         webServiceCalling()
        }
            }
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func  webServiceCalling()
    {
        var ApplicationUniqueIdentifier = UserDefaults.standard.value(forKey: "ApplicationUniqueIdentifier")!
        
        ApplicationUniqueIdentifier = (ApplicationUniqueIdentifier as AnyObject).replacingOccurrences(of: "-", with: "")
        
        var request = URLRequest(url: URL(string: "http://52.29.203.220/demo/index.php/?api/registered_app/")!)
        
        
        request.httpMethod = "POST"
        let postString = "passcode=\(passcodetextField.text!)&device_id=\(ApplicationUniqueIdentifier)&deviceToken=\(deviceTokenstring!)&deviceType=ios&latitude=\(userLatitude!)&longitude=\(userLongitude!)"
        
        
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 600 {           // check for http errors
                // print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            
            let dict = self.convertToDictionary(text: responseString!)
            print(dict!)
            
            
            if dict?.index(forKey: "user_id") != nil {
                UserId = dict?["user_id"] as! String
                // the key exists in the dictionary
                print(" the key exists in the dictionary")
            }
            if dict?.index(forKey: "user_id") == nil {
                print("the key 'user_id' is NOT in the dictionary")
            }
            
            
            if dict?.index(forKey: "user_type") != nil {
                UserType = dict?["user_type"] as! String
                // the key exists in the dictionary
                print(" the key exists in the dictionary")
            }
            if dict?.index(forKey: "user_type") == nil {
                print("the key 'user_type' is NOT in the dictionary")
            }
            
            self.username = dict?["action"] as! String
            
            OperationQueue.main.addOperation({
                
                if self.username == "fail"
                {
                    EZLoadingActivity.show("Loading...", disableUI: true)
                    EZLoadingActivity.hide(success: false, animated: true)
                }
                if self.username == "success"
                {
                    print("ok log in")
                    
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
            })
        }
        task.resume()
        

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
print("user latitude = \(userLocation.coordinate.latitude)")
      print("user longitude = \(userLocation.coordinate.longitude)")
        
        userLatitude = "\(userLocation.coordinate.latitude)"
        userLongitude = "\(userLocation.coordinate.longitude)"
         manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }


    func networkStatusChanged(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        print(userInfo)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
