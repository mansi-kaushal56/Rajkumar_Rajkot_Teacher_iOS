//
//  LogInVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 25/07/23.
//

import UIKit
import ObjectMapper

class LogInVC: UIViewController {

    @IBOutlet weak var userpasswordTxtFld: UITextField!
    @IBOutlet weak var usernameTxtFld: UITextField!
    var userObj : UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        //HAPS Teacher login
//        usernameTxtFld.text = "Vipansharma.307"
//        userpasswordTxtFld.text = "sunrise@123"
        
        //RKC Teacher login
        usernameTxtFld.text = "SHREYA.1457"
        userpasswordTxtFld.text = "Rkc@123"
        
        
//        usernameTxtFld.text = "DRGAUTAMMANDAL.661"
//        userpasswordTxtFld.text = "1234"
//        usernameTxtFld.text = "JKSharma"
//        userpasswordTxtFld.text = "Jitendra@1970"
        
//        usernameTxtFld.text = "vineetagupta.27"
//        userpasswordTxtFld.text = "123"
        
        /*Sanawar Teacher Login Credentials
        usernameTxtFld.text = " HITENDERS.JAMWAL.535"
        userpasswordTxtFld.text = "Hitender@321"
         */
    }
    @IBAction func logInBtn(_ sender: UIButton) {
        //performSegue(withIdentifier: AppSegue.dashboardSegue.getDescription, sender: nil)
        loginAPI()
    }
}
extension LogInVC {
    func loginAPI() {
       
        if usernameTxtFld.text!.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_USERNAME_EMPTY, controller: self)
            return
        }
        if userpasswordTxtFld.text!.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_PASSWORD_EMPTY, controller: self)
            return
        }
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Login.getEndPoints).php?email=\(usernameTxtFld.text ?? "")&password=\(userpasswordTxtFld.text ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Login.getEndPoints, apiRequestURL: strUrl)
        
    }
}
extension LogInVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Login.getEndPoints {
            let APIResponse = response["response"] as! String
            if APIResponse == "Logged" {
                if let userModelDictData = Mapper<UserModel>().map(JSONObject: response) {
                    userObj = userModelDictData
                    UserDefaults.setUserDetail(userModelDictData)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: AppStrings.AppSegue.dashboardSegue.getDescription, sender: nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_LOGIN_FAIL, controller: self)
                }
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
