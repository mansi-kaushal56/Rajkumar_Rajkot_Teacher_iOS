//
//  EmployeeDALRecordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 06/10/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class EmployeeDALRecordVC: UIViewController {
    var dailyActLogEmpObj: DailyActLogEmpModel?
    
    @IBOutlet weak var recordTblView: UITableView!
    @IBOutlet weak var searchTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Employee DAL Record")
        dailyActLogEmpApi()
        recordTblView.emptyDataSetSource = self
        recordTblView.emptyDataSetDelegate = self
        // Do any additional setup after loading the view.
    }
    @objc func showPdf(sender:UITapGestureRecognizer) {
        openWebView(urlString: dailyActLogEmpObj?.response?.rest?[sender.view?.tag ?? 0].extraFile?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "", viewController: self)
    }
    
}
extension EmployeeDALRecordVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage(str: AppMessages.MSG_NO_LIST_FOUND)
    }
}
extension EmployeeDALRecordVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyActLogEmpObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.employeeDALCell.getIdentifier, for: indexPath) as! EmployeeDALRecordTblCell
        recordCell.recordDetailView.clipsToBounds = true
        let dailyActLogData = dailyActLogEmpObj?.response?.rest?[indexPath.row]
        recordCell.descriptionLbl.text = dailyActLogData?.description
        recordCell.empCodeLbl.text = dailyActLogData?.empCode
        recordCell.nameLbl.text = dailyActLogData?.empName
        recordCell.dateLbl.text = dailyActLogData?.date
        recordCell.attachmentLbl.text = dailyActLogData?.extraFile
        recordCell.attachmentLbl.tag = indexPath.row
        recordCell.attachmentLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPdf(sender:))))
        
        switch dailyActLogData?.fileType {
        case "pdf":
            recordCell.viewAttachmentView.isHidden = false
            //        case "jpg":
            //            recordCell.viewAttachmentView.isHidden = true
        default:
            recordCell.viewAttachmentView.isHidden = true
        }
        return recordCell
    }
}
extension EmployeeDALRecordVC {
    func dailyActLogEmpApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Daily_Activity_Log_Employes.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Daily_Activity_Log_Employes.getEndPoints, apiRequestURL: strUrl)
    }
    func dailyActLogEmpFilterApi(searchData: String) {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Daily_Activity_Log_Filter.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&search=\(searchData)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Daily_Activity_Log_Filter.getEndPoints, apiRequestURL: strUrl)
        
    }
}
extension EmployeeDALRecordVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        let status = response["status"] as? String
        if api == END_POINTS.Api_Daily_Activity_Log_Employes.getEndPoints || api == END_POINTS.Api_Daily_Activity_Log_Filter.getEndPoints {
            if status == "true" {
                if let dailyActLogDictData = Mapper<DailyActLogEmpModel>().map(JSONObject: response) {
                    dailyActLogEmpObj = dailyActLogDictData
                    DispatchQueue.main.async {
                        self.recordTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.recordTblView.reloadData()
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
extension EmployeeDALRecordVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = searchTxtFld.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        dailyActLogEmpObj = nil
        dailyActLogEmpFilterApi(searchData: newText)
        return true
    }
}

