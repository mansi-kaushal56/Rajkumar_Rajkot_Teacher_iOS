//
//  ForwardTaskVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/08/23.
//

import UIKit
import ObjectMapper
import UniformTypeIdentifiers

class ForwardTaskVC: UIViewController {
    var taskId: String?
    var taskObj: TasksRest?
    var periority: String?
    var teacherListObj: TeacherListModel?
    var selectedForwardToArr = [TeacherListRest]()
    var selectedIntimationArr = [TeacherListRest]()
    
    var forwardTaskImg = UIImage()
    var PDFData = Data()
    var isImgUpload = Bool()
    
    
    @IBOutlet weak var documentAddressLbl: UILabel!
    @IBOutlet weak var uploadImgView: UIImageView!
    @IBOutlet weak var taskDescriptionTxtFld: UITextView!
    @IBOutlet weak var priorityHighBtnOtl: UIButton!
    @IBOutlet weak var periorityMediumBtnOtl: UIButton!
    @IBOutlet weak var priorityLowBtnOtl: UIButton!
    @IBOutlet weak var forwordView: UIView!
    @IBOutlet weak var intimationView: UIView!
    @IBOutlet weak var intimationTxtView: UITextView!
    @IBOutlet weak var forwardToTxtView: UITextView!
    @IBOutlet weak var deadlineTxtFld: UITextField!
    @IBOutlet weak var assignTaskOnTxtFld: UITextField!
    @IBOutlet weak var taskNameTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Forward Task")
        tapGestures()
        showTeacherApi()
        periorityTapped(senderTag: 101)
        isImgUpload = true
        showTasksDetail()
        documentAddressLbl.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func submitBtn(_ sender: UIButton) {
        forwardTaskAPI()
    }
    
    @IBAction func priorityBtnAction(_ sender: UIButton) {
        periorityTapped(senderTag: sender.tag)
    }
    @IBAction func uploadImgTapGesture(_ sender: UITapGestureRecognizer) {
        uploadImageOrPdf()
    }
    func tapGestures() {
        intimationTxtView.addTapGestureRecognizer {
            self.showList(type: .IntimationForwardTaskList)
        }
        intimationView.addTapGestureRecognizer {
            self.showList(type: .IntimationForwardTaskList)
        }
        forwardToTxtView.addTapGestureRecognizer {
            self.showList(type: .ForwardToList)
        }
        forwordView.addTapGestureRecognizer {
            self.showList(type: .ForwardToList)
        }
    }
    //10/10/2023
    func setupLabelData() {
        
    }
    //10/10/2023
    func periorityTapped(senderTag: Int){
        switch senderTag {
        case 101:
            priorityLowBtnOtl.setImage(.selectionIcon, for: .normal)
            periorityMediumBtnOtl.setImage(.unselectionIcon, for: .normal)
            priorityHighBtnOtl.setImage(.unselectionIcon, for: .normal)
            periority = "Low"
            
        case 102:
            priorityLowBtnOtl.setImage(.unselectionIcon, for: .normal)
            periorityMediumBtnOtl.setImage(.selectionIcon, for: .normal)
            priorityHighBtnOtl.setImage(.unselectionIcon, for: .normal)
            periority = "Medium"
        case 103:
            priorityLowBtnOtl.setImage(.unselectionIcon, for: .normal)
            periorityMediumBtnOtl.setImage(.unselectionIcon, for: .normal)
            priorityHighBtnOtl.setImage(.selectionIcon, for: .normal)
            periority = "High"
        default:
            return
        }
    }
    func showTasksDetail() {
        assignTaskOnTxtFld.text = taskObj?.datefrom
        deadlineTxtFld.text = taskObj?.deadline
        taskNameTxtFld.text = taskObj?.taskname
        taskDescriptionTxtFld.text = taskObj?.des
        switch taskObj?.priority {
            
        case "Low":
            priorityHighBtnOtl.setImage(.unselectionIcon, for: .normal)
            periorityMediumBtnOtl.setImage(.unselectionIcon, for: .normal)
            priorityLowBtnOtl.setImage(.selectionIcon, for: .normal)
        case "Medium":
            priorityHighBtnOtl.setImage(.unselectionIcon, for: .normal)
            periorityMediumBtnOtl.setImage(.selectionIcon, for: .normal)
            priorityLowBtnOtl.setImage(.unselectionIcon, for: .normal)
        case "High":
            priorityHighBtnOtl.setImage(.selectionIcon, for: .normal)
            periorityMediumBtnOtl.setImage(.unselectionIcon, for: .normal)
            priorityLowBtnOtl.setImage(.unselectionIcon, for: .normal)
        default:
            return
        }
    }
    
