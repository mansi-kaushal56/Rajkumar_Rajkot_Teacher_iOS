//
//  ChangePasswordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 01/08/23.
//

import UIKit
import ObjectMapper

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var confirmPassTxtFld: UITextField!
    @IBOutlet weak var newPassTxtFld: UITextField!
    @IBOutlet weak var oldPassTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Change Password")
        // Do any additional setup after loading the view.
    }
    @IBAction func resetPassBtn(_ sender: UIButton) {
        changePassApi()
    }
    
}
extension ChangePasswordVC {
    func changePassApi() {
        let oldPassword = oldPassTxtFld.text ?? ""
        if oldPassword.isEmpty  {
            CommonObjects.shared.showToast(message: AppMessages.MSG_OLDPASSWORD_EMPTY, controller: self)
            return
        }
        let newPassword = newPassTxtFld.text ?? ""
        if newPassword.isEmpty || newPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_NEW_PASSWORD_EMPTY, controller: self)
            return
        }
        let confirmPassword = confirmPassTxtFld.text ?? ""
        if confirmPassword.isEmpty || confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_CONFIRM_PASSWORD_EMPTY, controller: self)
            return
        }
        if newPassword != confirmPassword {
            CommonObjects.shared.showToast(message: AppMessages.MSG_PASSWORD_NOT_MATCH, controller: self)
            return
        }
        //        if oldPassword == newPassword {
        //            CommonObjects.shared.showToast(massege: AppMessages.MSG_CANNOT_SET_THE_PREVIOUS_PASSWORD, controller: self)
        //            return
        //        }
        //        if !newPassword.validatePassword() {
        //            CommonObjects.shared.showToast(massege: AppMessages.MSG_VALIDATE_PASSWORD, controller: self)
        //            return
        //        }
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Changepass.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&oldpassword=\(oldPassword)&newpassword=\(newPassword)&confirmpassword=\(confirmPassword)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Changepass.getEndPoints, apiRequestURL: strUrl)
    }
}
extension ChangePasswordVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Changepass.getEndPoints {
            let status = response["status"] as! String
            let message = response["message"] as! String
            if status == "SUCCESS" {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_PASSWORD_UPDATE_SUCCESS)
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
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
