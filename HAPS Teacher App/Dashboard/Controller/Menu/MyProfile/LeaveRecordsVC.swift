//
//  LeaveRecordsVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 07/08/23.
//

import UIKit
import ObjectMapper

class LeaveRecordsVC: UIViewController {
    var leaveRecordsObj: LeaveRecordsModel?
    @IBOutlet weak var leaveRecordTblView: UITableView!
    @IBOutlet weak var approvedLavesLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "My Leave Records")
        leaveRecordsListApi()
        // Do any additional setup after loading the view.
    }
}

extension LeaveRecordsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaveRecordsObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaveRecordCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.recordCell.getIdentifier, for: indexPath) as! LeaveRecordsTblCell
        let leaveData = leaveRecordsObj?.response?.rest?[indexPath.row]
        leaveRecordCell.dateFromLbl.text = leaveData?.dateFrom
        leaveRecordCell.dateToLbl.text = leaveData?.dateTo
        leaveRecordCell.reasonLbl.text = leaveData?.reason
        leaveRecordCell.leaveTypeLbl.text = leaveData?.leaveType
        leaveRecordCell.statusLbl.text = leaveData?.status
        return leaveRecordCell
    }
}

extension LeaveRecordsVC {
    func leaveRecordsListApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Leavelist.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Leavelist.getEndPoints, apiRequestURL: strUrl)
    }
}

extension LeaveRecordsVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Leavelist.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                if let leaveRecordsDictData = Mapper<LeaveRecordsModel>().map(JSONObject: response) {
                    leaveRecordsObj = leaveRecordsDictData
                    DispatchQueue.main.async {
                        self.approvedLavesLbl.text = "\(self.leaveRecordsObj?.leaveCount ?? 0)"
                        self.leaveRecordTblView.reloadData()
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
