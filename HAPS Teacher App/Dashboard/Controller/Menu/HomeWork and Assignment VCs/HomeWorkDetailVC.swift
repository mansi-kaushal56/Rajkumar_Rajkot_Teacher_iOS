//
//  HomeWorkDetailVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 05/09/23.
//

import UIKit
import ObjectMapper

class HomeWorkDetailVC: UIViewController {
    
    var screenType: ScreenType?
    var classListObj: FillClassModel?
    var selectedClass: FillClassRes?
    var selectedSection: ShowSectionRest?
    var selectedSectionArr = [ShowSectionRest]()
    var sectionListObj: ShowSectionModel?
    var subjectListObj: SubjectListModel?
    var selectedSubject: SubjectListRest?
    var classId: String?
    var selClIndex: Int? = 0
    var selSecIndex: Int? = 0
    var subjectId: String?

    @IBOutlet weak var classNameView: UIView!
    @IBOutlet weak var classNameLbl: UILabel!
    @IBOutlet weak var ibClassDropDownBtn: UIButton!
    @IBOutlet weak var sectionNameLbl: UILabel!
    @IBOutlet weak var sectioNameView: UIView!
    @IBOutlet weak var ibSectionDropdownBtn: UIButton!
    @IBOutlet weak var subjectNameLbl: UILabel!
    @IBOutlet weak var subjectNameView: UIView!
    @IBOutlet weak var ibSubjectDropdownBtn: UIButton!
    @IBOutlet weak var viewHWHistoryView: UIView!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var dueDateView: UIView!
    @IBOutlet weak var dueDateTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestureRecognizers()
        self.dueDateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker))
        classesListApi()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendHomeWorkBtn(_ sender: UIButton) {
        assignHomeworkApi()
    }
    @objc func datePicker(_ sender:UITapGestureRecognizer){
        if let datePicker = self.dueDateTxtFld.inputView as? UIDatePicker {
            
            //MARK: - Date Format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.dueDateTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.dueDateTxtFld.resignFirstResponder()
    }
    func tapGestureRecognizers() {
        classNameView.addTapGestureRecognizer {
            self.classSubjectList(type: .ClassList)
        }
        subjectNameView.addTapGestureRecognizer {
            self.classSubjectList(type: .SubjectList)
        }
        sectioNameView.addTapGestureRecognizer {
            self.showList()
        }
        viewHWHistoryView.addTapGestureRecognizer {
            self.performSegue(withIdentifier: AppStrings.AppSegue.homeWorkHistorySegue.getDescription, sender: nil)
        }
    }
    func classSubjectList(type: ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.listAppearVC.getIdentifier) as! ListAppearVC
        vc.modalPresentationStyle = .overFullScreen
        switch type {
        case .ClassList:
            vc.type = .ClassList
            vc.clListObj = classListObj
            vc.selClassIndex = selClIndex
            vc.selSecIndex = selSecIndex
            vc.delegate = self
        case .SubjectList:
            vc.type = .SubjectList
            //print(subjectListObj)
            vc.subListObj = subjectListObj
            vc.delegate = self
        default :
            return
        }
        self.present(vc, animated: true)
    }
    func showList() {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.multipleSelListvc.getIdentifier) as! MultipleSelListVC
        vc.modalPresentationStyle = .overFullScreen
        vc.secListObj = sectionListObj
        vc.delegate = self
        vc.type = .SectionList
        self.present(vc, animated: true)
    }
}
extension HomeWorkDetailVC: SenderViewControllerDelegate {
    func messageData(data: AnyObject?, type: ScreenType?, selClassIndex: Int, selSectionIndex: Int) {
        selClIndex = selClassIndex
        selSecIndex = selSectionIndex
        switch type {
        case .ClassList:
                selectedClass = data as? FillClassRes
                classNameLbl.text = selectedClass?.className
                classId = selectedClass?.classId
        default:
            return
        }
    }
}
extension HomeWorkDetailVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .SectionList:
            selectedSectionArr = data as! [ShowSectionRest]
            print(selectedSectionArr)
            updateLabelWithSectionInfo(teacherArray: selectedSectionArr, label: sectionNameLbl)
            subjectListApi()
        case .SubjectList:
            selectedSubject = data as? SubjectListRest
            subjectNameLbl.text = selectedSubject?.subjectName
            subjectId = selectedSubject?.subjectId
        default:
            return
        }
    }
}
extension HomeWorkDetailVC {
    func classesListApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_fillclass.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_fillclass.getEndPoints, apiRequestURL: strUrl)
    }
    func sectionsListApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Show_Section.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&ClassId=\(classListObj?.response?.res?[selClIndex ?? 0].classId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Show_Section.getEndPoints, apiRequestURL: strUrl)
    }
    func subjectListApi() {
        var temlistArr = [String]()
        for listaData in selectedSectionArr {
            temlistArr.append(listaData.sectionId ?? "")
        }
        let selSectionIds = temlistArr.joined(separator: ",")
        
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Subject_List.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&SectionId=\(selSectionIds)&ClassId=\(classId ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Subject_List.getEndPoints, apiRequestURL: strUrl)
    }
    func assignHomeworkApi() {
        
        let description = descriptionTxtView.text ?? ""
        if description.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DESCRIPTION_EMPTY)
            return
        }
        let dueDate = dueDateTxtFld.text ?? ""
        if dueDate.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DUEDATE_EMPTY)
            return
        }
        var temlistArr = [String]()
        for listaData in selectedSectionArr {
            temlistArr.append(listaData.sectionId ?? "")
        }
        let selSectionIds = temlistArr.joined(separator: ",")
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Assign_Homework.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&ClassId=\(classId ?? "")&SectionId=\(selSectionIds)&SubjectId=\(subjectId ?? "")&Description=\(description)&DueDate=\(dueDate)&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Assign_Homework.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
extension HomeWorkDetailVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_fillclass.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let classListDictData = Mapper<FillClassModel>().map(JSONObject: response) {
                    classListObj = classListDictData
                    DispatchQueue.main.async {
                        self.sectionsListApi()
                        self.classNameLbl.text = self.classListObj?.response?.res?[0].className
                        self.classId = self.classListObj?.response?.res?[0].classId
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

                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Subject_List.getEndPoints {
            let status = response["status"] as! Bool
            let message = response["msg"] as! String
            if status == true {
                if let subjectListDictData = Mapper<SubjectListModel>().map(JSONObject: response) {
                    subjectListObj = subjectListDictData
                    print(subjectListDictData)
                    DispatchQueue.main.async {
                        self.subjectNameLbl.text = self.subjectListObj?.response?.rest?[0].subjectName
                        self.subjectId = self.subjectListObj?.response?.rest?[0].subjectId
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Assign_Homework.getEndPoints {
            let status = response["status"] as! Int
            if status == 1 {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    CommonObjects.shared.showToast(message: AppMessages.MSG_HOME_WORK_SEND)
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
