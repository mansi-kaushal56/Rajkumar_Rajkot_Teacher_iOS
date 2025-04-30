//
//  AssignTaskVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 07/08/23.
//

import UIKit
import ObjectMapper
import UniformTypeIdentifiers

class AssignTaskVC: UIViewController {
    var periority: String?
    var teacherListObj: TeacherListModel?
    var selectedIntimationArr = [TeacherListRest]()
    var selectedAssignToArr = [TeacherListRest]()
    var PDFData = Data()
    var assignImg = UIImage()
    var isImgUpload = Bool()
    
    @IBOutlet weak var intimationView: UIView!
    @IBOutlet weak var assignToView: UIView!
    
    @IBOutlet weak var ibPeriorityHighBtn: UIButton!
    @IBOutlet weak var ibPeriorityMediumBtn: UIButton!
    @IBOutlet weak var ibPriorityLowBtn: UIButton!
    
    @IBOutlet weak var intimationTxtView: UITextView!
    @IBOutlet weak var assignToTxtView: UITextView!
    @IBOutlet weak var deadlineTxtFld: UITextField!
    @IBOutlet weak var assignTaskOnTxtFld: UITextField!
    @IBOutlet weak var taskDescriptionTxtFld: UITextView!
    @IBOutlet weak var taskNameTxtFld: UITextField!
    @IBOutlet weak var taskImgView: UIImageView!
    @IBOutlet weak var docNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickersInView()
        backBtn(title: "Assign Task")
        showTeacherApi()
        tapGestureRecs()
        print(PDFData)
        isImgUpload = true
        periorityTapped(senderTag: 101)
        docNameLbl.isHidden = true
        // Do any additional setup after loading the view.
    }
    func datePickersInView() {
        self.assignTaskOnTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker2))
        self.deadlineTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker3))
    }
    func tapGestureRecs() {
        assignToView.addTapGestureRecognizer {
            self.showTeacherList(type: .AssignToList)
        }
        assignToTxtView.addTapGestureRecognizer {
            self.showTeacherList(type: .AssignToList)
        }
         
        intimationView.addTapGestureRecognizer {
            self.showTeacherList(type: .IntimationList)
        }
        intimationTxtView.addTapGestureRecognizer {
            self.showTeacherList(type: .IntimationList)
        }
        taskImgView.addTapGestureRecognizer {
            self.uploadImageOrPdf()
        }
    //https://medium.com/@sdrzn/adding-gesture-recognizers-with-closures-instead-of-selectors-9fb3e09a8f0b
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        assignTaskAPI()
    }
    @IBAction func ibPeriorityActionBtn(_ sender: UIButton) {
        periorityTapped(senderTag: sender.tag)
    }
    
    @objc func datePicker2(_ sender:UITapGestureRecognizer){
           if let datePicker = self.assignTaskOnTxtFld.inputView as? UIDatePicker {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd-MM-yyyy"
               
               self.assignTaskOnTxtFld.text = dateFormatter.string(from: datePicker.date)
           }
           self.assignTaskOnTxtFld.resignFirstResponder()
       }
    @objc func datePicker3(_ sender:UITapGestureRecognizer){
           if let datePicker = self.deadlineTxtFld.inputView as? UIDatePicker {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd-MM-yyyy"
               
               self.deadlineTxtFld.text = dateFormatter.string(from: datePicker.date)
           }
           self.deadlineTxtFld.resignFirstResponder()
       }
    func showTeacherList(type:ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.teachersListvc.getIdentifier) as! TeachersListVC
        vc.modalPresentationStyle = .overFullScreen
        vc.teacherListObj = teacherListObj
        vc.delegate = self
        vc.screenTypes = type
        self.present(vc, animated: true)
    }
    func periorityTapped(senderTag: Int){
        switch senderTag {
        case 101:
            ibPriorityLowBtn.setImage(.selectionIcon, for: .normal)
            ibPeriorityMediumBtn.setImage(.unselectionIcon, for: .normal)
            ibPeriorityHighBtn.setImage(.unselectionIcon, for: .normal)
            periority = "Low"
            
        case 102:
            ibPriorityLowBtn.setImage(.unselectionIcon, for: .normal)
            ibPeriorityMediumBtn.setImage(.selectionIcon, for: .normal)
            ibPeriorityHighBtn.setImage(.unselectionIcon, for: .normal)
            periority = "Medium"
        case 103:
            ibPriorityLowBtn.setImage(.unselectionIcon, for: .normal)
            ibPeriorityMediumBtn.setImage(.unselectionIcon, for: .normal)
            ibPeriorityHighBtn.setImage(.selectionIcon, for: .normal)
            periority = "High"
        default:
            return
        }
    }
    func uploadImageOrPdf() {
        let alertVc = UIAlertController(title: "Select Image or PDF", message: nil, preferredStyle: .actionSheet)
        alertVc.addAction(UIAlertAction(title: "Image", style: .default,handler: { [weak self]
            UIAlertAction in
            self?.checkCameraPermission()
            self?.PDFData = Data()
        }))
        alertVc.addAction(UIAlertAction(title: "PDF", style: .default,handler: { [weak self]
            UIAlertAction in
            self?.documentPicker()
            self?.assignImg = UIImage()
            self?.taskImgView.image = UIImage()
        }))
        alertVc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertVc, animated: true)
    }
    func documentPicker() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.data])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
}
extension AssignTaskVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
                   return
               }
        print("Selected file URL: \(selectedFileURL)")
        docNameLbl.isHidden = false
        docNameLbl.text = "Document - \(selectedFileURL.lastPathComponent)"
        do {
            let data = try Data(contentsOf: selectedFileURL)
            PDFData = data
            isImgUpload = false
            assignImg = UIImage()
            taskImgView.image = .uploadImg
            
            
        } catch {
            // Handle the case where there's an error loading the data from the URL
            print("Error loading data from URL: \(error.localizedDescription)")
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
}
extension AssignTaskVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage ?? info[.editedImage] as? UIImage {
            taskImgView.image = img
            assignImg = img
            isImgUpload = true
            PDFData = Data()
            docNameLbl.isHidden = true
            
        }
