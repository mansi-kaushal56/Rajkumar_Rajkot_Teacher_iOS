//
//  MyComplaintPendingRecordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 14/09/23.
//

import UIKit
import ObjectMapper
class MyComplaintPendingRecordVC: UIViewController {
    var pendingResolvedListObj : PendingResolvedModel?
    @IBOutlet weak var myPendingComplaintTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        eComplaintRecordApi(complaintStatus: "Pending")
        // Do any additional setup after loading the view.
    }
}
extension MyComplaintPendingRecordVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingResolvedListObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pendingComplaintCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.myPendingRecordCell.getIdentifier, for: indexPath) as! MyPendingComplaintTblCell
        pendingComplaintCell.complaintDetailView.clipsToBounds = true
        let pendingComplaintList = pendingResolvedListObj?.response?.rest?[indexPath.row]
        pendingComplaintCell.complaintDateLbl.text = pendingComplaintList?.date ?? "-"
        pendingComplaintCell.complaintDescriptionLbl.text = pendingComplaintList?.description ?? "-"
        pendingComplaintCell.complaintToLbl.text = pendingComplaintList?.empCode ?? "-"
        pendingComplaintCell.complaintLocationLbl.text = pendingComplaintList?.locationName ?? "-"
        return pendingComplaintCell
    }
}
extension MyComplaintPendingRecordVC {
    func eComplaintRecordApi(complaintStatus : String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_My_Pending_Resolved_Complaint.getEndPoints).php?staff=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&status=\(complaintStatus)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_My_Pending_Resolved_Complaint.getEndPoints, apiRequestURL: strUrl)
    }
}
extension MyComplaintPendingRecordVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_My_Pending_Resolved_Complaint.getEndPoints {
            let status = response["status"] as! Int
           // let message = response["msg"] as! String
            if status == 1 {
                if let pendingResolvedDictData = Mapper<PendingResolvedModel>().map(JSONObject: response) {
                    pendingResolvedListObj = pendingResolvedDictData
                    //print(studentCircularObj)
                    DispatchQueue.main.async {
                        self.myPendingComplaintTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA, controller: self)
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
