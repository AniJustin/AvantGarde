//
//  AdmissionForm_ViewController.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/25/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit

class AdmissionForm_ViewController: UIViewController {


    @IBOutlet weak var TypeOfFamily_Nuclear_B: UIButton!
    @IBOutlet weak var TypeOfFamily_Joint: UIButton!
    @IBOutlet weak var NeedTransportation_Yes_B: UIButton!
    @IBOutlet weak var NeedTransportation_No_B: UIButton!
    @IBOutlet weak var MedicalProblem_Yes_B: UIButton!
    @IBOutlet weak var medicalProblem_No_B: UIButton!
   
   
    @IBOutlet var NoDataAvailable_View: UILabel!
  
    @IBOutlet weak var Gender_textField: UITextField!
    @IBOutlet weak var Age_TextField: UITextField!
    @IBOutlet weak var DOB_TextField: UITextField!
    @IBOutlet weak var nextClass_TextField: UITextField!
    @IBOutlet weak var ScrollView_ContentSize: UIScrollView!
    @IBOutlet weak var studentInformation_ViewController: UIView!
    @IBOutlet weak var MainBackground_UiView: UIView!
    
    @IBOutlet weak var StudentFirstName_TextField: UITextField!
    @IBOutlet weak var StudentLastName_TextField: UITextField!
    @IBOutlet weak var PreviousClass_TextField: UITextField!
    @IBOutlet weak var previousSchool_TextField: UITextField!
    @IBOutlet weak var Category_TextField: UITextField!
    
    
    
    @IBOutlet weak var FatherFirstName_TextField: UITextField!
    @IBOutlet weak var FatherLastName_TextField: UITextField!
    @IBOutlet weak var Education_TextField: UITextField!
    @IBOutlet weak var Occupation_TextField: UITextField!
    @IBOutlet weak var DepartmentIndustry_TextField: UITextField!
    @IBOutlet weak var Designation_textField: UITextField!
    @IBOutlet weak var AnnualIncome_TextField: UITextField!
    @IBOutlet weak var EmailId_TextField: UITextField!
    @IBOutlet weak var MoblieNumber_TextField: UITextField!
    @IBOutlet weak var EmergenctContactNumber_TextField: UITextField!
    @IBOutlet weak var MotherFirstName_TextField: UITextField!
    @IBOutlet weak var MotherLastname_TextField: UITextField!
   
    
    @IBOutlet weak var SchoolCollege_TextField: UITextField!
    @IBOutlet weak var GeneralInformation_View: UIView!
    var studentDetails_Arr : NSDictionary!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainBackground_UiView.layer.borderWidth = 1
        MainBackground_UiView.layer.borderColor = UIColor.red.cgColor
        MainBackground_UiView.layer.cornerRadius = 5
        MainBackground_UiView.layer.masksToBounds = true
        
        studentInformation_ViewController.layer.borderWidth = 1
        studentInformation_ViewController.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        studentInformation_ViewController.layer.cornerRadius = 5
        studentInformation_ViewController.layer.masksToBounds = true
        
        GeneralInformation_View.layer.borderWidth = 1
        GeneralInformation_View.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        GeneralInformation_View.layer.cornerRadius = 5
        GeneralInformation_View.layer.masksToBounds = true
        
