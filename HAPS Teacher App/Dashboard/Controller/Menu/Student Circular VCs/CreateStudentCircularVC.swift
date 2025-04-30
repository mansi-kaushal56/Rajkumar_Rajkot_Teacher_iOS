//
//  CreateStudentCircularVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 11/09/23.
//

import UIKit
import UniformTypeIdentifiers
import ObjectMapper

class CreateStudentCircularVC: UIViewController {
    var studentTypeObj: StudentTypeListModel?
    var selectedStType: StudentTypeListRest?
    
    var stCircularClObj: StCircularClListModel?
    var selectedStCircularClass: StCircularClListRest?
    var studentListObj: CircularStudentListModel?
    var studentEnrollArr = [String]()
    
    
    var selectedTypeId = ""
    var classId = ""
    var sectionId = ""
    var studentCircularImg = UIImage()
    var PDFData = Data()
    var groupType: String?
    var isImgUpload = Bool()

    @IBOutlet weak var dateTxtFld: UITextField!
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var studentTypeTxtFld: UITextField!
    @IBOutlet weak var studentGroupTxtFld: UITextField!
    @IBOutlet weak var selectClassTxtFld: UITextField!
    @IBOutlet weak var messageTxtView: UITextView!
    
    @IBOutlet weak var studentTypeView: UIView!
    @IBOutlet weak var stGroupView: UIView!
    @IBOutlet weak var stClassView: UIView!
    @IBOutlet weak var uploadImgView: UIImageView!
    @IBOutlet weak var studentCirTblView: UITableView!
    @IBOutlet weak var documentAddressLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestures()
        studentTypeAPI()
        tapGestures()
        stClassView.isHidden = true
        studentCirTblView.isHidden = true
        self.dateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker))
        isImgUpload = true
        documentAddressLbl.isHidden = true
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        createStCircularApi()
//        let enrollNoId = studentEnrollArr.joined(separator: ",")
//        let parameters: [String:String] = ["branch_id":UserDefaults.getUserDetail()?.BranchId ?? "",
//                          "session_id":UserDefaults.getUserDetail()?.Session ?? "",
//                          "enroll_no":enrollNoId,
//                          "class_id":classId,
//                          "section_id":sectionId,
//                          "circular_date":dateTxtFld.text ?? "",
//                          "EmpCode":UserDefaults.getUserDetail()?.EmpCode ?? "",
//                          "title": titleTxtFld.text ?? "",
//                          "description":messageTxtView.text ?? "",
//                          "student_type_id":selectedStType?.studentTypeID ?? "",
//                          "group_type":groupType ?? ""]
    }
    @objc func datePicker(_ sender:UITapGestureRecognizer){
           if let datePicker = self.dateTxtFld.inputView as? UIDatePicker {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd-MM-yyyy"
               
               self.dateTxtFld.text = dateFormatter.string(from: datePicker.date)
           }
           self.dateTxtFld.resignFirstResponder()
       }
    func tapGestures() {
        studentTypeView.addTapGestureRecognizer {
            self.listAppear(type: .StudentType)
        }
        stGroupView.addTapGestureRecognizer {
            self.groupSelection()
        }
        stClassView.addTapGestureRecognizer {
            self.listAppear(type: .CircularClassesList )
        }
        uploadImgView.addTapGestureRecognizer {
            self.uploadImageOrPdf()
        }
        
    }
    func listAppear(type:ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.listAppearVC.getIdentifier) as! ListAppearVC
        vc.modalPresentationStyle = .overFullScreen
        switch type {
        case .StudentType:
            vc.senderDelegate = self
            vc.stType = studentTypeObj
            vc.type = .StudentType
        case .CircularClassesList:
            vc.senderDelegate = self
            vc.stCircularObj = stCircularClObj
            vc.type = .CircularClassesList
            
        default:
            print("Unkown List Type")
        }
        self.present(vc, animated: true)
    }
    func groupSelection() {
        let groups = ["School", "Class", "Cancel"]
        showSelectionOptions(title: "Select a Group", options: groups) { [weak self] selectedOption in
            if selectedOption != "Cancel" {
                self?.studentGroupTxtFld.text = selectedOption
                self?.groupTapped(selOption: selectedOption)
            }
        }
    }
    func groupTapped(selOption: String) {
        if selOption == "Class" {
            stClassView.isHidden = false
            studentCirTblView.isHidden = false
            stCircularClassesAPI()
            //studentListAPI()
            groupType = selOption
            
        } else {
            stClassView.isHidden = true
            studentCirTblView.isHidden = true
            classId = ""
            sectionId = ""
            studentEnrollArr.removeAll()
            groupType = selOption
        }
    }
    func selectedType() {
        selectedTypeId = studentTypeObj?.response?.rest?[0].studentTypeID ?? ""
        studentTypeTxtFld.text = studentTypeObj?.response?.rest?[0].studentTypeName ?? ""
    }
    func selClassId() {
        selectClassTxtFld.text = stCircularClObj?.response?.rest?[0].class_name
        classId = stCircularClObj?.response?.rest?[0].class_id ?? ""
        sectionId = stCircularClObj?.response?.rest?[0].section_id ?? ""
    }
    @objc func checkBtnTapped(_ sender:UIButton) {
        var listData = studentListObj?.response?.rest?[sender.tag]
        if let isSelected = listData?.isSelected, isSelected == false {
            listData?.isSelected = true
        } else {
            listData?.isSelected = false
        }
        studentListObj?.response?.rest?[sender.tag] = listData!
        studentEnrollArr.append(listData?.admission_no ?? "")
        print(studentEnrollArr)
        studentCirTblView.reloadData()
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
extension CreateStudentCircularVC: UIDocumentPickerDelegate {
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
            studentCircularImg = UIImage()
            uploadImgView.image = .uploadImg

        } catch {
            // Handle the case where there's an error loading the data from the URL
            print("Error loading data from URL: \(error.localizedDescription)")
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
}
extension CreateStudentCircularVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage ?? info[.editedImage] as? UIImage  {
            uploadImgView.image = img
            studentCircularImg = img
            isImgUpload = true
            PDFData = Data()
            documentAddressLbl.isHidden = true
            
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
extension CreateStudentCircularVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .StudentType:
            selectedStType = data as? StudentTypeListRest
            studentTypeTxtFld.text = selectedStType?.studentTypeName
            selectedTypeId = selectedStType?.studentTypeID ?? ""
            stCircularClassesAPI()
        case .CircularClassesList:
            selectedStCircularClass = data as? StCircularClListRest
            selectClassTxtFld.text = selectedStCircularClass?.class_name
            classId = selectedStCircularClass?.class_id ?? ""
            sectionId = selectedStCircularClass?.section_id ?? ""
            studentEnrollArr.removeAll()
            studentListAPI()
        default :
            return
        }
    }
}
extension CreateStudentCircularVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentListObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let circularCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.studentCircularCell.getIdentifier, for: indexPath) as! StudentCircularTblCell
        circularCell.studentDetailView.clipsToBounds = true
        let studentDetailData = studentListObj?.response?.rest?[indexPath.row]
        circularCell.rollNoLbl.text = studentDetailData?.mobileNo
        circularCell.sectionLbl.text = studentDetailData?.sectionId
        circularCell.classLbl.text = studentDetailData?.classId
        circularCell.admNoLbl.text = studentDetailData?.admission_no
        circularCell.studentNameLbl.text = studentDetailData?.studentName
        circularCell.checkBtnOtl.tag = indexPath.row
        if studentDetailData?.isSelected == false {
            circularCell.checkBtnOtl.setBackgroundImage(.ic_unselectItem, for: .normal)
        } else {
            circularCell.checkBtnOtl.setBackgroundImage(.ic_selectItem, for: .normal)
        }
        circularCell.checkBtnOtl.addTarget(self, action: #selector(checkBtnTapped(_:)), for: .touchUpInside)
        return circularCell
    }
}
extension CreateStudentCircularVC {
    func studentTypeAPI() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Student_Type.getEndPoints).php?"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Student_Type.getEndPoints, apiRequestURL: strUrl)
    }
    func stCircularClassesAPI() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Student_Circular_Classes.getEndPoints).php?StudentTypeID=\(selectedTypeId)&branch_id=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Student_Circular_Classes.getEndPoints, apiRequestURL: strUrl)
    }
    func studentListAPI() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Student_List_For_Circular.getEndPoints).php?branch_id=\(UserDefaults.getUserDetail()?.BranchId ?? "")&session_id=\(UserDefaults.getUserDetail()?.Session ?? "")&student_type_id=\(selectedTypeId)&class_id=\(classId)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Student_List_For_Circular.getEndPoints, apiRequestURL: strUrl)
    }
    func createStCircularApi() {
        let title = titleTxtFld.text ?? ""
        let message = messageTxtView.text ?? ""
        
        let enrollNoId = studentEnrollArr.joined(separator: ",")
        let parameters: [String:String] = ["branch_id":UserDefaults.getUserDetail()?.BranchId ?? "",
                          "session_id":UserDefaults.getUserDetail()?.Session ?? "",
                          "enroll_no":enrollNoId,
                          "class_id":classId,
                          "section_id":sectionId,
                          "circular_date":dateTxtFld.text ?? "",
                          "EmpCode":UserDefaults.getUserDetail()?.EmpCode ?? "",
                          "title": title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "",
                          "description":message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "",
                          "student_type_id":selectedTypeId,
                          "group_type":groupType ?? ""]
        let obj = ApiRequest()
        obj.delegate = self
        print(parameters)
        obj.requestNativeImageUpload(apiName:END_POINTS.Api_Student_Circular.getEndPoints, image: studentCircularImg, pdfData: PDFData, parameters: parameters, isImageUpload: isImgUpload, fileOrPhoto: FileOrPhotoKey.File)//Both Image and PDF uploading.
    }
}
extension CreateStudentCircularVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Student_Type.getEndPoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let studentTypeDictData = Mapper<StudentTypeListModel>().map(JSONObject: response) {
                    studentTypeObj = studentTypeDictData
                    DispatchQueue.main.async {
                        self.selectedType()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Student_Circular_Classes.getEndPoints {
            let status = response["status"] as! Int
            if  status == 1 {
                if let stCircularClassDictData = Mapper<StCircularClListModel>().map(JSONObject: response) {
                    stCircularClObj = stCircularClassDictData
                    DispatchQueue.main.async {
                        self.selClassId()
                        self.studentListAPI()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA, controller: self)
                }
            }
            
        }
        if api == END_POINTS.Api_Student_List_For_Circular.getEndPoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let studentListDictData = Mapper<CircularStudentListModel>().map(JSONObject: response) {
                    studentListObj = studentListDictData
                    DispatchQueue.main.async {
                        self.studentCirTblView.reloadData()
                    }
                }
                
            }
            
        }
        if api == END_POINTS.Api_Student_Circular.getEndPoints {
            
            let status = response["status"] as! Bool
            let msg = response["msg"] as! String
            if status == true {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    CommonObjects.shared.showToast(message: msg)
                    
                }
            } else {
                DispatchQueue.main.async {
                    //self.navigationController?.popViewController(animated: true)
                    CommonObjects.shared.showToast(message: msg)
                    
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

