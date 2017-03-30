//
//  DashboardViewController.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/7/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit
var UserId : String!
var UserType : String!
var addArray : Array<Any>!
var studentDataArr : Array<Any>!
var studentData_firstStudent : NSDictionary!
var studentData_firstStudentid : String!
 //var studentDetails_Arr : NSDictionary!
class DashboardViewController: UIViewController {
    
    @IBOutlet weak var LogOut_Reference_Button: UIButton!
    


    @IBOutlet weak var DashBoardCollectionView: UICollectionView!
    var HomePage_ArrayList = ["Teachers","Attendance","Progress Report","PTM","Exam","ProgrssCard","Student Fees","Feedback"]
     var DashBoard_ImageArray = ["Gender.png","Area.png","Book.png","Clock.png","Check Book.png","noticeboard.png","Message .png","Soccer.png"]
    
  //  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var NotificationButton_Reference: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        webServiceCalling_GetChild()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
    
        
    
        
//        activityIndicator.isHidden = false
//        activityIndicator.startAnimating()
//        
//        
//        activityIndicator.stopAnimating()
//        activityIndicator.isHidden = true
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
    
        if DeviceType.IS_IPHONE_4_OR_LESS {
            return CGSize(width: 92, height: 97)
       }
    
        else if DeviceType.IS_IPHONE_5 {
            return CGSize(width: 149, height: 149)
        }
    
        else if DeviceType.IS_IPHONE_6 {
            return CGSize(width: 176, height: 176)
        }
    
        else if DeviceType.IS_IPHONE_6P {
           return CGSize(width: 196, height: 196)
        }
    
        else if DeviceType.IS_IPAD {
            return CGSize(width: 230, height: 230)
        }
    
       else {
            return CGSize(width: 95, height: 80)
        }
    }
    
    
    
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsetsMake(0, 0, 0, 0)
    //    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return HomePage_ArrayList.count
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [],
                                   animations: {
                                    cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                                    
        },
                                   completion: { finished in
                                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .transitionCurlUp,
                                                               animations: {
                                                                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    },
                                                               completion: nil
                                    )
                                    
        }
        )
        
        
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        let imagedash = cell.viewWithTag(2) as! UIImageView
        imagedash.image = UIImage(named: DashBoard_ImageArray[indexPath.row])
  //  DashboardImage.image = UIImage(named: DashBoard_ImageArray[indexPath.row])
        
        let label = cell.viewWithTag(1) as! UILabel
        label.text = HomePage_ArrayList[indexPath.item]

    
        if indexPath.row == 0
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0xE7417C)
        }
        if indexPath.row == 1
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0x9FCD52)
        }
        if indexPath.row == 2
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0xA844C3)
        }
        if indexPath.row == 3
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0x3CC5DD)
        }
        if indexPath.row == 4
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0xFDCC00)
        }
        if indexPath.row == 5
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0xE35039)
        }
        if indexPath.row == 6
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0x5C69C6)
        }
        if indexPath.row == 7
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0x3AB4FC)
        }
        
        if indexPath.row == 8
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0xFA7236)
        }
        if indexPath.row == 9
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0x9FCD52)
        }
        
        if indexPath.row == 10
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0xE7417C)
        }
        if indexPath.row == 11
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0x3AB4FC)
        }
        
        if indexPath.row == 12
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0xE35039)
        }
        
        if indexPath.row == 13
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0xFDCC00)
        }
        if indexPath.row == 14
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0x5C69C6)
        }
        if indexPath.row == 15
        {
            cell.contentView.backgroundColor = UIColorFromRGB(0x3CC5DD)
        }
       

        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        if indexPath.row == 0 {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ManageTeacher_ViewController") as! ManageTeacher_ViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
     
        }
        if indexPath.row == 1 {
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdmissionForm_ViewController") as! AdmissionForm_ViewController
//            self.navigationController?.pushViewController(secondViewController, animated: true)
         
        }
        if indexPath.row == 3 {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AttendanceReport_ViewController") as! AttendanceReport_ViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
        }
        if indexPath.row == 4{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusDriver_DashboardViewController") as! BusDriver_DashboardViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
          
        }
        if indexPath.row == 7{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Parent_Transport_ViewController") as! Parent_Transport_ViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
          
        }
        if indexPath.row == 11{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Feedback_ViewController") as! Feedback_ViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
           
        }
    }
  

  
    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    @IBAction func LogOut_Action(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Notification Button Action

    @IBAction func NotificationButton(_ sender: Any) {
        shake(count: 5, for: 1.5, withTranslation: 10)
        perform(#selector(DashboardViewController.Next), with: nil, afterDelay: 1)
    }

    func Next()
    {
        print("next")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(secondViewController, animated: false)
        
    }
    
    
 
    func  webServiceCalling_GetChild()
    {
     
        var request = URLRequest(url: URL(string: "http://52.29.203.220/demo/index.php/?parent_api/my_cheild/")!)
        
        request.httpMethod = "POST"
        let postString = "user_id=\(UserId!)"
        
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
            
            
            if dict?.index(forKey: "studentDataArr") != nil {
               studentDataArr = dict?["studentDataArr"] as! Array
                if studentDataArr.count != 0
                {
                    studentData_firstStudent = studentDataArr[0] as! NSDictionary
                    studentData_firstStudentid = studentData_firstStudent["student_id"] as! String
                }
                
//                let name = studentDataArr[0] as! NSDictionary
//           
//                print(name)
//               let name1 = name["name"]
//                print(name1!)
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
    //public extension UIView {
    
    func shake(count : Float? = nil,for duration : TimeInterval? = nil,withTranslation translation : Float? = nil) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        animation.repeatCount = count ?? 2
        animation.duration = (duration ?? 0.5)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? -5
        NotificationButton_Reference.layer.add(animation, forKey: "shake")
        //   }
    }

   
}
