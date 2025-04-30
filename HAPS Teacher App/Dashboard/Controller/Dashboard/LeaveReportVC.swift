//
//  LeaveReportVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/08/23.
//

import UIKit
import ObjectMapper

class LeaveReportVC: UIViewController {
    var leaveReportObj: LeaveReportModel?
    
    @IBOutlet weak var halfDayViewOtl: UIView!
    @IBOutlet weak var fullDayViewOtl: UIView!
    @IBOutlet weak var onDutyViewOtl: UIView!
    @IBOutlet weak var halfDayLblOtl: UILabel!
    @IBOutlet weak var fullDayLblOtl: UILabel!
    @IBOutlet weak var overAllLeaveOtl: UILabel!
    @IBOutlet weak var onDutyLblOtl: UILabel!
    @IBOutlet weak var presentLblOtl: UILabel!
    @IBOutlet weak var overAllPresentLblOtl: UILabel!
    @IBOutlet weak var nonTeachingLblOtl: UILabel!
    @IBOutlet weak var teachingLblOtl: UILabel!
    @IBOutlet weak var totalLblOtl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Leave Report")
        leaveReportAPI()
        let halfDayTap = UITapGestureRecognizer()
        halfDayViewOtl.addGestureRecognizer(halfDayTap)
        halfDayTap.addTarget(self, action: #selector(halfDayList))
        
        let fullDayTap = UITapGestureRecognizer()
        fullDayViewOtl.addGestureRecognizer(fullDayTap)
        fullDayTap.addTarget(self, action: #selector(fullDayList))
        
        let onDutyTap = UITapGestureRecognizer()
        onDutyViewOtl.addGestureRecognizer(onDutyTap)
        onDutyTap.addTarget(self, action: #selector(onDutyList))
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.leaveDetailsSegue.getDescription {
            if let destinationVC = segue.destination as? LeaveDetailsVC {
                destinationVC.branchIds = UserDefaults.getUserDetail()?.BranchId ?? ""
                switch sender as! Int {
                case 1:
                    destinationVC.leaveTypeName = "OnDuty"
                case 2:
                    destinationVC.leaveTypeName = "FullDay"
                case 3:
                    destinationVC.leaveTypeName = "ShortLeave"
                default:
                    print("Unknown")
                }
            }
        }
    }
    @objc func halfDayList() {
        performSegue(withIdentifier: AppStrings.AppSegue.leaveDetailsSegue.getDescription, sender: 3)
    }
    @objc func fullDayList() {
        performSegue(withIdentifier: AppStrings.AppSegue.leaveDetailsSegue.getDescription, sender: 2)
    }
    @objc func onDutyList() {
        performSegue(withIdentifier: AppStrings.AppSegue.leaveDetailsSegue.getDescription, sender: 1)
    }
    func leaveData() {
        totalLblOtl.text = "\(leaveReportObj?.totalEmployees ?? 0)"
        teachingLblOtl.text = "\(leaveReportObj?.teachingEmployees ?? 0)"
        nonTeachingLblOtl.text = "\(leaveReportObj?.nonTeachingEmployees ?? 0)"
        
        overAllPresentLblOtl.text = "\(leaveReportObj?.toatalPresents ?? 0)"
        presentLblOtl.text = "\(leaveReportObj?.toatalPresents ?? 0)"
        onDutyLblOtl.text = "\(leaveReportObj?.onDuty ?? 0)"
        
        overAllLeaveOtl.text = "\(leaveReportObj?.absentCount ?? 0)"
        fullDayLblOtl.text = "\(leaveReportObj?.fullDayCount ?? 0)"
        halfDayLblOtl.text = "\(leaveReportObj?.halfDayCount ?? 0)"
    }
}
extension LeaveReportVC {
    func leaveReportAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Today_Leave_Report_Admin.getEndPoints).php?branchid=\(UserDefaults.getUserDetail()?.BranchId ?? "")&sessionid=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Today_Leave_Report_Admin.getEndPoints, apiRequestURL: strUrl)
    }
    
}
extension LeaveReportVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Today_Leave_Report_Admin.getEndPoints {
            let status = response["status"] as! Bool
            let message = response["message"] as! String
            if status == true {
                if let leaveReportDictData = Mapper<LeaveReportModel>().map(JSONObject: response) {
                    leaveReportObj = leaveReportDictData
                    DispatchQueue.main.async {
                        self.leaveData()
                    }
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
