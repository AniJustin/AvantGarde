//
//  SplashPageViewController.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/19/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit

class SplashPageViewController: UIViewController {

    @IBOutlet weak var AvantGradeLogo: UIImageView!
   // @IBOutlet weak var AvantGradeLogo: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AvantGradeLogo.center.y -= view.bounds.width

   
    }
    override func viewDidAppear(_ animated: Bool) {
        
        //Bringing back the login label with animation
        UIView.animate(withDuration: 0.9, animations: {
           self.AvantGradeLogo.center.y += self.view.bounds.width
        })
     
        perform(#selector(SplashPageViewController.Next), with: nil, afterDelay: 2)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Next()
    {
        print("next")
//  performSegue(withIdentifier: "Register", sender: self)
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(secondViewController, animated: false)
        
        
//        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
//        
//        let navigationController = UIViewController.rootViewController as! UINavigationController
//        
//        navigationController.pushViewController(destinationViewController, animated: false)
    }
    
  

}
