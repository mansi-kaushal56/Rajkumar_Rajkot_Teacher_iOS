//
//  MarksEntryVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 20/09/23.
//

import UIKit
import ObjectMapper

class MarksEntryVC: UIViewController {
    
    var exemTypeOrTestOBj: ExamtestListModel?
    
    var marksClassSecObj: MarksClassSecListModel?
    var selectedClassAndSec: MarksClassSecListRes?
    
    var examHeadObj: ExamHeadListModel?
    var selectedExamHead: ExamHeadListRest?
    
    var examTypeObj: ExamHeadListModel?
    var selectedExamType: ExamHeadListRest?
    
    var examTestObj: ExamtestListModel?
    var selectedExamTest: ExamtestListRest?
    
    var paparTypeListObj: ExamTypeListModel?
    var selectedPaper: ExamTypeListRest?
    
    var selectSubjectListObj: SubjectsListModel?
    var selectSubject: SubjectsListRest?
    
    var totalMarksObj: TotalMarksModel?
   
    @IBOutlet weak var examDateTxtFld: UITextField!
    @IBOutlet weak var maxiMarksTxtFld: UITextField!
    @IBOutlet weak var selectSubjectTxtFld: UITextField!
    @IBOutlet weak var selectSubjectView: UIView!
    @IBOutlet weak var typeTxtFld: UITextField!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var examTestTxtFld: UITextField!
    @IBOutlet weak var examTestView: UIView!
    @IBOutlet weak var examTypeTxtFld: UITextField!
    @IBOutlet weak var examTypeView: UIView!
    @IBOutlet weak var examHeadTxtFld: UITextField!
    @IBOutlet weak var examHeadView: UIView!
    @IBOutlet weak var classTextFld: UITextField!
    @IBOutlet weak var classView: UIView!
    @IBOutlet weak var ibShowBtn : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Marks Entry")
        classAndSecListApi()
        tapGestureRecognizers()
        ibShowBtn.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.showMarksSegue.getDescription {
            if let destinationVC = segue.destination as? ShowMarksEntryVC {
                destinationVC.selectedClassAndSecObj = selectedClassAndSec
                destinationVC.headid = selectedExamHead?.id ?? ""
                destinationVC.examtypeid = selectedExamType?.id ?? ""
                destinationVC.test = selectedExamTest?.test ?? ""
                destinationVC.type = selectedPaper?.type ?? ""
                destinationVC.subid = selectSubject?.subjectId ?? ""
                destinationVC.Max = totalMarksObj?.total ?? ""
                destinationVC.examid = selectSubject?.examid ?? ""
                
                destinationVC.subName = selectSubject?.subjectName ?? ""
                destinationVC.headName = selectedExamHead?.head ?? ""
                destinationVC.examTypeName = selectedExamType?.head ?? ""
               
            
            }
        }
    }
    @IBAction func showBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: AppStrings.AppSegue.showMarksSegue.getDescription, sender: nil)
    }
    func tapGestureRecognizers() {
        classView.addTapGestureRecognizer {
            self.listAppear(type: .MarksClassSecList)
        }
        examHeadView.addTapGestureRecognizer {
            self.listAppear(type: .MarksExamHeadList)
        }
        examTypeView.addTapGestureRecognizer {
            self.listAppear(type: .MarksExamTypeList)
        }
        examTestView.addTapGestureRecognizer {
            self.listAppear(type: .MarksExamTestList)
        }
        typeView.addTapGestureRecognizer {
            self.listAppear(type: .MarksExamPaperTypeList )
        }
        selectSubjectView.addTapGestureRecognizer {
            self.listAppear(type: .MarksSubjectList)
        }
        
    }
    func listAppear(type:ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.listAppearVC.getIdentifier) as! ListAppearVC
        vc.modalPresentationStyle = .overFullScreen
        switch type {
        case .MarksClassSecList:
            vc.senderDelegate = self
            vc.marksClassOrSecObj = marksClassSecObj
            vc.type = .MarksClassSecList
        case .MarksExamHeadList:
            vc.senderDelegate = self
            vc.marksExamHeadObj = examHeadObj
            vc.type = .MarksExamHeadList
            
        case .MarksExamTypeList:
            vc.senderDelegate = self
            vc.type = .MarksExamTypeList
            vc.marksExamTypeObj = examTypeObj
            
        case .MarksExamTestList:
            vc.senderDelegate = self
            vc.type = .MarksExamTestList
            vc.marksExamTestObj = examTestObj
            
        case .MarksExamPaperTypeList:
            vc.senderDelegate = self
            vc.type = .MarksExamPaperTypeList
            vc.marksPaperTypeObj = paparTypeListObj
            
        case .MarksSubjectList:
            vc.senderDelegate = self
            vc.marksSelectSubjectObj = selectSubjectListObj
            vc.type = .MarksSubjectList
        default:
            print("Unkown List Type")
        }
        self.present(vc, animated: true)
    }
    func loadExamDataTotal() {
        examDateTxtFld.text = totalMarksObj?.examdate
        maxiMarksTxtFld.text = totalMarksObj?.total
    }
}

