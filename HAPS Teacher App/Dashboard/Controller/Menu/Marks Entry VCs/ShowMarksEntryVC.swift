//
//  ShowMarksEntryVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 20/09/23.
//

import UIKit
import ObjectMapper
//import SwiftUI

class ShowMarksEntryVC: UIViewController {
    var selectedClassAndSecObj : MarksClassSecListRes?
    var headid = ""
    var examtypeid = ""
    var test = ""
    var type = ""
    var subid = ""
    var sectionid = ""
    var Max = ""
    var examid = ""
    var headName = ""
    var subName = ""
    var examTypeName = ""
    var testName = ""
    var classOrSecName = ""
    var stDetailListObj: StudentDetailListModel?
    var selectedStDetailListArr = [StudentDetailListRest]()
    var attendType: String?
    var studentIds = [String]()
    
    
    @IBOutlet weak var testDetailLbl: UILabel!
    @IBOutlet weak var classSectionLbl: UILabel!
    @IBOutlet weak var totalStudentLbl: UILabel!
    @IBOutlet weak var ibSaveMarksBtn: UIButton!
    @IBOutlet weak var ibLockMarksBtn: UIButton!
    @IBOutlet weak var showMarksEntryTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Marks Entry")
        showMarksApi()
        testDetailLbl.text = "\(headName) - \(examTypeName) - \(type) - \(subName)\n Max Marks \(Max)"
        classSectionLbl.text =  "\(selectedClassAndSecObj?.className ?? "")"
        // Do any additional setup after loading the view.
    }
    
    @objc func attendanceVC(sender: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.marksEntryAttendancevc.getIdentifier) as! MarksEntryAttendanceVC
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        //vc.indexPath = sender.view?.tag
        vc.studentAttend = stDetailListObj?.response?.rest?[sender.view?.tag ?? 0] as? StudentDetailListRest
        vc.index = sender.view?.tag
        self.present(vc, animated: true)
    }
    @IBAction func saveMarksBtnAction(_ sender: UIButton) {
        saveMarksApi(locked: "No")
    }
    @IBAction func lockMarksBtnAction(_ sender: UIButton) {
        saveMarksApi(locked: "Yes")
    }
}
extension ShowMarksEntryVC: AttendenceDelegate {
    func attendence(index: Int?, data: StudentDetailListRest?) {
        stDetailListObj?.response?.rest?[index!] = data!
        
        showMarksEntryTblView.reloadData()
    }
}
extension ShowMarksEntryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stDetailListObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showMarksCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.marksEntryCell.getIdentifier, for: indexPath) as! ShowMarksEntryTblCell
        let stListData = stDetailListObj?.response?.rest?[indexPath.row]
        showMarksCell.studentNameLbl.text = stListData?.studentName
        showMarksCell.rollNoLbl.text = "Roll No- \(stListData?.rollNo ?? "")"
        showMarksCell.admNoLbl.text = "Admn No- \(stListData?.enrollNo ?? "")"
        showMarksCell.marksTxtFld.text = stListData?.savedmarks
        showMarksCell.attendanceLbl.text = stListData?.attendence
        showMarksCell.attendanceLbl.tag = indexPath.row
        showMarksCell.delegate = self
        
        switch stListData?.attendence {
        case "P":
            showMarksCell.attendanceView.backgroundColor = .AppDarkGreen
            showMarksCell.attendanceLbl.textColor = .AppLightGreen
            showMarksCell.marksTxtFld.isUserInteractionEnabled = false
        case "A":
            showMarksCell.attendanceView.backgroundColor = UIColor(named: "F84C4C")
            showMarksCell.attendanceLbl.textColor = .AppRed
            showMarksCell.marksTxtFld.isUserInteractionEnabled = false
        case "M":
            showMarksCell.attendanceView.backgroundColor = UIColor(named: "0098EE 2")
            showMarksCell.attendanceLbl.textColor = UIColor(named: "0098EE")
            showMarksCell.marksTxtFld.isUserInteractionEnabled = false
        case "E":
            showMarksCell.attendanceView.backgroundColor = UIColor(named: "FC2CB5")
            showMarksCell.attendanceLbl.textColor = UIColor(named: "ComentBtn")
            showMarksCell.marksTxtFld.isUserInteractionEnabled = false
        default:
            print("Invaild attendence")
        }
        if stListData?.locked == "Yes" {
            ibSaveMarksBtn.isHidden = true
            showMarksCell.marksTxtFld.isUserInteractionEnabled = false
        } else {
            ibSaveMarksBtn.isHidden = false
            showMarksCell.marksTxtFld.isUserInteractionEnabled = true
            let attendTap = UITapGestureRecognizer()
            showMarksCell.attendanceLbl.addGestureRecognizer(attendTap)
            attendTap.addTarget(self, action: #selector(attendanceVC(sender: )))
        }
        
        return showMarksCell
    }
}
extension ShowMarksEntryVC: ShowMarksEntryTblCellDelegate  {
    func marksTextFieldDidEdit(cell: ShowMarksEntryTblCell, editedText: String) {
        if let indexPath = showMarksEntryTblView.indexPath(for: cell) {
            // Update the data model with the edited text
            if var data = stDetailListObj?.response?.rest?[indexPath.row] {
                data.savedmarks = editedText
                if data.savedmarks ?? "" >= data.max ?? "" {
                    invalidMarksAlert()
                    cell.marksTxtFld.text = "0"
                    data.savedmarks = "0"
                }
                stDetailListObj?.response?.rest?[indexPath.row] = data
            }
        }
    }
}
extension ShowMarksEntryVC {
    func showMarksApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.APi_Add_Marks.getEndPoints).php?classid=\(selectedClassAndSecObj?.classid ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&headid=\(headid)&examtypeid=\(examtypeid)&test=\(test)&type=\(type)&subid=\(subid )&sectionid=\(selectedClassAndSecObj?.sectionId ?? "")&Max=\(Max)&examid=\(examid)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.APi_Add_Marks.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
    func saveMarksApi(locked: String) {
        let studentDetails = stDetailListObj?.response?.rest ?? []
        
        let attendenceArray = studentDetails.compactMap {$0.attendence}
        let savedmarksArr = studentDetails.compactMap {$0.savedmarks ?? "0"}
        let studentIdArr = studentDetails.compactMap {$0.studentId}
        let studentdetailidArr = studentDetails.compactMap {$0.studentDetailId}
        
        let attendenceString = attendenceArray.joined(separator: ",")
        let savedmarksString = savedmarksArr.joined(separator: ",")
        let studentIdString = studentIdArr.joined(separator: ",")
        let studentdetailidString = studentdetailidArr.joined(separator: ",")
        
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Save_Marks.getEndPoints).php?classid=\(selectedClassAndSecObj?.classid ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&subid=\(subid)&headid=\(headid)&type=\(type)&examtypeid=\(examtypeid)&test=\(test)&LoginId=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&Max=\(Max)&marks=\(savedmarksString)&studentid=\(studentIdString)&studentdetailid=\(studentdetailidString)&Attendence=\(attendenceString)&sectionid=\(selectedClassAndSecObj?.sectionId ?? "")&locked=\(locked)&examid=\(examid)&sno=\(stDetailListObj?.sno ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Save_Marks.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
extension ShowMarksEntryVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.APi_Add_Marks.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                if let stDetailListDictData = Mapper<StudentDetailListModel>().map(JSONObject: response) {
                    stDetailListObj = stDetailListDictData
                    DispatchQueue.main.async {
                        self.totalStudentLbl.text = "\(self.stDetailListObj?.count ?? 0)"
                        self.showMarksEntryTblView.reloadData()
                    }
                }
            }
        }
        if api == END_POINTS.Api_Save_Marks.getEndPoints {
            let status = response["status"] as? Int
            if status == 1 {
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                    CommonObjects.shared.showToast(message: AppMessages.MARKS_SUCCESS)
                }
                
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.stopProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR)
        }
    }
}
