//
//  FrownyFeedbackListVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 20/09/23.
//

import UIKit
import ObjectMapper
class FrownyFeedbackListVC: UIViewController {

    var feedbackListObj : FeedbackListModel?
    
    @IBOutlet weak var frownyListTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        frownyFeedbackApi(feedbackType: "Frowny")
        // Do any additional setup after loading the view.
    }
    

}
extension FrownyFeedbackListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbackListObj?.response?.res?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let frownyListCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.frownyListCell.getIdentifier, for: indexPath) as! FrownyFeedbackListTblCell
        frownyListCell.feedbackDetailView.clipsToBounds = true
        let  feedbackList = feedbackListObj?.response?.res?[indexPath.row]
        frownyListCell.studentNameLbl.text = feedbackList?.studentName ?? "-"
        frownyListCell.classLbl.text = feedbackList?.studentClass ?? "-"
        frownyListCell.remarksLbl.text = feedbackList?.parameter ?? "-"
        frownyListCell.rollNoLbl.text = feedbackList?.mobileNo ?? "-"
        frownyListCell.admissionLbl.text = feedbackList?.enrollNo ?? "-"
        frownyListCell.sectionLbl.text = feedbackList?.studentSection ?? "-"
        frownyListCell.dateTimeLbl.text = feedbackList?.created_Date ?? "-"
        return frownyListCell
    }
    
    
}
extension FrownyFeedbackListVC {
    func frownyFeedbackApi(feedbackType : String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Feedback_List.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&Type=\(feedbackType)&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Feedback_List.getEndPoints, apiRequestURL: strUrl)
    }
}
extension FrownyFeedbackListVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Feedback_List.getEndPoints {
            let status = response["status"] as! Int
           // let message = response["msg"] as! String
            if status == 1 {
                if let viewcircularDictData = Mapper<FeedbackListModel>().map(JSONObject: response) {
                    feedbackListObj = viewcircularDictData
                    //print(studentCircularObj)
                    DispatchQueue.main.async {
                        self.frownyListTblView.reloadData()
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

