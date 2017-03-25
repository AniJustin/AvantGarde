//
//  AttendanceReport_ViewController.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/22/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit
import EventKit
class AttendanceReport_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var flag_Pop : Int!
    var Selected_month_Id : String!
    
    @IBOutlet weak var Header_UiView: UIView!
    
    @IBOutlet weak var Selected_Month: UILabel!
    
    @IBOutlet weak var showReport_Button_Reference: UIButton!
    
    @IBOutlet weak var month_Reference_Button: UIButton!
    var CurrentSelection_Tableview: UITableView!

    @IBOutlet weak var image_monthList: UIImageView!
    
   var Month_List = ["January","February","March","April","May","June","July","August","September","October","November","December"]
      var Month_List_Id_Array = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    Header_UiView.isHidden = true
        
        Selected_month_Id = "03"
        Selected_Month.text = "March"
        month_Reference_Button.layer.borderWidth = 1
        month_Reference_Button.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        month_Reference_Button.layer.cornerRadius = 5
        month_Reference_Button.layer.masksToBounds = true
        
        showReport_Button_Reference.layer.cornerRadius = 5
        showReport_Button_Reference.layer.masksToBounds = true
        
        CurrentSelection_Tableview = UITableView(frame: CGRect(x: month_Reference_Button!.frame.origin.x, y: month_Reference_Button!.frame.origin.y + month_Reference_Button.frame.size.height+20,width: month_Reference_Button!.frame.size.width ,height: 300))
        CurrentSelection_Tableview.delegate = self
        CurrentSelection_Tableview.dataSource = self
        
        CurrentSelection_Tableview.rowHeight=30
        CurrentSelection_Tableview.separatorStyle = UITableViewCellSeparatorStyle.none
        CurrentSelection_Tableview.bounces = false
        CurrentSelection_Tableview.backgroundColor = UIColor.clear
        self.view!.addSubview(CurrentSelection_Tableview)
        flag_Pop=1
       CurrentSelection_Tableview.isHidden = true
        CurrentSelection_Tableview.layer.borderColor = UIColor.lightGray.cgColor
        CurrentSelection_Tableview.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ShowReport(_ sender: Any) {
          Header_UiView.isHidden = false
         webServiceCalling1()
    }
    

    
    // MARK: TableView_Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Month_List.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "CELL")
        }
        
        
        cell!.textLabel?.text = "   \(Month_List[indexPath.row])"
        
        
        cell!.textLabel?.font = UIFont(name:"Avenir", size:14)
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Selected_month_Id = Month_List_Id_Array[indexPath.row]
        Selected_Month.text = Month_List[indexPath.row]
        flag_Pop = 1
        CurrentSelection_Tableview.isHidden = true
        
        month_Reference_Button.setTitle("   \(Month_List[indexPath.row])" , for: UIControlState())
        

     
            CurrentSelection_Tableview.isHidden = true
            image_monthList.image = UIImage(named: "down.png")
   
        
    }
    
  
    @IBAction func month_UIButton(_ sender: Any) {
        
        if flag_Pop==1
        {
            
            flag_Pop=0
            CurrentSelection_Tableview.isHidden = false
          image_monthList.image = UIImage(named: "up.png")
        }
        else
        {
            flag_Pop=1
            CurrentSelection_Tableview.isHidden = true
           image_monthList.image = UIImage(named: "down.png")
        }
    }
    
    @IBAction func menu_button_Action(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuPageViewController") as! menuPageViewController
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func  webServiceCalling1()
    {
        
        var request = URLRequest(url: URL(string: "http://52.29.203.220/demo/index.php/?parent_api/student_attendance/")!)
        
        request.httpMethod = "POST"
        let postString = "user_id=5&student_id=5&Month=\(Selected_month_Id)"
        
        
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
            
            
            if dict?.index(forKey: "studentDataArr") != nil {
                let studentDataArr = dict?["studentDataArr"] as! NSArray
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

 
    
   }
