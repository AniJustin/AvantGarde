//
//  AdmissionForm_ViewController.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/25/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit

class AdmissionForm_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
webServiceCalling1()
        // Do any additional setup after loading the view.
    }
    func  webServiceCalling1()
    {
        
        var request = URLRequest(url: URL(string: "http://52.29.203.220/demo/index.php/?parent_api/admission_student_details/")!)
        
        request.httpMethod = "POST"
        let postString = "user_id=\(UserId!)&student_id=120"
        
        //userid :119
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 600 {           // check for http errors
                // print("statusCode should be 200, but is \(httpStatus.statusCode)")
                //   print("response = \(response!)")
            }
            
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            
            let dict = self.convertToDictionary(text: responseString!)
            print(dict!)
            
            
            if dict?.index(forKey: "enquiredStudentDataArr") != nil {
                let studentDataArr = dict?["enquiredStudentDataArr"] as! NSArray
                let name = studentDataArr[0] as! NSDictionary
                //  let name1 = name["name"] as NSArray
                // the key exists in the dictionary
                print(name)
                let name1 = name["name"]
                print(name1!)
            }
        }
        task.resume()
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
