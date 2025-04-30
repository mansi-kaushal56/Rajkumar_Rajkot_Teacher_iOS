//
//  HomeWorkVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 22/08/23.
//

import UIKit
import ObjectMapper

class HomeWorkVC: UIViewController {
    
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

    
    @IBOutlet weak var assignmentView: UIView!
    @IBOutlet weak var homeWorkView: UIView!
    @IBOutlet weak var homeWorkScreenView: UIView!
    @IBOutlet weak var asisignScreenView: UIView!
    
    @IBOutlet weak var assignmentImg: UIImageView!
    @IBOutlet weak var homeWorkImg: UIImageView!
    @IBOutlet weak var assignmentLbl: UILabel!
    @IBOutlet weak var homwWorkLbl: UILabel!
    //HomeworkOutLets
    @IBOutlet weak var homeWDescriptionTxtView: UITextView!
    @IBOutlet weak var homeWorkHistoryView: UIView!
    @IBOutlet weak var homeWorkDateTxtFld: UITextField!
    
    @IBOutlet weak var homeWorkSubjectLbl: UILabel!
    @IBOutlet weak var homeWorkSubjectView: UIView!
    
    @IBOutlet weak var homeWorkSectionLbl: UILabel!
    @IBOutlet weak var homeWorkSectionView: UIView!
    
    @IBOutlet weak var homeWorkClassLbl: UILabel!
    @IBOutlet weak var homeWorkClassView: UIView!
    
    //AssignmentOteLets
    @IBOutlet weak var uploadDocumentView: UIView!
    @IBOutlet weak var assignDescriptionTxtView: UITextView!
    @IBOutlet weak var assignSubjectLbl: UILabel!
    @IBOutlet weak var assignSectionLbl: UILabel!
    @IBOutlet weak var assignClassLbl: UILabel!
    @IBOutlet weak var assignDateTxtFld: UITextField!
    @IBOutlet weak var assignSubjectView: UIView!
    @IBOutlet weak var assignSectionView: UIView!
    @IBOutlet weak var assignmentClassView: UIView!
    @IBOutlet weak var assignmentHistoryView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Homework/Assignment")
        homeWorkPage(type: .Homework)
        tapgestures()
        classesListApi()
        self.assignDateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker2))
        self.homeWorkDateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker3))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendAssignmentAction(_ sender: UIButton) {
    }
    @IBAction func sendHomeWorkAction(_ sender: UIButton) {
        assignHomeworkApi()
    }
    
    @objc func datePicker2(_ sender:UITapGestureRecognizer){
        if let datePicker = self.assignDateTxtFld.inputView as? UIDatePicker {
            
            //MARK: - Date Format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            self.assignDateTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.assignDateTxtFld.resignFirstResponder()
    }
    @objc func datePicker3(_ sender:UITapGestureRecognizer){
        if let datePicker = self.homeWorkDateTxtFld.inputView as? UIDatePicker {
            
            //MARK: - Date Format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            self.homeWorkDateTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.homeWorkDateTxtFld.resignFirstResponder()
    }
    //MARK: HistoryView action
        
    func homeWorkPage(type:ScreenType) {
        switch type {
        case .Homework:
            self.asisignScreenView.isHidden = true
            self.homeWorkScreenView.isHidden = false
            homeWorkView.backgroundColor = .AppSkyBlue
            assignmentView.backgroundColor = .clear
            homwWorkLbl.textColor = .white
            assignmentLbl.textColor = .black
            assignmentImg.image = .assignmentBlackIcon
            homeWorkImg.image = .homeworkWhiteIcon
        case .Assignment:
            self.asisignScreenView.isHidden = false
            self.homeWorkScreenView.isHidden = true
            homeWorkView.backgroundColor = .clear
            assignmentView.backgroundColor = .AppSkyBlue
            homwWorkLbl.textColor = .black
            assignmentLbl.textColor = .white
            assignmentImg.image = .assignmentWhiteIcon
            homeWorkImg.image = .homeworkBlackIcon
        default:
            print("Unknown type")
        }
          
       }

    func tapgestures() {
        homeWorkHistoryView.addTapGestureRecognizer {
            self.performSegue(withIdentifier: AppStrings.AppSegue.homeWorkHistorySegue.getDescription, sender: nil)
        }
        assignmentHistoryView.addTapGestureRecognizer {
            self.performSegue(withIdentifier: AppStrings.AppSegue.assignmentHistorySegue.getDescription, sender: nil)
        }
        
        homeWorkView.addTapGestureRecognizer {
            self.homeWorkPage(type: .Homework)
        }
        assignmentView.addTapGestureRecognizer {
            self.homeWorkPage(type: .Assignment )
        }
        homeWorkClassView.addTapGestureRecognizer {
            self.classSubjectList(type: .ClassList)
        }
        homeWorkSectionView.addTapGestureRecognizer {
            self.showList()
        }
        homeWorkSubjectView.addTapGestureRecognizer {
            self.subjectListApi()
        }
        assignmentClassView.addTapGestureRecognizer {
            self.classSubjectList(type: .ClassList)
        }
        assignSectionView.addTapGestureRecognizer {
            self.showList()
        }
        assignSubjectView.addTapGestureRecognizer {
            self.classSubjectList(type: .SubjectList)
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
extension HomeWorkVC: SenderViewControllerDelegate {
    func messageData(data: AnyObject?, type: ScreenType?, selClassIndex: Int, selSectionIndex: Int) {
        selClIndex = selClassIndex
        selSecIndex = selSectionIndex
        switch type {
        case .ClassList:
            //if screenType == .Homework {
                selectedClass = data as? FillClassRes
                homeWorkClassLbl.text = selectedClass?.className
                classId = selectedClass?.classId
//            } else {
//                selectedClass = data as? FillClassRes
//                assignClassLbl.text = selectedClass?.className
//                classId = selectedClass?.classId
//            }
            
        default:
            return
        }
    }
}
extension HomeWorkVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .SectionList:
            selectedSectionArr = data as! [ShowSectionRest]
            print(selectedSectionArr)
            updateLabelWithSectionInfo(teacherArray: selectedSectionArr, label: homeWorkSectionLbl)
            subjectListApi()
        case .SubjectList:
            selectedSubject = data as? SubjectListRest
            homeWorkSubjectLbl.text = selectedSubject?.subjectName
           
        default:
            return
        }
    }
}
extension HomeWorkVC {
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
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Assign_Homework.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&ClassId=\(selectedClass?.classId ?? "")&SectionId=\(selectedSection?.sectionId ?? "")&SubjectId=\("")&Description=\("")&DueDate=\("")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Assign_Homework.getEndPoints, apiRequestURL: strUrl)
    }
    func assignAssignmentApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Send_Assignment.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&ClassId=\("")&SectionId=\("")&SubjectId=\("")&Description=\("")&DueDate=\("")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Send_Assignment.getEndPoints, apiRequestURL: strUrl)
    }
}
extension HomeWorkVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_fillclass.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let classListDictData = Mapper<FillClassModel>().map(JSONObject: response) {
                    classListObj = classListDictData
                    DispatchQueue.main.async {
                        self.sectionsListApi()
                        //if self.screenType == .Homework {
                            self.homeWorkClassLbl.text = self.classListObj?.response?.res?[0].className
                       // } else {
                            //self.assignClassLbl.text = self.classListObj?.response?.res?[0].className
                       // }
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
                    DispatchQueue.main.async {
                        self.homeWorkSubjectLbl.text = self.subjectListObj?.response?.rest?[0].subjectName
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

