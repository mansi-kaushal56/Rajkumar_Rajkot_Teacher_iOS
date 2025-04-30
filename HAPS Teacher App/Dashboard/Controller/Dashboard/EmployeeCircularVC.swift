//
//  EmployeeCircularVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/08/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class EmployeeCircularVC: UIViewController {
    var circularListObj: CircularListModel?
    @IBOutlet weak var circularListTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "View Circular List")
        circularListAPI()
        
        circularListTblView.emptyDataSetDelegate = self
        circularListTblView.emptyDataSetSource = self
        
        //readCircularApi(readCircular: "Read")
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.viewCircularSegue.getDescription {
            if let destinationVC = segue.destination as? ViewCircularVC {
                destinationVC.selCircularId = circularListObj?.response?.res?[sender as! Int].id
            }
        }
        
    }
}
extension EmployeeCircularVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage(str: AppMessages.MSG_NO_LIST_FOUND)
    }
}
extension EmployeeCircularVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: AppStrings.AppSegue.viewCircularSegue.getDescription, sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circularListObj?.response?.res?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let circularListCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.circularListCell.getIdentifier, for: indexPath) as! EmployeeCircularTblCell
        let circularListData = circularListObj?.response?.res?[indexPath.row]
        circularListCell.employeeCircularView.clipsToBounds = true
        circularListCell.circularByLblOtl.text = circularListData?.staff
        circularListCell.circularDateLblOtl.text = circularListData?.created_Date
        circularListCell.circularTitleLbl.text = circularListData?.title
        if circularListData?.attachment == "yes" {
            circularListCell.viewAttachmentView.isHidden = false
        } else {
            circularListCell.viewAttachmentView.isHidden = true
        }
        
        return circularListCell
    }
}
extension EmployeeCircularVC {
    func circularListAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Circular_List.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Circular_List.getEndPoints, apiRequestURL: strUrl)
    }
    func readCircularApi(readCircular:String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Update_Read_Status.getEndPoints).php?status=\(readCircular)&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Update_Read_Status.getEndPoints, apiRequestURL: strUrl)
    }
}
extension EmployeeCircularVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Circular_List.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let leaveReportDictData = Mapper<CircularListModel>().map(JSONObject: response) {
                    circularListObj = leaveReportDictData
                    DispatchQueue.main.async {
                        self.circularListTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Update_Read_Status.getEndPoints  {
            let status = response["status"] as! String
            
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
