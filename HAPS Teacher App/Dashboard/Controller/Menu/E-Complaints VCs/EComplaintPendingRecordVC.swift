//
//  EComplaintPendingRecordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 14/09/23.
//

import UIKit
import ObjectMapper

class EComplaintPendingRecordVC: UIViewController {
    
    var pandingResolvedObj : PendingResolvedModel?
    @IBOutlet weak var pandingRecordTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        eComplaintRecordApi(complaintStatus: "Pending")
        // Do any additional setup after loading the view.
    }

}
extension EComplaintPendingRecordVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pandingResolvedObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pandingCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.pendingRecordCell.getIdentifier, for: indexPath) as! EComplaintPandingRecordTblCell
        pandingCell.complaintDetailView.clipsToBounds = true
        let  pandingList = pandingResolvedObj?.response?.rest?[indexPath.row]
        pandingCell.complaintDateLbl.text = pandingList?.date ?? "-"
        pandingCell.complaintToLbl.text = pandingList?.empCode  ?? "-"
        pandingCell.complaintDescriptionLbl.text = pandingList?.description ?? "-"
        pandingCell.complaintLocationLbl.text = "-"
        return pandingCell
    }
    
    
}
extension EComplaintPendingRecordVC {
    func eComplaintRecordApi(complaintStatus : String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Panding_Resolved_List.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&status=\(complaintStatus)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Panding_Resolved_List.getEndPoints, apiRequestURL: strUrl)
    }
}
extension EComplaintPendingRecordVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
            if api == END_POINTS.Api_Panding_Resolved_List.getEndPoints {
                let status = response["status"] as! Int
               // let message = response["msg"] as! String
                if status == 1 {
                    if let viewcircularDictData = Mapper<PendingResolvedModel>().map(JSONObject: response) {
                        pandingResolvedObj = viewcircularDictData
                        //print(studentCircularObj)
                        DispatchQueue.main.async {
                            self.pandingRecordTblView.reloadData()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                       // CommonObjects.shared.showToast(messege: message, controller: self)
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
