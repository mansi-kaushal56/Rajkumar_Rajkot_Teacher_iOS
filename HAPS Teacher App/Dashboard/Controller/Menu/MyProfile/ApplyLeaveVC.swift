//
//  ApplyLeaveVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 07/08/23.
//

import UIKit
import ObjectMapper

class ApplyLeaveVC: UIViewController {
    
    var leavesTypeObj: LeaveTypeModel?
    var selLeveType: LeaveTypeRest?
    
    @IBOutlet weak var leaveTypeView: UIView!
    @IBOutlet weak var leaveTypeLbl: UILabel!
    @IBOutlet weak var totalDaysLbl: UILabel!
    
    @IBOutlet weak var reasonLeaveTxtView: UITextView!
    
    @IBOutlet weak var toLeaveDateTxtFld: UITextField!
    @IBOutlet weak var fromLeaveDateTxtFld: UITextField!
    @IBOutlet weak var ibapplyLeaveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Apply Leave")
        datePickersInView()
        tapGestures()
        ibapplyLeaveBtn.isHidden = true
        leaveTypeView.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func applyLeaveBtn(_ sender: UIButton) {
        applyLeaveAPI()
    }
    @objc func datePicker2(_ sender:UITapGestureRecognizer){
        if let datePicker = self.fromLeaveDateTxtFld.inputView as? UIDatePicker {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: datePicker.date)
            datePicker.minimumDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            if let selectedHour = components.hour, selectedHour >= 8,
               let selectedDate = calendar.date(from: components),
               calendar.isDateInToday(selectedDate) {
                // Show an alert if the selected hour is 8 AM or later
                showAlert(title: "Alert", message: AppMessages.MSG_APPLY_LEAVE_ALERT)
            }
            self.fromLeaveDateTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
           self.fromLeaveDateTxtFld.resignFirstResponder()
       }
    @objc func datePicker3(_ sender:UITapGestureRecognizer){
        if let datePicker = self.toLeaveDateTxtFld.inputView as? UIDatePicker {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: datePicker.date)
            datePicker.minimumDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            if let selectedHour = components.hour, selectedHour >= 8,
               let selectedDate = calendar.date(from: components),
               calendar.isDateInToday(selectedDate) {
                // Show an alert if the selected hour is 8 AM or later
                showAlert(title: "Alert", message: AppMessages.MSG_APPLY_LEAVE_ALERT)
            }
            
            self.toLeaveDateTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
           self.toLeaveDateTxtFld.resignFirstResponder()
       }
    func countDaysBetween(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day], from: start, to: end)
        return (components.day ?? 0) + 1
    }
    func tapGestures() {
        leaveTypeView.addTapGestureRecognizer {
            self.showLeaveTypeList()
        }
    }
    func showLeaveTypeList() {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.listAppearVC.getIdentifier) as! ListAppearVC
        vc.modalPresentationStyle = .overFullScreen
        vc.leaveTypeObj = leavesTypeObj
        vc.type = .LeaveTypeList
        vc.senderDelegate = self
        self.present(vc, animated: true)
    }
    func datePickersInView() {
        self.fromLeaveDateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker2))
        self.toLeaveDateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker3))
    }
}
extension ApplyLeaveVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        selLeveType = data as? LeaveTypeRest
        leaveTypeLbl.text = selLeveType?.leaveTypeName
    }
}
extension ApplyLeaveVC {
    func leavetypeApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Leavetype.getEndPoints).php?EmpType=\(UserDefaults.getUserDetail()?.EmpTypeID ?? "")&DateFrom=\(fromLeaveDateTxtFld.text ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Leavetype.getEndPoints, apiRequestURL: strUrl)
    }
    func applyLeaveAPI() {
        
        let reasonOfLeave = reasonLeaveTxtView.text ?? ""
        if reasonOfLeave.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_REASON_OF_LEAVE_EMPTY, controller: self)
            return
        }
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Apply_Leave.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&LeaveType=\(leaveTypeLbl.text ?? "")&DateFrom=\(fromLeaveDateTxtFld.text ?? "")&DateTo=\(toLeaveDateTxtFld.text ?? "")&reason=\(reasonOfLeave)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Apply_Leave.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
extension ApplyLeaveVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Apply_Leave.getEndPoints {
            //Date:: 12, Apr 2024 - change the status bool to string
            let status = response["status"] as? String
            let message = response["message"] as? String
            if status == "SUCCESS" {
                DispatchQueue.main.async {
                    //Date:: 12, Apr 2024 - And custom message added.
                    CommonObjects.shared.showToast(message: AppMessages.MSG_LEAVE_APPLIED_SUCCESS)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        if api == END_POINTS.Api_Leavetype.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                if let leaveTypeDictData = Mapper<LeaveTypeModel>().map(JSONObject: response) {
                    leavesTypeObj = leaveTypeDictData
                    DispatchQueue.main.async {
                        self.leaveTypeLbl.text = self.leavesTypeObj?.response?.rest?[0].leaveTypeName
                    }
                    
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
extension ApplyLeaveVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == toLeaveDateTxtFld {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            if let startDateString = fromLeaveDateTxtFld.text,
               let endDateString = toLeaveDateTxtFld.text,
               let startDate = dateFormatter.date(from: startDateString),
               let endDate = dateFormatter.date(from: endDateString) {
                let numberOfDays = countDaysBetween(startDate: startDate, endDate: endDate)
                let numberOfDaysString = "\(numberOfDays)"
                totalDaysLbl.text = numberOfDaysString
                print(startDateString)
                print(endDateString)
            } else {
                totalDaysLbl.text = "0"
            }
            ibapplyLeaveBtn.isHidden = false
        }
        if textField == fromLeaveDateTxtFld {
            leavetypeApi()
            leaveTypeView.isHidden = false
        }
    }
}