    func showList(type:ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.teachersListvc.getIdentifier) as! TeachersListVC
        vc.modalPresentationStyle = .overFullScreen
        vc.teacherListObj = teacherListObj
        vc.delegate = self
        vc.screenTypes = type
        self.present(vc, animated: true)
    }
    func uploadImageOrPdf() {
        let alertVc = UIAlertController(title: "Select Image or PDF", message: nil, preferredStyle: .actionSheet)
        alertVc.addAction(UIAlertAction(title: "Image", style: .default,handler: { [weak self]
            UIAlertAction in
            self?.checkCameraPermission()
        }))
        alertVc.addAction(UIAlertAction(title: "PDF", style: .default,handler: { [weak self]
            UIAlertAction in
            self?.documentPicker()
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
extension ForwardTaskVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }
        print("Selected file URL: \(selectedFileURL)")
        documentAddressLbl.isHidden = false
        documentAddressLbl.text = "Document - \(selectedFileURL.lastPathComponent)"
        do {
            let data = try Data(contentsOf: selectedFileURL)
            PDFData = data
            isImgUpload = false
            forwardTaskImg = UIImage()
            uploadImgView.image = .uploadImg
            
        } catch {
            // Handle the case where there's an error loading the data from the URL
            print("Error loading data from URL: \(error.localizedDescription)")
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
}
extension ForwardTaskVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let img = info[.originalImage] as? UIImage ?? info[.editedImage] as? UIImage {
            uploadImgView.image = img
            forwardTaskImg = img
            isImgUpload = true
            PDFData = Data()
            documentAddressLbl.isHidden = true
        }
//        if let img = info[.originalImage] as? UIImage {
//            uploadImgView.image = img
//            forwardTaskImg = img
//            isImgUpload = true
//        } else if let img = info[.editedImage] as? UIImage {
//            uploadImgView.image = img
//            forwardTaskImg = img
//            isImgUpload = true
//        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension ForwardTaskVC : SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .ForwardToList:
            selectedForwardToArr = data as! [TeacherListRest]
            updateTextViewWithTeacherInfo(teacherArray: selectedForwardToArr, textView: forwardToTxtView)
        case .IntimationForwardTaskList:
            selectedIntimationArr = data as! [TeacherListRest]
            updateTextViewWithTeacherInfo(teacherArray: selectedIntimationArr, textView: intimationTxtView)
        default:
            return
        }
    }
}
extension ForwardTaskVC {
    
    func showTeacherApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Teachers_List.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Teachers_List.getEndPoints, apiRequestURL: strUrl)
    }
    
    func forwardTaskAPI() {
        
        //        let intimation = intimationTxtView.text ?? ""
        //        if intimation.isEmpty {
        //            CommonObjects.shared.showToast(messege: AppMessages.MSG_INTIMATION_EMPTY, controller: self)
        //            return
        //        }
        //        let assignTo = forwardToTxtView.text ?? ""
        //        if assignTo.isEmpty {
        //            CommonObjects.shared.showToast(messege: AppMessages.MSG_ASSIGN_TO_EMPTY, controller: self)
        //            return
        //        }
        var arrTempForwordToIds = [String]()
        for teacherData in selectedForwardToArr {
            print(selectedForwardToArr.count)
            arrTempForwordToIds.append(teacherData.empCode ?? "")
        }
        let selForwordToIds = arrTempForwordToIds.joined(separator: ",")
        print(selForwordToIds)
        
        var arrTempIntimationIds = [String]()
        for teacherData in selectedIntimationArr {
            print(selectedIntimationArr.count)
            arrTempIntimationIds.append(teacherData.empCode ?? "")
        }
        let selIntimationIds = arrTempIntimationIds.joined(separator: ",")
        print(selIntimationIds)
        
        let parameters = ["assignedby": UserDefaults.getUserDetail()?.EmpCode ?? "",
                          "taskid" : taskId ?? "",
                          "assignto" : selForwordToIds,
                          "intimation" : selIntimationIds]
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName:END_POINTS.Api_Update_Profile.getEndPoints,image: forwardTaskImg,pdfData: PDFData,parameters: parameters,isImageUpload: isImgUpload, fileOrPhoto: FileOrPhotoKey.Photo)// Only PDF uploading.
    }
}
extension ForwardTaskVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Update_Profile.getEndPoints {
            let status = response["status"] as? Bool
            let uploadMessage = response["upload_message"] as? String
            if status == true {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: uploadMessage ?? "")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
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
