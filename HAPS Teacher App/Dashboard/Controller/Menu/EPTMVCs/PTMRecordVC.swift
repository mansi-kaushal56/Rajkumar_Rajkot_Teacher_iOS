//
//  PTMRecordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 28/08/23.
//

import UIKit
import ObjectMapper

class PTMRecordVC: UIViewController {
    var ptmRecordObj: ShowPTMRecordModel?

    @IBOutlet weak var ptmRecordTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "E-PTM Record")
        ptmReportAPI()
        // Do any additional setup after loading the view.
    }
}
extension PTMRecordVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ptmRecordObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.ptmRecordCell.getIdentifier, for: indexPath) as! PTMRecordTableCell
        recordCell.ptmRecordView.clipsToBounds = true
        let ptmRecordModelData = ptmRecordObj?.response?.rest?[indexPath.row]
        recordCell.admissionNoLbl.text = ptmRecordModelData?.enrollNo
        recordCell.rollNoLbl.text = ptmRecordModelData?.rollNo
        recordCell.mobileNoLbl.text = ptmRecordModelData?.mobile
        recordCell.modeLbl.text = ptmRecordModelData?.mode
        recordCell.talkWithLbl.text = ptmRecordModelData?.talkWith
        recordCell.pSatisfactionLbl.text = ptmRecordModelData?.psat
        recordCell.studentNameLbl.text = "\(ptmRecordModelData?.studentName?.trimmingCharacters(in: .whitespaces) ?? "")(\(ptmRecordModelData?.className ?? ""))"
        recordCell.dateLbl.text = "Date (\(ptmRecordModelData?.date ?? ""))"
        recordCell.descriptionLbl.text = ptmRecordModelData?.description
        recordCell.areaOrLbl.text = ptmRecordModelData?.area
        if ptmRecordModelData?.psat == "Not Satisfied" {
            recordCell.areaOrLbl.isHidden = false
            recordCell.areaLblPlaceHolder.isHidden = false
        } else {
            recordCell.areaLblPlaceHolder.isHidden = true
            recordCell.areaOrLbl.isHidden = true
        }
        return recordCell
    }
}
extension PTMRecordVC {
    func ptmReportAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Show_EPTM_Record.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Show_EPTM_Record.getEndPoints, apiRequestURL: strUrl)
    }
    
}
extension PTMRecordVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Show_EPTM_Record.getEndPoints {
            let status = response["status"] as! String
            if status == "SUCCESS" {
                if let ptmReportDictData = Mapper<ShowPTMRecordModel>().map(JSONObject: response) {
                    ptmRecordObj = ptmReportDictData
                    DispatchQueue.main.async {
                        self.ptmRecordTblView.reloadData()
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
