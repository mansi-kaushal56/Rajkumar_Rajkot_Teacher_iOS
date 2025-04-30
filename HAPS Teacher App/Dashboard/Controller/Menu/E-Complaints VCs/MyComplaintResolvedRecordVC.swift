//
//  MyComplaintResolvedRecordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 14/09/23.
//

import UIKit
import ObjectMapper

class MyComplaintResolvedRecordVC: UIViewController {
    var pendingResolvedListObj : PendingResolvedModel?
    @IBOutlet weak var resolvedComplaintTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        eComplaintRecordApi(complaintStatus: "Resolve")
        // Do any additional setup after loading the view.
    }
    
}
extension MyComplaintResolvedRecordVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingResolvedListObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resolvedComplaintCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.myResolvedRecordCell.getIdentifier, for: indexPath) as! MyResolvedComplaintTblCell
        resolvedComplaintCell.complaintDetailView.clipsToBounds = true
        let resolvedComplaintList = pendingResolvedListObj?.response?.rest?[indexPath.row]
        resolvedComplaintCell.complaintDateLbl.text = resolvedComplaintList?.date ?? "-"
        resolvedComplaintCell.complaintDescriptionLbl.text = resolvedComplaintList?.description ?? "-"
        resolvedComplaintCell.complaintToLbl.text = resolvedComplaintList?.empCode ?? "-"
        resolvedComplaintCell.complaintLocationLbl.text = resolvedComplaintList?.locationName ?? "-"
        resolvedComplaintCell.remarkDescriptionLbl.text = resolvedComplaintList?.resolveReason ?? "-"
        return resolvedComplaintCell
    }
}
extension MyComplaintResolvedRecordVC {
    func eComplaintRecordApi(complaintStatus : String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_My_Pending_Resolved_Complaint.getEndPoints).php?staff=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&status=\(complaintStatus)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_My_Pending_Resolved_Complaint.getEndPoints, apiRequestURL: strUrl)
    }
}
extension MyComplaintResolvedRecordVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_My_Pending_Resolved_Complaint.getEndPoints {
            let status = response["status"] as! Int
           // let message = response["msg"] as! String
            if status == 1 {
                if let complaintResolvedDictData = Mapper<PendingResolvedModel>().map(JSONObject: response) {
                    pendingResolvedListObj = complaintResolvedDictData
                    //print(studentCircularObj)
                    DispatchQueue.main.async {
                        self.resolvedComplaintTblView.reloadData()
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
