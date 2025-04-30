//
//  HomeWorkHistoryVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/08/23.
//

import UIKit
import ObjectMapper

class HomeWorkHistoryVC: UIViewController {
    var homeworkListObj: HomeworkListModel?
    @IBOutlet weak var homeWorkHistoryTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Homework History")
        homeWorkListApi()
    }

}
extension HomeWorkHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkListObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeWorkHistoryCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.HWHistoryCell.getIdentifier, for: indexPath) as! HomeWorkHistoryTblCell
        homeWorkHistoryCell.homeworkHistoryView.clipsToBounds = true
        let homeWorkListData = homeworkListObj?.response?.rest?[indexPath.row]
        homeWorkHistoryCell.descriptionLbl.text = homeWorkListData?.desp
        homeWorkHistoryCell.subjectLbl.text = homeWorkListData?.subjectName
        homeWorkHistoryCell.classSectionLbl.text = "\(homeWorkListData?.className ?? "") - \(homeWorkListData?.sectionName ?? "")"
        homeWorkHistoryCell.dueDateLbl.text = "Due Date: \(homeWorkListData?.due_date ?? "")"

        return homeWorkHistoryCell
    }
}
extension HomeWorkHistoryVC {
    func homeWorkListApi() {
        CommonObjects.shared.showProgress()
        
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Homework_List.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&sessionid=\(UserDefaults.getUserDetail()?.Session ?? "")&branchid=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Homework_List.getEndPoints, apiRequestURL: strUrl)
    }
}
extension HomeWorkHistoryVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Homework_List.getEndPoints {
            let status = response["status"] as! String
            if status == "Success" {
                if let homeworkListDictData = Mapper<HomeworkListModel>().map(JSONObject: response) {
                    homeworkListObj = homeworkListDictData
                    DispatchQueue.main.async {
                        self.homeWorkHistoryTblView.reloadData()// tableView Outlet
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