        if studentDataArr.count != 0
        {
     //   studentData_firstStudent = studentDataArr[0] as! NSDictionary
     //   studentData_firstStudentid = studentData_firstStudent["student_id"] as! String
        
        webServiceCalling1()
        }
        // Do any additional setup after loading the view.
    }
    func  webServiceCalling1()
    {
        
        var request = URLRequest(url: URL(string: "http://52.29.203.220/demo/index.php/?parent_api/admission_student_details/")!)
        
        request.httpMethod = "POST"
        let postString = "user_id=\(UserId!)&student_id=\(studentData_firstStudentid!)"
        
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
              DispatchQueue.main.async {
            if (dict?["studentDetails"] as? NSDictionary) != nil {
                   self.studentDetails_Arr = dict?["studentDetails"] as! NSDictionary!
                self.DataDisplay()
                            }
                            else {
                self.ScrollView_ContentSize.isHidden = true
               self.NoDataAvailable_View.frame.origin.y = 71
               self.view.addSubview(self.NoDataAvailable_View)
                                print("Failure")
                            }
            }
        }
        task.resume()
        
    }
    func DataDisplay()
    {
        DispatchQueue.main.async {
            
            self.ScrollView_ContentSize.contentSize = CGSize(width: 0, height: self.MainBackground_UiView.frame.maxY + 3650)
       //     print(self.studentDetails_Arr)
            self.StudentFirstName_TextField.text = "\(self.studentDetails_Arr["student_fname"]!)"
            self.StudentLastName_TextField.text = "\(self.studentDetails_Arr["student_lname"]!)"
            self.PreviousClass_TextField.text = "\(self.studentDetails_Arr["previous_class"]!)"
            self.previousSchool_TextField.text = "\(self.studentDetails_Arr["previous_school"]!)"
            self.Category_TextField.text = "\(self.studentDetails_Arr["caste_category"]!)"
          
            
        //   self.nextClass_TextField.text = "\(self.studentDetails_Arr[""]!)"
            self.DOB_TextField.text = "\(self.studentDetails_Arr["birthday"]!)"
       //     self.Age_TextField.text = "\(self.studentDetails_Arr[""]!)"
            self.Gender_textField.text = "\(self.studentDetails_Arr["gender"]!)"
            self.Category_TextField.text = "\(self.studentDetails_Arr["caste_category"]!)"
            self.Category_TextField.text = "\(self.studentDetails_Arr["caste_category"]!)"
            
            self.FatherFirstName_TextField.text = "\(self.studentDetails_Arr["parent_fname"]!)"
            self.FatherLastName_TextField.text = "\(self.studentDetails_Arr["parent_lname"]!)"
            self.EmailId_TextField.text = "\(self.studentDetails_Arr["user_email"]!)"
            self.MoblieNumber_TextField.text = "\(self.studentDetails_Arr["work_phone"]!)"
            self.MotherFirstName_TextField.text = "\(self.studentDetails_Arr["mother_fname"]!)"
            self.MotherLastname_TextField.text = "\(self.studentDetails_Arr["mother_lname"]!)"
            
            
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Back_Button(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
  
   

    @IBAction func menuButton(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuPageViewController") as! menuPageViewController
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    @IBAction func Nuclear_Action(_ sender: Any) {
      

        
        
            TypeOfFamily_Nuclear_B.setImage(UIImage(named: "Select.png"), for: UIControlState.normal)
        TypeOfFamily_Joint.setImage(UIImage(named: "unselect.png"), for: UIControlState.normal)

        
    }
    
    
    @IBAction func Joint_Action(_ sender: Any) {
     
TypeOfFamily_Nuclear_B.setImage(UIImage(named: "unselect.png"), for: UIControlState.normal)
   TypeOfFamily_Joint.setImage(UIImage(named: "Select.png"), for: UIControlState.normal)
    }
    @IBAction func NeedTransportation_Yes_Action(_ sender: Any) {
     
   
        NeedTransportation_No_B.setImage(UIImage(named: "unselect.png"), for: UIControlState.normal)
        NeedTransportation_Yes_B.setImage(UIImage(named: "Select.png"), for: UIControlState.normal)
        
    }
    @IBAction func NeedTransportation_No_Action(_ sender: Any) {
        
        NeedTransportation_No_B.setImage(UIImage(named: "Select.png"), for: UIControlState.normal)
        NeedTransportation_Yes_B.setImage(UIImage(named: "unselect.png"), for: UIControlState.normal)
    }
    @IBAction func MedicalProblem_Yes_Action(_ sender: Any) {
        medicalProblem_No_B.setImage(UIImage(named: "unselect.png"), for: UIControlState.normal)
        MedicalProblem_Yes_B.setImage(UIImage(named: "Select.png"), for: UIControlState.normal)
    }
    @IBAction func MedicalProblemNo_Action(_ sender: Any) {
        medicalProblem_No_B.setImage(UIImage(named: "Select.png"), for: UIControlState.normal)
        MedicalProblem_Yes_B.setImage(UIImage(named: "unselect.png"), for: UIControlState.normal)
    }
    
    @IBAction func ChoosePhoto_UIButton(_ sender: Any) {
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
