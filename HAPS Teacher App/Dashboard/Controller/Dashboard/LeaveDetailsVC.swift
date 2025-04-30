//
//  LeaveDetailsVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 16/08/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class LeaveDetailsVC: UIViewController {
    var leaveTypeName: String?
    var leaveDetailObj: LeaveDetailModel?
    var branchIds = ""
    
    @IBOutlet weak var leaveDetailsTblView: UITableView!
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        leaveDetailAPI(leaveType: leaveTypeName ?? "")
        switch leaveTypeName {
        case "OnDuty":
            backBtn(title: "On-Duty Employees’ Report")
        case "FullDay":
            backBtn(title: "On Leave Employees’ Report")
        case "ShortLeave":
            backBtn(title: "On Leave Employees’ Report")
        default:
            print("Unknown ")
        }
        leaveDetailsTblView.emptyDataSetSource = self
        leaveDetailsTblView.emptyDataSetDelegate = self
    }

}
extension LeaveDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaveDetailObj?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaveDetailCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.leaveDetailsCell.getIdentifier, for: indexPath) as! LeaveDetailsTblCell
        leaveDetailCell.totalDaysLbl.text = leaveDetailObj?.response?[indexPath.row].leaveValue
        leaveDetailCell.employeeNameLbl.text = leaveDetailObj?.response?[indexPath.row].empName
        leaveDetailCell.dateLbl.text = leaveDetailObj?.response?[indexPath.row].leaveDate
        return leaveDetailCell
    }
    
    
}
extension LeaveDetailsVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage(str: AppMessages.MSG_NO_DATA_FOUND)
    }
}

extension LeaveDetailsVC {
    func leaveDetailAPI(leaveType:String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_OnLeaveEmployeeReport.getEndPoints).php?branchid=\(branchIds)&LeaveTypeName=\(leaveType)&sessionid=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_OnLeaveEmployeeReport.getEndPoints, apiRequestURL: strUrl)
    }
}
extension LeaveDetailsVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_OnLeaveEmployeeReport.getEndPoints {
            let status = response["status"] as! Int
            let message = response["message"] as! String
            if status == 1 {
                if let leaveDetailDictData = Mapper<LeaveDetailModel>().map(JSONObject: response) {
                    leaveDetailObj = leaveDetailDictData
                    DispatchQueue.main.async {
                        self.headerView.isHidden = false
                        self.leaveDetailsTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.headerView.isHidden = true
                    //CommonObjects.shared.showToast(messege: message, controller: self)
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
//
