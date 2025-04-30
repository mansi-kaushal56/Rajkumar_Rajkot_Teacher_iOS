//
//  SmileyFeedbackListVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 20/09/23.
//

import UIKit
import ObjectMapper

class SmileyFeedbackListVC: UIViewController {
 
    var feedbackListObj : FeedbackListModel?
    
    @IBOutlet weak var smileyListTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        smileyFeedbackApi(feedbackType: "Smiley")
        // Do any additional setup after loading the view.
    }

}
extension SmileyFeedbackListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbackListObj?.response?.res?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let smileyListCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.smileyListCell.getIdentifier, for: indexPath) as! SmileyFeedbackListTblCell
        smileyListCell.smileyListView.clipsToBounds = true
        let  feedbackList = feedbackListObj?.response?.res?[indexPath.row]
        smileyListCell.studentNameLbl.text = feedbackList?.studentName ?? "-"
        smileyListCell.classLbl.text = feedbackList?.studentClass ?? "-"
        smileyListCell.remarksLbl.text = feedbackList?.parameter ?? "-"
        smileyListCell.rollNoLbl.text = feedbackList?.mobileNo ?? "-"
        smileyListCell.admissionNoLbl.text = feedbackList?.enrollNo ?? "-"
        smileyListCell.sectionLbl.text = feedbackList?.studentSection ?? "-"
        smileyListCell.timeDateLbl.text = feedbackList?.created_Date ?? "-"
        return smileyListCell
    }
}
extension SmileyFeedbackListVC {
    func smileyFeedbackApi(feedbackType : String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Feedback_List.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&Type=\(feedbackType)&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Feedback_List.getEndPoints, apiRequestURL: strUrl)
    }
}
extension SmileyFeedbackListVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Feedback_List.getEndPoints {
            let status = response["status"] as! Int
           // let message = response["msg"] as! String
            if status == 1 {
                if let viewcircularDictData = Mapper<FeedbackListModel>().map(JSONObject: response) {
                    feedbackListObj = viewcircularDictData
                    //print(studentCircularObj)
                    DispatchQueue.main.async {
                        self.smileyListTblView.reloadData()
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
