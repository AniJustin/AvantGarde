//
//  menuPageViewController.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/20/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit

class menuPageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  var arrayForBool = NSMutableArray()
    @IBOutlet weak var MenuTableView: UITableView!
     var sectionvaluepass : Int!
    var GetActiveCategories_array = ["Dashboard","Teachers","Admission Form","Academic Syllabus","Class Routine","Exam Marks","Attendance Report","Progress Report","Payment","Library","Transport","Noticeboard","Message","Logout"]
      //  var name_array = ["Jude","Oliver"]
    
    var previousSelectedIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
         previousSelectedIndex = 1
       
initialization()
        // Do any additional setup after loading the view.
    }
    func initialization()
    {
        arrayForBool = NSMutableArray()
      //  sectionTitleArray = GetActiveCategories_array
        for q in 0 ..< GetActiveCategories_array.count
        {
            arrayForBool.add(Int(false))
        }
        MenuTableView.reloadData()
    }
    
    @IBAction func CloseButton_BackButton_Action(_ sender: Any) {
   self.navigationController?.popViewController(animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
      //  return 1
           return GetActiveCategories_array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return 5
        if Bool(arrayForBool[section] as! NSNumber)
        {
            return studentDataArr.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        

        if indexPath.section != 0 && indexPath.section != 1
        {
            

let name = studentDataArr[indexPath.row] as! NSDictionary
          cell.textLabel?.text = "          \(name["name"]!)"
           // cell.imageView?.image = UIImage(named: "avatar.png")
        }
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
//            self.navigationController?.pushViewController(secondViewController, animated: false)
//        }
        if sectionvaluepass == 2
        {
               studentData_firstStudent = studentDataArr[indexPath.row] as! NSDictionary
               studentData_firstStudentid = studentData_firstStudent["student_id"] as! String
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdmissionForm_ViewController") as! AdmissionForm_ViewController
    self.navigationController?.pushViewController(secondViewController, animated: false)
        }
        else if sectionvaluepass == 6
        {
            studentData_firstStudent = studentDataArr[indexPath.row] as! NSDictionary
            studentData_firstStudentid = studentData_firstStudent["student_id"] as! String
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AttendanceReport_ViewController") as! AttendanceReport_ViewController
            self.navigationController?.pushViewController(secondViewController, animated: false)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 280, height: 50))
        sectionView.tag = section
        let viewLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 0, width: MenuTableView.frame.size.width - 10, height: 50))
       // viewLabel.backgroundColor = UIColor.red
        viewLabel.textColor = UIColor.white
        
        viewLabel.text = "   \(GetActiveCategories_array[section])"
        
        sectionView.addSubview(viewLabel)
//        let imgView: UIImageView = UIImageView(image: UIImage(named: "avatar.png"))
//        imgView.frame = CGRect(x: 10, y: 10, width: 25, height: 25)
//        sectionView.addSubview(imgView)
       
        let headerTapped: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(sectionHeaderTapped(_:)))
        sectionvaluepass = Int(section)
        sectionView.addGestureRecognizer(headerTapped)
        sectionView.backgroundColor = UIColor.black
        
       
        
        return sectionView
        
    }
    func sectionHeaderTapped(_ gestureRecognizer: UITapGestureRecognizer)
    {
        if let gusture = gestureRecognizer.view!.tag as? Int
        {
            sectionvaluepass = Int(gestureRecognizer.view!.tag)
        }
            
        else
        {
            sectionvaluepass = 0
        }
        //    self.GetActiveSubCategories_array
        if sectionvaluepass == 0
        {
        
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            self.navigationController?.pushViewController(secondViewController, animated: false)
        
        
        }
        if sectionvaluepass == 1
        {
            
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ManageTeacher_ViewController") as! ManageTeacher_ViewController
            self.navigationController?.pushViewController(secondViewController, animated: false)
            
            
        }
        let indexPath: IndexPath = IndexPath(row: 0, section: gestureRecognizer.view!.tag)
        MenuTableView.beginUpdates()
        if indexPath.row == 0
        {
            var collapsed: Bool = Bool(arrayForBool[indexPath.section] as! NSNumber)
            collapsed = !collapsed
            if collapsed
            {
                
            }
            else
            {
                //   self.sliding()
                
                
            }
            
            arrayForBool.replaceObject(at: indexPath.section, with: Bool(collapsed))
            if previousSelectedIndex != indexPath.section
            {
                
                
                let range = NSMakeRange(previousSelectedIndex,1)
                let sectionToReload = IndexSet(integersIn: range.toRange() ?? 0..<0)
                MenuTableView.reloadSections(sectionToReload, with: .automatic)
                arrayForBool[previousSelectedIndex] = 0
            }
            
            
            let range = NSMakeRange(indexPath.section, 1)
            let sectionToReload = IndexSet(integersIn: range.toRange() ?? 0..<0)
            MenuTableView.reloadSections(sectionToReload, with: .automatic)
            
            
            
        
        }
        
        previousSelectedIndex = indexPath.section
        MenuTableView.endUpdates()
        
    }

}