extension MarksEntryVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .MarksClassSecList:
            selectedClassAndSec = data as? MarksClassSecListRes
            classTextFld.text = selectedClassAndSec?.className
            examHeadTxtFld.text = nil
            examHeadListApi()
            
        case .MarksExamHeadList:
            selectedExamHead = data as? ExamHeadListRest
            examHeadTxtFld.text = selectedExamHead?.head
            examTypeTxtFld.text = nil
            examTypeApi()
            
        case .MarksExamTypeList:
            selectedExamType = data as? ExamHeadListRest
            examTypeTxtFld.text = selectedExamType?.head
            examTestTxtFld.text = nil
            examTestApi()
            
        case .MarksExamTestList:
            selectedExamTest = data as? ExamtestListRest
            examTestTxtFld.text = selectedExamTest?.test
            typeTxtFld.text = nil
            paperTypeListApi()
            
        case .MarksExamPaperTypeList:
            selectedPaper = data as? ExamTypeListRest
            typeTxtFld.text = selectedPaper?.type
            selectSubjectTxtFld.text = nil
            subjectListApi()
            
        case .MarksSubjectList:
            selectSubject = data as? SubjectsListRest
            selectSubjectTxtFld.text = selectSubject?.subjectName
            getTotalMarksApi()
        default :
            print("Unknown Type")
        }
    }
}
extension MarksEntryVC {
    func classAndSecListApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Marks_Class_Sec_List.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Marks_Class_Sec_List.getEndPoints, apiRequestURL: strUrl)
    }
    func examHeadListApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Exam_Head_List.getEndPoints).php?classid=\(selectedClassAndSec?.classid ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Exam_Head_List.getEndPoints, apiRequestURL: strUrl)
    }
    func examTypeApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Exam_Type_List.getEndPoints).php?classid=\(selectedClassAndSec?.classid ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&headid=\(selectedExamHead?.id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Exam_Type_List.getEndPoints, apiRequestURL: strUrl)
    }
    func examTestApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Get_Exam_Test_List.getEndPoints).php?classid=\(selectedClassAndSec?.classid ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&headid=\(selectedExamHead?.id ?? "")&typeid=\(selectedExamType?.id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Get_Exam_Test_List.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    func paperTypeListApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Paper_Type_List.getEndPoints).php?classid=\(selectedClassAndSec?.classid ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&headid=\(selectedExamHead?.id ?? "")&typeid=\(selectedExamType?.id ?? "")&test=\(selectedExamTest?.test ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Paper_Type_List.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    func subjectListApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Get_Subjects_List.getEndPoints).php?classid=\(selectedClassAndSec?.classid ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&headid=\(selectedExamHead?.id ?? "")&examtypeid=\(selectedExamType?.id ?? "")&test=\(selectedExamTest?.test ?? "")&type=\(selectedPaper?.type ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&SectionId=\(selectedClassAndSec?.sectionId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Get_Subjects_List.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    func getTotalMarksApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Get_Total_Marks.getEndPoints).php?classid=\(selectedClassAndSec?.classid ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&headid=\(selectedExamHead?.id ?? "")&examtypeid=\(selectedExamType?.id ?? "")&test=\(selectedExamTest?.test ?? "")&type=\(selectedPaper?.type ?? "")&subid=\(selectSubject?.subjectId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Get_Total_Marks.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
}
extension MarksEntryVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        let status = response["status"] as? String
        if api == END_POINTS.Api_Marks_Class_Sec_List.getEndPoints {
            if status == "true" {
                if let classSecDictData = Mapper<MarksClassSecListModel>().map(JSONObject: response) {
                    marksClassSecObj = classSecDictData
                }
            }
        }
        if api == END_POINTS.Api_Exam_Head_List.getEndPoints {
            if status == "SUCCESS" {
                if let examHeadDictData = Mapper<ExamHeadListModel>().map(JSONObject: response) {
                    examHeadObj = examHeadDictData
                }
            }
        }
        if api == END_POINTS.Api_Exam_Type_List.getEndPoints {
            if status == "SUCCESS" {
                if let examHeadDictData = Mapper<ExamHeadListModel>().map(JSONObject: response) {
                    examTypeObj = examHeadDictData
                }
            }
        }
        if api == END_POINTS.Api_Get_Exam_Test_List.getEndPoints {
            if status == "SUCCESS" {
                if let examHeadDictData = Mapper<ExamtestListModel>().map(JSONObject: response) {
                    examTestObj = examHeadDictData
                }
            }
        }
        if api == END_POINTS.Api_Paper_Type_List.getEndPoints {
            if status == "SUCCESS" {
                if let paperDictData = Mapper<ExamTypeListModel>().map(JSONObject: response) {
                    print(paperDictData)
                    paparTypeListObj = paperDictData
                }
            }
        }
        if api == END_POINTS.Api_Get_Subjects_List.getEndPoints {
            if status == "SUCCESS" {
                if let subjectListDictData = Mapper<SubjectsListModel>().map(JSONObject: response) {
                    selectSubjectListObj = subjectListDictData
                    
                }
            } else {
                if let subjectListDictData = Mapper<SubjectsListModel>().map(JSONObject: response) {
                    selectSubjectListObj = subjectListDictData
                    
                }
            }
        }
        if api == END_POINTS.Api_Get_Total_Marks.getEndPoints {
            if status == "true" {
                if let totalMarksDictData = Mapper<TotalMarksModel>().map(JSONObject: response) {
                    totalMarksObj = totalMarksDictData
                    DispatchQueue.main.async {
                        self.loadExamDataTotal()
                        self.ibShowBtn.isHidden = false
                    }
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
