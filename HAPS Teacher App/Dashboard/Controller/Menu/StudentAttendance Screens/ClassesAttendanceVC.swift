//
//  ClassesAttendanceVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 17/08/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class ClassesAttendanceVC: UIViewController {
    var type : ScreenType?
    var apiEndPoints : String?
    var selectedClass: FillClassRes?
    var selectedSection: ShowSectionRest?
    var viewAttendenceObj: ViewAttendenceModel?
    var viewCoachingAtdObj: ViewAttendenceModel?
    var classListObj: FillClassModel?
    var sectionListObj: ShowSectionModel?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var totalStudentLbl: UILabel!
    @IBOutlet weak var sectionLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var leaveLbl: UILabel!
    @IBOutlet weak var presentLbl: UILabel!
    @IBOutlet weak var absentLbl: UILabel!
    @IBOutlet weak var sectionListView: UIView!
    @IBOutlet weak var classListView: UIView!
    @IBOutlet weak var chooseDateTxtFld: UITextField!
    @IBOutlet weak var totalStudent: UIView!
    @IBOutlet weak var mainClassTblView: UITableView!
    
    var selClIndex: Int? = 0
    var selSecIndex: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        mainClassTblView.emptyDataSetSource = self
        mainClassTblView.emptyDataSetDelegate = self
        chooseDateTxtFld.text = convertDateFormatter()
        totalStudent.isHidden = true
        headerView.isHidden = true
        totalStudent.clipsToBounds = true
        backBtnTitleName()
        classesListApi()
        tapGestures()
        
        self.chooseDateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker2))
        
    }
    @IBAction func viewAttendanceBtn(_ sender: UIButton) {
        if type == ScreenType.MainClassAttendance {
            mainClassAttendanceApi(endPoint: END_POINTS.Api_View_Attendence.getEndPoints)
        } else {
            mainClassAttendanceApi(endPoint: END_POINTS.Api_View_Coaching_Attendance.getEndPoints)
        }
    }
    func backBtnTitleName() {
        if type == .MainClassAttendance {
            backBtn(title: "Main Class Attendance")
        } else {
            backBtn(title: "Coaching Class Attendance")
        }
    }
    func tapGestures() {
        sectionListView.addTapGestureRecognizer {
            self.classSectionList(type: .SectionList)
        }
        classListView.addTapGestureRecognizer {
            self.classSectionList(type: .ClassList)
        }
    }
    func classSectionList(type: ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.listAppearVC.getIdentifier) as! ListAppearVC
        vc.modalPresentationStyle = .overFullScreen
        switch type {
        case .SectionList:
            vc.type = .SectionList
            vc.classId = selectedClass?.classId
            vc.selClassIndex = selClIndex
            vc.selSecIndex = selSecIndex
            vc.secListObj = sectionListObj
        case .ClassList:
            vc.type = .ClassList
            vc.selClassIndex = selClIndex
            vc.selSecIndex = selSecIndex
            vc.clListObj = classListObj
        default :
            return
        }
        vc.delegate = self
        self.present(vc, animated: true)
    }
