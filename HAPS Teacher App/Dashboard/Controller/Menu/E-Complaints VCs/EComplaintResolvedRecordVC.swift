//
//  EComplaintResolvedRecordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 14/09/23.
//

import UIKit
import ObjectMapper

class EComplaintResolvedRecordVC: UIViewController {
    
    @IBOutlet weak var resolvedRecordTblView: UITableView!
    var pandingResolvedObj : PendingResolvedModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        eComplaintRecordApi(complaintStatus: "Resolve")
        // Do any additional setup after loading the view.
    }

}
extension EComplaintResolvedRecordVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pandingResolvedObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resolvedCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.resolvedRecordCell.getIdentifier, for: indexPath) as! EComplaintResolvedRecordTblCell
        resolvedCell.complaintDetailView.clipsToBounds = true
        let  resolvedList = pandingResolvedObj?.response?.rest?[indexPath.row]
        resolvedCell.complaintDateLbl.text = resolvedList?.date ?? "-"
        resolvedCell.complaintToLbl.text = resolvedList?.empCode  ?? "-"
        resolvedCell.complaintDescriptionLbl.text = resolvedList?.description ?? "-"
        resolvedCell.complaintRemarkLbl.text = resolvedList?.resolveReason ?? "-"
        resolvedCell.complaintLocationLbl.text = "-"
        return resolvedCell
    }
    
}
extension EComplaintResolvedRecordVC {
    func eComplaintRecordApi(complaintStatus : String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Panding_Resolved_List.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&status=\(complaintStatus)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Panding_Resolved_List.getEndPoints, apiRequestURL: strUrl)
    }
}
extension EComplaintResolvedRecordVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
            if api == END_POINTS.Api_Panding_Resolved_List.getEndPoints {
                let status = response["status"] as! Int
                // let message = response["msg"] as! String
                if status == 1 {
                    if let viewcircularDictData = Mapper<PendingResolvedModel>().map(JSONObject: response) {
                        pandingResolvedObj = viewcircularDictData
                        //print(studentCircularObj)
                        DispatchQueue.main.async {
                            self.resolvedRecordTblView.reloadData()
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
