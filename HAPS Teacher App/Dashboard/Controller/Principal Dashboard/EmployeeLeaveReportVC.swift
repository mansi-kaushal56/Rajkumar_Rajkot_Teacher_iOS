//
//  EmployeeLeaveReportVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 06/10/23.
//

import UIKit
import ObjectMapper

enum LeaveType: String {
    case OnDuty = "OnDuty"
    case FullDay =  "FullDay"
    case ShortLeave = "ShortLeave"
}

class EmployeeLeaveReportVC: UIViewController {
    var leaveReportObj: LeaveReportModel?
    var empBranchIds = ""
    
    @IBOutlet weak var halfDayView: UIView!
    @IBOutlet weak var fullDayView: UIView!
    @IBOutlet weak var onDutyView: UIView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var teachingLbl: UILabel!
    @IBOutlet weak var nonTeachingLbl: UILabel!
    @IBOutlet weak var overAllPresentLbl: UILabel!
    @IBOutlet weak var presentLbl: UILabel!
    @IBOutlet weak var onDutyLbl: UILabel!
    @IBOutlet weak var overAllLeave: UILabel!
    @IBOutlet weak var fullDayLbl: UILabel!
    @IBOutlet weak var halfDayLbl: UILabel!
    @IBOutlet weak var vikasNagarLbl: UILabel!
    @IBOutlet weak var vikasNagarView: UIView!
    @IBOutlet weak var hiranagarLbl: UILabel!
    @IBOutlet weak var hiranagarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Leave Report")
        tapGestureRecognizers()
        hiranagarPage(type: .Hiranagar)
        //leaveReportAPI()
        let halfDayTap = UITapGestureRecognizer()
        halfDayView.addGestureRecognizer(halfDayTap)
        halfDayTap.addTarget(self, action: #selector(halfDayList))
        
        let fullDayTap = UITapGestureRecognizer()
        fullDayView.addGestureRecognizer(fullDayTap)
        fullDayTap.addTarget(self, action: #selector(fullDayList))
        
        let onDutyTap = UITapGestureRecognizer()
        onDutyView.addGestureRecognizer(onDutyTap)
        onDutyTap.addTarget(self, action: #selector(onDutyList))
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.leaveDetailsSegue.getDescription {
            if let destinationVC = segue.destination as? LeaveDetailsVC {
                destinationVC.branchIds = empBranchIds
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
    func hiranagarPage(type:ScreenType) {
        switch type {
        case .Hiranagar:
            hiranagarView.backgroundColor = .AppSkyBlue
            vikasNagarView.backgroundColor = .clear
            hiranagarLbl.textColor = .white
            vikasNagarLbl.textColor = .black
            leaveReportAPI(branchId: "1")
            empBranchIds = "1"
        case .VikasNagar:
            hiranagarView.backgroundColor = .clear
            vikasNagarView.backgroundColor = .AppSkyBlue
            hiranagarLbl.textColor = .black
            vikasNagarLbl.textColor = .white
            leaveReportAPI(branchId: "2")
            empBranchIds = "2"
        default:
            print("Unknown type")
        }
    }
    func tapGestureRecognizers() {
        hiranagarView.addTapGestureRecognizer {
            self.hiranagarPage(type: .Hiranagar)
        }
        vikasNagarView.addTapGestureRecognizer {
            self.hiranagarPage(type: .VikasNagar)
        }
    }
    func leaveData() {
        totalLbl.text = "\(leaveReportObj?.totalEmployees ?? 0)"
        teachingLbl.text = "\(leaveReportObj?.teachingEmployees ?? 0)"
        nonTeachingLbl.text = "\(leaveReportObj?.nonTeachingEmployees ?? 0)"
        
        overAllPresentLbl.text = "\(leaveReportObj?.toatalPresents ?? 0)"
        presentLbl.text = "\(leaveReportObj?.toatalPresents ?? 0)"
        onDutyLbl.text = "\(leaveReportObj?.onDuty ?? 0)"
        
        overAllLeave.text = "\(leaveReportObj?.absentCount ?? 0)"
        fullDayLbl.text = "\(leaveReportObj?.fullDayCount ?? 0)"
        halfDayLbl.text = "\(leaveReportObj?.halfDayCount ?? 0)"
    }
    
}
extension EmployeeLeaveReportVC {
    func leaveReportAPI(branchId: String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Today_Leave_Report_Admin.getEndPoints).php?branchid=\(branchId)&sessionid=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Today_Leave_Report_Admin.getEndPoints, apiRequestURL: strUrl)
    }
    
}
extension EmployeeLeaveReportVC: RequestApiDelegate {
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
