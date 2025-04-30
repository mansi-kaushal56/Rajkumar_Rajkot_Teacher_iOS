//
//  EmployeePTMRecordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 06/10/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class EmployeePTMRecordVC: UIViewController {
    var showptmbranchObj: ShowPTMBranchModel?
    
    @IBOutlet weak var searchTxtFld: UITextField!
    @IBOutlet weak var eptmRecordTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "E-PTM Records")
        showPTMBranchApi()
        eptmRecordTblView.emptyDataSetSource = self
        eptmRecordTblView.emptyDataSetDelegate = self
        // Do any additional setup after loading the view.
    }
    
}
extension EmployeePTMRecordVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage(str: AppMessages.MSG_NO_LIST_FOUND)
    }
}
extension EmployeePTMRecordVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showptmbranchObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.ePTMRecordCell.getIdentifier, for: indexPath) as! EPTMRecordTblCell
        recordCell.employeeDetailView.clipsToBounds = true
        let showPTMBranchData = showptmbranchObj?.response?.rest?[indexPath.row]
        recordCell.descriptionLbl.text = showPTMBranchData?.description
        recordCell.talkWithLbl.text = showPTMBranchData?.talkWith
        recordCell.mobileNoLbl.text = showPTMBranchData?.mobile
        recordCell.rollNoLbl.text = showPTMBranchData?.rollNo
        recordCell.admissionLbl.text = showPTMBranchData?.enrollNo
        recordCell.dateLbl.text = "Date: \(showPTMBranchData?.date ?? "")"
        recordCell.employeeNameLbl.text = "Called By: \(showPTMBranchData?.name ?? "") (\(showPTMBranchData?.empCode ?? ""))"
        recordCell.studentLbl.text = "\(showPTMBranchData?.studentName ?? "") (\(showPTMBranchData?.className ?? ""))"
//        recordCell.
        return recordCell
    }
}
extension EmployeePTMRecordVC {
    func showPTMBranchApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Show_Ptm_Branch.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Show_Ptm_Branch.getEndPoints, apiRequestURL: strUrl)
        
    }
    func searchPTMBranchApi(searchData: String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Search_Ptm.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SearchData=\(searchData)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Search_Ptm.getEndPoints, apiRequestURL: strUrl)
        
    }
}
extension EmployeePTMRecordVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Show_Ptm_Branch.getEndPoints || api == END_POINTS.Api_Search_Ptm.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                if let showPTMBranchDictData = Mapper<ShowPTMBranchModel>().map(JSONObject: response) {
                    showptmbranchObj = showPTMBranchDictData
                    DispatchQueue.main.async {
                        self.eptmRecordTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    self.eptmRecordTblView.reloadData()
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
extension EmployeePTMRecordVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = searchTxtFld.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        showptmbranchObj = nil
        searchPTMBranchApi(searchData: newText)
        return true
    }
}