//    @objc func sectionList() {
//        let storyboard = UIStoryboard.init(name: AppStoryboards.dashboard.getDescription, bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIndetifiers.listAppearVC.getIndentifier) as! ListAppearVC
//        vc.modalPresentationStyle = .overFullScreen
//        vc.type = .SectionList
//        vc.classId = selectedClass?.classid
//        vc.selClassIndex = selClIndex
//        vc.selSecIndex = selSecIndex
//        vc.secListObj = sectionListObj
//        vc.delegate = self
//        self.present(vc, animated: true)
//    }
//    @objc func classList() {
//        let storyboard = UIStoryboard.init(name: AppStoryboards.dashboard.getDescription, bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIndetifiers.listAppearVC.getIndentifier) as! ListAppearVC
//        vc.modalPresentationStyle = .overFullScreen
//        vc.type = .ClassList
//        vc.selClassIndex = selClIndex
//        vc.selSecIndex = selSecIndex
//        vc.delegate = self
//        vc.clListObj = classListObj
//        self.present(vc, animated: true)
//    }
    @objc func datePicker2(_ sender:UITapGestureRecognizer){
        if let datePicker = self.chooseDateTxtFld.inputView as? UIDatePicker {
            
            //MARK: - Date Format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            self.chooseDateTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.chooseDateTxtFld.resignFirstResponder()
    }

    func showLblData() {
        totalStudent.isHidden = false
        headerView.isHidden = false
        leaveLbl.text = "\(viewAttendenceObj?.leave ?? 0)"
        presentLbl.text = "\(viewAttendenceObj?.present ?? 0)"
        totalStudentLbl.text = "Total Students\(viewAttendenceObj?.total ?? 0)"
        absentLbl.text = "\(viewAttendenceObj?.absent ?? 0)"
    }
    
}
extension ClassesAttendanceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Date:: 12, Apr 2024 - check add to show the viewCoachingAtdObj data
        if type == .MainClassAttendance {
            return viewAttendenceObj?.response?.rest?.count ?? 0
        } else {
            return viewCoachingAtdObj?.response?.rest?.count ?? 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let classCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.mainClassCell.getIdentifier, for: indexPath) as! MainClassAttendanceTblCell
        if type == .MainClassAttendance {
            classCell.admNoLbl.text = viewAttendenceObj?.response?.rest?[indexPath.row].enrollNo
            classCell.rollNoLbl.text = viewAttendenceObj?.response?.rest?[indexPath.row].rollNo
            classCell.nameLbl.text = viewAttendenceObj?.response?.rest?[indexPath.row].studentName
            classCell.statusLbl.text = viewAttendenceObj?.response?.rest?[indexPath.row].attendence
            switch viewAttendenceObj?.response?.rest?[indexPath.row].attendence {
            case "P":
                classCell.statusLbl.backgroundColor = .AppLightGreen
            case "A":
                classCell.statusLbl.backgroundColor = .AppRed
            case "L":
                classCell.statusLbl.backgroundColor = .AppYellow
            default:
                print("Unknown Status")
            }
            return classCell
        } else {
            classCell.admNoLbl.text = viewCoachingAtdObj?.response?.rest?[indexPath.row].enrollNo
            classCell.rollNoLbl.text = viewCoachingAtdObj?.response?.rest?[indexPath.row].rollNo
            classCell.nameLbl.text = viewCoachingAtdObj?.response?.rest?[indexPath.row].studentName
            classCell.statusLbl.text = viewCoachingAtdObj?.response?.rest?[indexPath.row].attendence
            switch viewCoachingAtdObj?.response?.rest?[indexPath.row].attendence {
            case "P":
                classCell.statusLbl.backgroundColor = .AppLightGreen
            case "A":
                classCell.statusLbl.backgroundColor = .AppRed
            case "L":
                classCell.statusLbl.backgroundColor = .AppYellow
            default:
                print("Unknown Status")
            }
            return classCell
        }
    }
}
extension ClassesAttendanceVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Attendance Not Marked"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let attributedStr = NSAttributedString(string: str,attributes: attributes as [NSAttributedString.Key : Any])
        return attributedStr
    }
}
extension ClassesAttendanceVC {
    func mainClassAttendanceApi(endPoint:String) {
        apiEndPoints = endPoint
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(endPoint).php?Date=\(chooseDateTxtFld.text ?? "")&ClassId=\(classListObj?.response?.res?[selClIndex ?? 0].classId ?? "")&SectionId=\(sectionListObj?.response?.rest?[selSecIndex ?? 0].sectionId ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: endPoint, apiRequestURL: strUrl)
    }
    func classesListApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_fillclass.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_fillclass.getEndPoints, apiRequestURL: strUrl)
    }
    func sectionsListApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Show_Section.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&ClassId=\( classListObj?.response?.res?[selClIndex ?? 0].classId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Show_Section.getEndPoints, apiRequestURL: strUrl)
    }
}

extension ClassesAttendanceVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_View_Attendence.getEndPoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let viewAttendenceDictData = Mapper<ViewAttendenceModel>().map(JSONObject: response) {
                    viewAttendenceObj = viewAttendenceDictData
                    DispatchQueue.main.async {
                        self.showLblData()
                        self.mainClassTblView.reloadData()
                    }
                }
            } else {
                if let viewAttendenceDictData = Mapper<ViewAttendenceModel>().map(JSONObject: response) {
                    viewAttendenceObj = viewAttendenceDictData
                    DispatchQueue.main.async {
                        self.mainClassTblView.reloadData()
                        self.headerView.isHidden = true
                        self.totalStudent.isHidden = true
                    }
                }
            }
        }
        if api == END_POINTS.Api_View_Coaching_Attendance.getEndPoints {
            let status = response["status"] as! Bool
            if status == true {
                if let viewAttendenceDictData = Mapper<ViewAttendenceModel>().map(JSONObject: response) {
                    viewCoachingAtdObj = viewAttendenceDictData
                    DispatchQueue.main.async {
                        self.mainClassTblView.reloadData()
                        self.headerView.isHidden = false
                        self.totalStudent.isHidden = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.mainClassTblView.reloadData()
                    self.headerView.isHidden = true
                    self.totalStudent.isHidden = true
                }
            }
        }
        if api == END_POINTS.Api_fillclass.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let classListDictData = Mapper<FillClassModel>().map(JSONObject: response) {
                    classListObj = classListDictData
                    DispatchQueue.main.async {
                        self.sectionsListApi()
                        self.classLbl.text = self.classListObj?.response?.res?[self.selClIndex ?? 0].className
                        //self.listAppearTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Show_Section.getEndPoints {
            let status = response["status"] as! Bool
            let message = response["msg"] as! String
            if status == true {
                if let sectionListDictData = Mapper<ShowSectionModel>().map(JSONObject: response) {
                    sectionListObj = sectionListDictData
                    DispatchQueue.main.async {
                        self.sectionLbl.text = self.sectionListObj?.response?.rest?[self.selClIndex ?? 0].sectionName
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
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
extension ClassesAttendanceVC: SenderViewControllerDelegate {
    func messageData(data: AnyObject?, type: ScreenType?, selClassIndex: Int, selSectionIndex: Int) {
        
        selClIndex = selClassIndex
        selSecIndex = selSectionIndex
        if type == .ClassList {
            selectedClass = data as? FillClassRes
            classLbl.text = selectedClass?.className
            
        } else {
            selectedSection = data as? ShowSectionRest
            sectionLbl.text = selectedSection?.sectionName
        }
    }
}
