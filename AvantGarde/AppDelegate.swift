//
//  AppDelegate.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/7/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit
import UserNotifications
var ValidateLogin : String!

var ResponsePushNotification : String!
let app = UIApplication.shared.delegate as! AppDelegate


var deviceTokenstring : String!
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate  {

    var window: UIWindow?
    var ManageTeacher_ViewControlle = ManageTeacher_ViewController()
var shared = SAHREDViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        

        ValidateLogin = "0"
        ResponsePushNotification = "0"
        deviceTokenstring=""
        application.applicationIconBadgeNumber = 0
        deviceTokenstring=""
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: "ApplicationUniqueIdentifier") == nil {
            let UUID = NSUUID().uuidString
            // UUID = UUID.replacingOccurrences(of: "[ |()-]", with: "", options: [.regularExpression])
            userDefaults.set(UUID, forKey: "ApplicationUniqueIdentifier")
            userDefaults.synchronize()
        }
        
        print("\(UserDefaults.standard.value(forKey: "ApplicationUniqueIdentifier")!)")
        
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [UNAuthorizationOptions.sound ], completionHandler: { (granted, error) in
                if error == nil{
                    UIApplication.shared.registerForRemoteNotifications()
                }
            })
        } else {
            let settings  = UIUserNotificationSettings(types: [UIUserNotificationType.alert , UIUserNotificationType.badge , UIUserNotificationType.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        
        return true
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("User Info willPresent notification=== \(notification.request.content.userInfo)")
        // Handle code here.
        completionHandler([UNNotificationPresentationOptions.sound , UNNotificationPresentationOptions.alert , UNNotificationPresentationOptions.badge])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info didReceive response: UNNotificationRespons=== \(response.notification.request.content.userInfo)")
        completionHandler()
        
        let content = response.notification.request.content
        let badgeNumber = content.badge as! Int
        ResponsePushNotification = "YES"
        print("badge number \(badgeNumber)")
        
        if ValidateLogin == "YES"
        {
            
            
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                let storyboard = UIStoryboard(name: "Ipad", bundle: nil)
                
                let destinationViewController = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
                
                let navigationController = self.window?.rootViewController as! UINavigationController
                
                navigationController.pushViewController(destinationViewController, animated: false)
                
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let destinationViewController = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
                
                let navigationController = self.window?.rootViewController as! UINavigationController
                
                navigationController.pushViewController(destinationViewController, animated: false)
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("userinfo \(userInfo)")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .none {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("device token:   \(deviceTokenString)")
        
        deviceTokenstring = deviceTokenString
        
    }
    
    private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        application.applicationIconBadgeNumber = 0
        print("didReceiveRemoteNotification\(userInfo)")
        //        if let aps = userInfo["aps" as NSString] as? [String:Any] {
        //            if let alert = aps["alert"] as? NSDictionary {
        //                if let message = alert["message"] as? NSString {
        //                    //Do stuff
        //                }
        //            } else if let alert = aps["alert"] as? NSString {
        //                //Do stuff
        //            }
        //        }
        //        let secondViewController =
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

