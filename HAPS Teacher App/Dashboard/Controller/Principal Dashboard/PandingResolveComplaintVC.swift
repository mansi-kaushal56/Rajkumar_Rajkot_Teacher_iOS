//
//  PandingResolveComplaintVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/10/23.
//

import UIKit
import ObjectMapper

class PandingResolveComplaintVC: UIViewController {
    var eComplaintType = ""
    var eComplaintPrincipalObj: EComplaintPrincipalListModel?
    
    @IBOutlet weak var complaintListTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Resolved Complaints")
        ecomplaintPrincipalListApi()
        // Do any additional setup after loading the view.
    }

}
extension PandingResolveComplaintVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eComplaintPrincipalObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let complaintCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.complaintListCell.getIdentifier, for: indexPath) as! PandingResolveComplaintTblCell
        complaintCell.complaintDetailView.clipsToBounds = true
        complaintCell.resolvedDescriptionView.isHidden = true
        let complaintDetail = eComplaintPrincipalObj?.response?.rest?[indexPath.row]
        complaintCell.complaintDateLbl.text = complaintDetail?.date
        complaintCell.complaintLocationLbl.text = complaintDetail?.locationName
        complaintCell.complaintByLbl.text = complaintDetail?.ecomplaint_by
        complaintCell.complaintToLbl.text = complaintDetail?.ecomplaint_to
        complaintCell.complaintDescriptionLbl.text = complaintDetail?.description
        complaintCell.resolveDescriptionLbl.text = complaintDetail?.resolveReason
        complaintCell.statusLbl.text = complaintDetail?.status
        if complaintDetail?.status == "Resolve" {
            complaintCell.statusView.backgroundColor = .AppLightGreen
        } else {
            complaintCell.statusView.backgroundColor = .AppYellow
        }
        return complaintCell
    }
}
extension PandingResolveComplaintVC {
    func ecomplaintPrincipalListApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_EComplaint_Principal_List.getEndPoints).php?status=\(eComplaintType)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_EComplaint_Principal_List.getEndPoints, apiRequestURL: strUrl)
    }
}
extension PandingResolveComplaintVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_EComplaint_Principal_List.getEndPoints {
            let status = response["status"] as! Bool
            if status == true {
                if let eComplaintPrincipalDictData = Mapper<EComplaintPrincipalListModel>().map(JSONObject: response) {
                    eComplaintPrincipalObj = eComplaintPrincipalDictData
                    DispatchQueue.main.async {
                        self.complaintListTblView.reloadData()
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
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}

