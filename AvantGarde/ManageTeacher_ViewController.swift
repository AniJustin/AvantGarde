//
//  ManageTeacher_ViewController.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/20/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit
 var teacherDataArr : NSArray!
class ManageTeacher_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var ActivityControllerIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredArray : NSArray!
    var searchActive : Bool = false
    
    @IBOutlet weak var HeaderTableView: UIView!
    @IBOutlet weak var Background_View: UIView!
    @IBOutlet weak var manageteache_TableView: UITableView!
    var selectedIndex = -1
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Background_View.layer.borderWidth = 1
        Background_View.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        
       manageteache_TableView.layer.borderWidth = 1
       manageteache_TableView.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        
        HeaderTableView.layer.borderWidth = 1
        HeaderTableView.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor

        //Looks for single or multiple taps.
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ManageTeacher_ViewController.dismissKeyboard))
//    
//        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
//    func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//    //    view.endEditing(true)
//    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Put your key in predicate that is "Name"
        let searchPredicate = NSPredicate(format: "name CONTAINS[C] %@", searchText)
        filteredArray = (teacherDataArr as NSArray).filtered(using: searchPredicate) as NSArray!
        print ("array = \(filteredArray)")
        if(filteredArray.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
       manageteache_TableView.reloadData()
    }
   

    override func viewWillAppear(_ animated: Bool) {
         webServiceCalling()
    }
    func  webServiceCalling()
    {
//        ActivityControllerIndicator.isHidden = false
//        ActivityControllerIndicator.startAnimating()
        
   var request = URLRequest(url: URL(string: "http://52.29.203.220/demo/index.php/?parent_api/teacher_list/")!)
        
        request.httpMethod = "POST"
        let postString = "user_id=\(UserId!)"
        
        
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 600 {
            }
            
            
            let responseString = String(data: data, encoding: .utf8)
            let dict = self.convertToDictionary(text: responseString!)
            
//            self.ActivityControllerIndicator.isHidden = true
//            self.ActivityControllerIndicator.stopAnimating()
           
            
            if dict?.index(forKey: "teacherDataArr") != nil {
                teacherDataArr = dict?["teacherDataArr"] as! NSArray
                 DispatchQueue.main.async {
                self.manageteache_TableView.dataSource = self
                self.manageteache_TableView.delegate = self
                self.manageteache_TableView.reloadData()
                }
                
             
            }
            
        }
        task.resume()
    }
    @IBAction func Menu_button_Action(_ sender: Any) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuPageViewController") as! menuPageViewController
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredArray.count
        }
        else 
        {
        return teacherDataArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:Expansion_TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Expansion_TableViewCell
        
     
            let row = indexPath.row
    
  
            if(searchActive){
                if filteredArray.count != 0
                {
                let filteredArray_details = filteredArray[row] as! NSDictionary
          
                cell.namelabel.text = "\(filteredArray_details["name"]!)"
                cell.Specification_UiLabel.text = "\(filteredArray_details["specialisation"]!)"
                
                cell.Email_UILabel.text = "\(filteredArray_details["email"]!)"
        }
            } else {
            
                if teacherDataArr.count != 0
                {
                    
                    let TeacherFulldetails = teacherDataArr[row] as! NSDictionary

            cell.namelabel.text = "\(TeacherFulldetails["name"]!)"
              cell.Specification_UiLabel.text = "\(TeacherFulldetails["specialisation"]!)"
            
             cell.Email_UILabel.text = "\(TeacherFulldetails["email"]!)"
            }
        }
        if(selectedIndex == indexPath.row) {
          cell.plus_minus_ImageView.image = UIImage(named: "close.png")
        } else {
           cell.plus_minus_ImageView.image = UIImage(named: "Plus-26.png")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        let cell:Expansion_TableViewCell = tableView.cellForRow(at: indexPath) as! Expansion_TableViewCell
       
        if(selectedIndex == indexPath.row) {
            selectedIndex = -1
            
            cell.plus_minus_ImageView.image = UIImage(named: "close.png")
            //plus
        } else {
            selectedIndex = indexPath.row
            //minus
            cell.plus_minus_ImageView.image = UIImage(named: "Plus-26.png")
            
        }
        manageteache_TableView.beginUpdates()
        manageteache_TableView.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic )
        
        manageteache_TableView.endUpdates()
        manageteache_TableView.reloadData()
    }
   

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(selectedIndex == indexPath.row) {
            return 135;
        } else {
            return 50;
        }
    }
 
    @IBAction func BackButton(_ sender: Any) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.navigationController?.pushViewController(secondViewController, animated: false)
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
    
}

