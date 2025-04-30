//
//  HolisticMarksEntryVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 21/09/23.
//

import UIKit
import ObjectMapper

class HolisticMarksEntryVC: UIViewController {
    var selClIndex: Int? = 0
    var selSecIndex: Int? = 0
    var classListObj: FillClassModel?
    var selectedClass: FillClassRes?
    
    var sectionListObj: ShowSectionModel?
    var selectedSection: ShowSectionRest?
    
    var termId: String?
    var holisticTermObj: ExamHeadListModel?
    var selHolisticTermObj: ExamHeadListRest?
    
   

    @IBOutlet weak var holisticSubMTxtFld: UITextField!
    @IBOutlet weak var holisticHeadTxtFld: UITextField!
    @IBOutlet weak var termNameTxtFld: UITextField!
    @IBOutlet weak var sectionTxtFld: UITextField!
    @IBOutlet weak var classTxtFld: UITextField!
    @IBOutlet weak var holisticSubView: UIView!
    @IBOutlet weak var holisticHeadView: UIView!
    @IBOutlet weak var termNameView: UIView!
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var classView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Holistic Marks Entry")
        classesListApi()
        viewTapGestures()
        termListApi()
        // Do any additional setup after loading the view.
    }

    @IBAction func showBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: AppStrings.AppSegue.showHolisticEntrySegue.getDescription, sender: nil)
    }
//MARK: (17-oct-2023)
    func viewTapGestures() {
        holisticSubView.addTapGestureRecognizer {
            
        }
        holisticHeadView.addTapGestureRecognizer {
            
        }
        termNameView.addTapGestureRecognizer {
            self.listAppear(type: .HolisticTermList)
        }
        sectionView.addTapGestureRecognizer {
            self.listAppear(type: .SectionList)
        }
        classView.addTapGestureRecognizer {
            self.listAppear(type: .ClassList)
        }
    }
    func listAppear(type: ScreenType) {
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
            vc.delegate = self
        case .ClassList:
            vc.type = .ClassList
            vc.selClassIndex = selClIndex
            vc.selSecIndex = selSecIndex
            vc.clListObj = classListObj
            vc.delegate = self
        case .HolisticTermList:
            vc.senderDelegate = self
            vc.marksExamHeadObj = holisticTermObj
            vc.type = .CBOTermList
        
            
        default :
            return
        }
        
        self.present(vc, animated: true)
    }
}
extension HolisticMarksEntryVC: SenderViewControllerDelegate {
    func messageData(data: AnyObject?, type: ScreenType?, selClassIndex: Int, selSectionIndex: Int) {
        
        selClIndex = selClassIndex
        selSecIndex = selSectionIndex
        if type == .ClassList {
            selectedClass = data as? FillClassRes
            classTxtFld.text = selectedClass?.className
            
        } else {
            selectedSection = data as? ShowSectionRest
            sectionTxtFld.text = selectedSection?.sectionName
        }
    }
}
//28/09/2023
//(17-oct-2023)
extension HolisticMarksEntryVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
            
        case .HolisticTermList:
            selHolisticTermObj = data as? ExamHeadListRest
            termNameTxtFld.text = selHolisticTermObj?.head
        
        default:
            return
        }
        
    }
    
}
//28/09/2023
extension HolisticMarksEntryVC {
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
    func termListApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Get_Holistic_Term.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Get_Holistic_Term.getEndPoints, apiRequestURL: strUrl)
    }
}
extension HolisticMarksEntryVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_fillclass.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let classListDictData = Mapper<FillClassModel>().map(JSONObject: response) {
                    classListObj = classListDictData
                    DispatchQueue.main.async {
                        self.sectionsListApi()
                        self.classTxtFld.text = self.classListObj?.response?.res?[self.selClIndex ?? 0].className
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
                        self.sectionTxtFld.text = self.sectionListObj?.response?.rest?[self.selClIndex ?? 0].sectionName
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Get_Holistic_Term.getEndPoints {
            let status = response["status"] as! String
            if status == "SUCCESS" {
                if let CBOtermDictData = Mapper<ExamHeadListModel>().map(JSONObject: response) {
                    holisticTermObj = CBOtermDictData
                    DispatchQueue.main.async {
                        self.termNameTxtFld.text = self.holisticTermObj?.response?.rest?[0].head
                        self.termId = self.holisticTermObj?.response?.rest?[0].id
                        //self.unitListApi()
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
