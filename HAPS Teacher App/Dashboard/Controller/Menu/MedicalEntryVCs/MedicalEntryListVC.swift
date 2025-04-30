//
//  MedicalEntryListVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 12/09/23.
//

import UIKit
import ObjectMapper
class MedicalEntryListVC: UIViewController {
    var medicalEntryLeavesobj : MedicalEntryLeavesModel?
    var selectedIndex: Int = -1
    
    @IBOutlet weak var medicalDetailTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Medical Entry List")
        medicalEntryLeaveApi()
        
        // Do any additional setup after loading the view.
    }
    @objc func hideShowViewTapped(_ sender:UIButton) {
        print("Tapped")
    }
    
}
extension MedicalEntryListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicalEntryLeavesobj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.medicalListCell.getIdentifier, for: indexPath) as! MedicalEntryListTblCell
        let  medicalLeaveList = medicalEntryLeavesobj?.response?.rest?[indexPath.row]
        listCell.studentNameLbl.text = "\(medicalLeaveList?.studentName ?? "-") (\(medicalLeaveList?.className ?? "-") - \(medicalLeaveList?.section ?? "-"))"
        listCell.admNoLbl.text = "Admission No : \(medicalLeaveList?.enrollNo ?? "")"
        listCell.bloodPLbl.text = medicalLeaveList?.bp ?? "-"
        listCell.diagnosisLbl.text = medicalLeaveList?.diagnosis ?? "-"
        listCell.fromDateLbl.text = medicalLeaveList?.hospitaldatefrom ?? "-"
        listCell.todateLbl.text = medicalLeaveList?.hospitaldateto ?? "-"
        listCell.tempLbl.text = medicalLeaveList?.temperature ?? "-"
        listCell.medicalAllergiesLbl.text = medicalLeaveList?.allergies ?? "-"
        listCell.medicalHistoryLbl.text = medicalLeaveList?.medicalHistory ?? "-"
        listCell.dateLbl.text = medicalLeaveList?.date ?? "-"
        listCell.doseLbl.text = medicalLeaveList?.dose ?? "-"
        listCell.doseQualityLbl.text = medicalLeaveList?.doseqty ?? "-"
        listCell.daysLbl.text = medicalLeaveList?.days ?? "-"
        listCell.rateLbl.text = medicalLeaveList?.rate ?? "-"
        //listCell.medicineDetailTblView.reloadData()
        listCell.medicalDetailView.clipsToBounds = true
        //listCell.hideShowDetailBtnOtl.tag = indexPath.row
        //listCell.hideShowDetailBtnOtl.addTarget(self, action: #selector(hideShowDetail(sender: )), for: .touchUpInside)
        //listCell.hideShowDetailBtnOtl.addTarget(self, action: #selector(hideShowViewTapped(_:)), for: .touchUpInside)
        
        listCell.hideShowDetailBtnOtl.tag = indexPath.row
        listCell.studentMedicalDetailView.isHidden = false
        listCell.hideShowDetailBtnOtl.addTarget(self, action: #selector(hideShowViewTapped(_:)), for: .touchUpInside)
        
        return listCell
    }
}

extension MedicalEntryListVC {
    func medicalEntryLeaveApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Medical_Entry_Leave.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Medical_Entry_Leave.getEndPoints, apiRequestURL: strUrl)
    }
}
extension MedicalEntryListVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Medical_Entry_Leave.getEndPoints {
            let status = response["status"] as! String
            if status == "SUCCESS" {
                if let viewMedicalLeaveData = Mapper<MedicalEntryLeavesModel>().map(JSONObject: response) {
                    medicalEntryLeavesobj = viewMedicalLeaveData
                    DispatchQueue.main.async {
                        self.medicalDetailTblView.reloadData()
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

