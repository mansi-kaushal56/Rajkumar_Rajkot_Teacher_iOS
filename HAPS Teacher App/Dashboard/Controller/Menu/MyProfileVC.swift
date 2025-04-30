//
//  MyProfileVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/07/23.
//

import UIKit
import ObjectMapper
import Kingfisher

class MyProfileVC: UIViewController {
    var userDefaultData = UserDefaults.getUserDetail()

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var dojLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var mySalaryViewOtl: ViewBorder!
    @IBOutlet weak var changePswdViewOtl: ViewBorder!
    @IBOutlet weak var dapartmentLbl: UILabel!
    
    @IBOutlet weak var leaveRecordView: UIView!
    @IBOutlet weak var ApplyLeaveViewOtl: ViewBorder!
    @IBOutlet weak var teacherImgView: UIImageView!
    @IBOutlet weak var tNameLbl: UILabel!
    @IBOutlet weak var empCodeLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
    
    
    
    var myProfileObj : MyProfileModel?
    var userObj : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myProfileAPI()
        showProfileData()
        backBtn(title: "Edit Profile")
        
        let password = UITapGestureRecognizer()
        changePswdViewOtl.addGestureRecognizer(password)
        password.addTarget(self, action: #selector(changePswd))
        
        let mySalary = UITapGestureRecognizer()
        mySalaryViewOtl.addGestureRecognizer(mySalary)
        mySalary.addTarget(self, action: #selector(salaryCheck))
        
        let applyLeave = UITapGestureRecognizer()
        ApplyLeaveViewOtl.addGestureRecognizer(applyLeave)
        applyLeave.addTarget(self, action: #selector(applyForLeave))
        
        let leaveRecord = UITapGestureRecognizer()
        leaveRecordView .addGestureRecognizer(leaveRecord)
        leaveRecord.addTarget(self, action: #selector(allLeaveRecords))
        // Do any additional setup after loading the view.
    }
    //Date:: 12, Apr 2024 - api call to reload the image
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myProfileAPI()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.editProfileSegue.getDescription {
            if let destinationVC = segue.destination as? EditProfileVC {
                destinationVC.myProfileObj = myProfileObj
            }
        }
            
    }
    func showProfileData() {
//        let img = (UserDefaults.getUserDetail()?.profil_pic ?? "")
        let img = (myProfileObj?.empImage ?? "")
        let imgUrl = URL(string: img)
        teacherImgView.kf.setImage(with: imgUrl,placeholder: UIImage.placeHolderImg)
        tNameLbl.text = userDefaultData?.name
        empCodeLbl.text = "Emp Code - \(userDefaultData?.EmpCode ?? "")"
        designationLbl.text = userDefaultData?.DesignationName
        
    }
    func showData() {
        dapartmentLbl.text = myProfileObj?.department
        addressLbl.text = myProfileObj?.address
        mobileLbl.text = myProfileObj?.mobileno
        dobLbl.text = userDefaultData?.DOB
        dojLbl.text = userDefaultData?.DOJ
    }
    @objc func allLeaveRecords() {
        performSegue(withIdentifier: AppStrings.AppSegue.leaveRecordSegue.getDescription, sender: nil)
    }
    @objc func applyForLeave() {
        performSegue(withIdentifier: AppStrings.AppSegue.applyLeaveSegue.getDescription, sender: nil)
    }
    @objc func changePswd() {
        performSegue(withIdentifier: AppStrings.AppSegue.changePswdSegue.getDescription, sender: nil)
    }
    @objc func salaryCheck() {
        performSegue(withIdentifier: AppStrings.AppSegue.mySalarySegue.getDescription, sender: nil)
    }

    @IBAction func editProfileBtn(_ sender: UIButton) {
        performSegue(withIdentifier: AppStrings.AppSegue.editProfileSegue.getDescription, sender: nil)
    }
}
extension MyProfileVC {
    func myProfileAPI() {
        CommonObjects.shared.showProgress()
//        let parameters:[String:Any] = ["EmpCode": UserDefaults.getUserDetail()?.EmpCode ?? "",
//                          "SessionId": UserDefaults.getUserDetail()?.Session ?? "",
//                          "BranchId": UserDefaults.getUserDetail()?.BranchId ?? ""]
        //print( UserDefaults.getUserDetail()?.EmpCode ?? "")
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Profile.getEndPoints).php?EmpCode=\(userDefaultData?.EmpCode ?? "")&SessionId=\(userDefaultData?.Session ?? "")&BranchId=\(userDefaultData?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Profile.getEndPoints, apiRequestURL: strUrl)
//        obj.testrequestAPI(apiName:"\(END_POINTS.Api_Profile.getEndPoints)", parameters: parameters)
    }

}
extension MyProfileVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Profile.getEndPoints {
            let status = response["status"] as? Bool
            if status == true {
                if let myProfileDictData = Mapper<MyProfileModel>().map(JSONObject: response) {
                    myProfileObj = myProfileDictData
                    UserDefaults.standard.setValue(myProfileObj?.empImage, forKey: "ProfileImage")
                    print(myProfileDictData)
                    DispatchQueue.main.async {
                        self.showData()
                        self.showProfileData()
                    }
                }
            }
        }
    }
    
    func failure() {
        
    }
}

