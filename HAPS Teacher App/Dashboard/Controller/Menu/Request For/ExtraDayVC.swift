//
//  ExtraDayVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 14/09/23.
//

import UIKit

class ExtraDayVC: UIViewController {
    let dateFormatter = DateFormatter()

    @IBOutlet weak var viewRequestListView: UIView!
    @IBOutlet weak var reasonTxtView: UITextView!
    @IBOutlet weak var dateTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Extra Day Request")
        
        let viewRequestListTap = UITapGestureRecognizer()
        viewRequestListView.addGestureRecognizer(viewRequestListTap)
        viewRequestListTap.addTarget(self, action: #selector(viewRequestList))
        
        self.dateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker))
        dateFormatter.dateFormat = "dd-MM-yyyy"
        // Do any additional setup after loading the view.
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
        submitExtraDayApi()
    }
    @objc func datePicker(_ sender:UITapGestureRecognizer){
        if let datePicker = self.dateTxtFld.inputView as? UIDatePicker {
            self.dateTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateTxtFld.resignFirstResponder()
    }
    @objc func viewRequestList() {
        performSegue(withIdentifier: AppStrings.AppSegue.requestDetailSegue.getDescription, sender: nil)
    }
}

extension ExtraDayVC {
    func submitExtraDayApi() {
        let date = dateTxtFld.text ?? ""
        if date.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DATE_EMPTY)
            return
        }
        let reason = reasonTxtView.text ?? ""
        if reason.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_REASON_OF_EXTRA_DAYS_EMPTY)
            return
        }
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Submit_Extra_Day.getEndPoints).php?date=\(date)&reason=\( reason)&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Submit_Extra_Day.getEndPoints, apiRequestURL: strUrl)
    }
}
extension ExtraDayVC:RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Submit_Extra_Day.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_SUBMIT_EXTRA_DAY_DAYS_SUCCESS)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR)
        }
    }
}