//            else if let img = info[.editedImage] as? UIImage {
//            taskImgView.image = img
//            assignImg = img
//        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension AssignTaskVC : SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .AssignToList:
            selectedAssignToArr = data as! [TeacherListRest]
            updateTextViewWithTeacherInfo(teacherArray: selectedAssignToArr, textView: assignToTxtView)
            
        case .IntimationList:
            selectedIntimationArr = data as! [TeacherListRest]
            updateTextViewWithTeacherInfo(teacherArray: selectedIntimationArr, textView: intimationTxtView)
           
        default:
            return
        }
    }
}
extension AssignTaskVC {
    
    func showTeacherApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Teachers_List.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Teachers_List.getEndPoints, apiRequestURL: strUrl)
    }
//    func showCommentApi() {
//        CommonObjects.shared.showProgress()
//        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Teachers_List.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
//        let obj = ApiRequest()
//        obj.delegate = self
//        obj.requestAPI(apiName: END_POINTS.Api_Teachers_List.getEndPoints, apiRequestURL: strUrl)
//    }
    func assignTaskAPI() {
        let tasksname = taskNameTxtFld.text ?? ""
        if tasksname.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_TASK_NAME_EMPTY, controller: self)
            return
        }
        let description = taskDescriptionTxtFld.text ?? ""
        if description.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DESCRIPTION_EMPTY, controller: self)
            return
        }
        let fromdate = assignTaskOnTxtFld.text ?? ""
        if fromdate.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_ASSIGN_TASK_ON_EMPTY, controller: self)
            return
        }
        let deadline = deadlineTxtFld.text ?? ""
        if deadline.isEmpty {
           CommonObjects.shared.showToast(message: AppMessages.MSG_DEADLINE_EMPTY, controller: self)
            return
        }
        let intimation = intimationTxtView.text ?? ""
        if intimation.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_INTIMATION_EMPTY, controller: self)
            return
        }
        let assignTo = assignToTxtView.text ?? ""
        if assignTo.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_ASSIGN_TO_EMPTY, controller: self)
            return
        }
        var arrTempAssiognToIds = [String]()
        for teacherData in selectedAssignToArr {
            arrTempAssiognToIds.append(teacherData.empCode ?? "")
        }
        let selAssignToIds = arrTempAssiognToIds.joined(separator: ",")
        print(selAssignToIds)
        
        var arrTempIntimationIds = [String]()
        for teacherData in selectedIntimationArr {
            arrTempIntimationIds.append(teacherData.empCode ?? "")
        }
        let selIntimationIds = arrTempIntimationIds.joined(separator: ",")
        print(selIntimationIds)
        let parameters: [String:String] = ["taskname":tasksname,
                                           "description":description,
                                           "fromdate":fromdate,
                                           "deadline":deadline,
                                           "priority":periority ?? "",
                                           "assignto":selAssignToIds,
                                           "intimation":selIntimationIds,
                                           "assignedby":UserDefaults.getUserDetail()?.EmpCode ?? "",
                                           "BranchId":UserDefaults.getUserDetail()?.BranchId ?? "",
                                           "SessionId":UserDefaults.getUserDetail()?.Session ?? ""]
        debugPrint("Api Parameters - \(parameters)")
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName:END_POINTS.Api_Assigntask.getEndPoints , image: assignImg, pdfData: PDFData, parameters: parameters, isImageUpload: isImgUpload, fileOrPhoto: FileOrPhotoKey.File) //Both Image and PDF uploading.
    }
}
extension AssignTaskVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Assigntask.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                DispatchQueue.main.async {
                    //pdfData = nil
                    CommonObjects.shared.showToast(message: AppMessages.MSG_TASK_ASSIGNED)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
//        if api == END_POINTS.Api_Update_Profile.getEndPoints {
//            let status = response["status"] as? Bool
//            let uploadMessage = response["upload_message"] as? String
//            if status == true {
//
//            }
//        }
        if api == END_POINTS.Api_Teachers_List.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                if let teacherListDictData = Mapper<TeacherListModel>().map(JSONObject: response) {
                    teacherListObj = teacherListDictData
                    
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

