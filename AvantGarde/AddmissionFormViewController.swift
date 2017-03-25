//
//  AddmissionFormViewController.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/12/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit

class AddmissionFormViewController: UIViewController {

    @IBOutlet weak var PlusAdmission_Label: UILabel!
    @IBOutlet weak var StudentAdmissionNote_Label: UILabel!
    @IBOutlet weak var Name_View: UIView!
    @IBOutlet var Course_AdmissionForm: UIView!
    @IBOutlet weak var ScrollView_ContentSize: UIScrollView!
    @IBOutlet weak var MainContent_Form: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StudentAdmissionNote_Label.layer.cornerRadius = 5
        StudentAdmissionNote_Label.layer.masksToBounds = true
        
        PlusAdmission_Label.layer.cornerRadius = 5
        PlusAdmission_Label.layer.masksToBounds = true
        
        MainContent_Form.layer.borderWidth = 1
        MainContent_Form.layer.borderColor = UIColor.lightGray.cgColor
        
//  ScrollView_ContentSize.contentSize = CGSize(width: 0, height: self.txtView.frame.maxY + 1450)
        
        ScrollView_ContentSize.bounces = false
        ScrollView_ContentSize.contentSize = CGSize(width: 0, height: 2000)
        
        
   
       downloadingFile()
        
    }
    
    @IBAction func Name_Button(_ sender: Any) {
    //    Course_AdmissionForm.frame.origin.y = Name_View.frame.origin.y
        Course_AdmissionForm.removeFromSuperview()
        MainContent_Form.addSubview(Name_View)
        ScrollView_ContentSize.addSubview(MainContent_Form)
    }

    @IBAction func Course_Button(_ sender: Any) {
        Course_AdmissionForm.frame.origin.y = Name_View.frame.origin.y
        MainContent_Form.addSubview(Course_AdmissionForm)
        ScrollView_ContentSize.addSubview(MainContent_Form)
    }
   
    //Downloading all file
    
    func downloadingFile()
    
    {
    
    // Create destination URL
    let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
    let destinationFileUrl = documentsUrl.appendingPathComponent("User.pdf")
    
    //Create URL to the source file you want to download
    let fileURL = URL(string: "http://www.pdf995.com/samples/pdf.pdf")
    
    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig)
    
    let request = URLRequest(url:fileURL!)
    
    let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
    if let tempLocalUrl = tempLocalUrl, error == nil {
    // Success
    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
    print("Successfully downloaded. Status code: \(statusCode)")
    }
    
    do {
    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
    } catch (let writeError) {
    print("Error creating a file \(destinationFileUrl) : \(writeError)")
    }
    
    } else {
    print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
    }
    }
    task.resume()
        
    }
    
    func downloadpdf()
    {
      
       
    }
    
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
