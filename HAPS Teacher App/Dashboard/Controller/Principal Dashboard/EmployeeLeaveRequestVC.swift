//
//  EmployeeLeaveRequestVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/10/23.
//

import UIKit
import ObjectMapper

class EmployeeLeaveRequestVC: UIViewController {
    var employeeLeaveStatusObj: MedicalEntryModel?
    var employeeLeaveRequestObj: EmployeeLeaveRequestModel?
    
    @IBOutlet weak var totalRequestLbl: UILabel!
    @IBOutlet weak var leaveDetailTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Employee Leave Request")
        
        leaveReportAPI()
        // Do any additional setup after loading the view.
    }
    @objc func approvedLeave() {
        approveAndRejectApi(statusType: "Approved")
    }
    @objc func rejectLeave() {
        approveAndRejectApi(statusType: "Reject")
    }

}
extension EmployeeLeaveRequestVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeLeaveRequestObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaveCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.leaveCell.getIdentifier, for: indexPath) as! EmpLeaveRequestTblCell
        leaveCell.leaveDetailView.clipsToBounds = true
        let empLeaveDetail = employeeLeaveRequestObj?.response?.rest?[indexPath.row]
        leaveCell.daysLbl.text = empLeaveDetail?.days
        leaveCell.reasonForLeaveLbl.text = empLeaveDetail?.reason
        leaveCell.dateToLbl.text = empLeaveDetail?.dateTo
        leaveCell.dateFromLbl.text = empLeaveDetail?.dateFrom
        leaveCell.empCodeLbl.text = empLeaveDetail?.empCode
        leaveCell.empNameLbl.text = empLeaveDetail?.empName
        //MARK: (19-OCT-2023)
        let approvedLeaveTap = UITapGestureRecognizer(target: self, action: #selector(approvedLeave))
        leaveCell.approvedView.addGestureRecognizer(approvedLeaveTap)
        
        let rejectLeaveTap = UITapGestureRecognizer(target: self, action: #selector(rejectLeave))
        leaveCell.rejectView.addGestureRecognizer(rejectLeaveTap)
        
        return leaveCell
    }
}
extension EmployeeLeaveRequestVC {
    func leaveReportAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Employee_Leave_Request.getEndPoints).php?branchid=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Employee_Leave_Request.getEndPoints, apiRequestURL: strUrl)
    }
    func approveAndRejectApi(statusType: String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Approved_Reject_Leave.getEndPoints).php?levelid=\("")&status=\(statusType)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Approved_Reject_Leave.getEndPoints, apiRequestURL: strUrl)
    }
}
extension EmployeeLeaveRequestVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Employee_Leave_Request.getEndPoints {
            let status = response["status"] as! String
            let message = response["message"] as! String
            if status == "SUCCESS" {
                if let empLeaveRequestDictData = Mapper<EmployeeLeaveRequestModel>().map(JSONObject: response) {
                    employeeLeaveRequestObj = empLeaveRequestDictData
                    DispatchQueue.main.async {
                        self.leaveDetailTblView.reloadData()
                        self.totalRequestLbl.text = "\(self.employeeLeaveRequestObj?.response?.rest?.count ?? 0)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Approved_Reject_Leave.getEndPoints {
            let status = response["status"] as! String
            let message = response["message"] as! String
            if status == "true" {
                if let empLeaveStatusDictData = Mapper<MedicalEntryModel>().map(JSONObject: response) {
                    employeeLeaveStatusObj = empLeaveStatusDictData
                   
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
        
