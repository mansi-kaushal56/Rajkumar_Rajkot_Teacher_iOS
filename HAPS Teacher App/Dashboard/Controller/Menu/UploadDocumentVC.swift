//
//  UploadDocumentVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 23/08/23.
//

import UIKit
import ObjectMapper
import UniformTypeIdentifiers
import Kingfisher

class UploadDocumentVC: UIViewController {

    var teacherListObj: TeacherListModel?
    var selectedTeacherArr = [TeacherListRest]()
    var documentsByMeObj: DocumentsForMeModel?
    var PDFData = Data()
    var uploadImg = UIImage()
    var isImgUpload = Bool()
    var senderTag = 0
    
    @IBOutlet weak var fileNameLbl: UILabel!
    @IBOutlet weak var uploadImgView: UIImageView!
    @IBOutlet weak var assignToTxtView: UITextView!
    @IBOutlet weak var viewDocImg: UIImageView!
    @IBOutlet weak var uploadDocImg: UIImageView!
    @IBOutlet weak var viewDocLbl: UILabel!
    @IBOutlet weak var uploadDocLbl: UILabel!
    @IBOutlet weak var viewDocumentTblView: UITableView!
    @IBOutlet weak var viewDocumentScreenView: UIView!
    @IBOutlet weak var uploadDocumentScreenView: UIView!
    @IBOutlet weak var assignToView: UIView!
    @IBOutlet weak var fileBtnOtl: UIButton!
    @IBOutlet weak var imageBtnOtl: UIButton!
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var dateTextFld: UITextField!
    @IBOutlet weak var viewDocumentView: UIView!
    @IBOutlet weak var uploadDocumentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Upload Document")
        showTeacherApi()
        uploadAndViewDocument(viewType: .UploadDocument)
        uploadDocByMeAPI()
        self.dateTextFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker2))
        tapGestureRecs()
        imegeorFileSelection(senderTags: 110)
       // fileNameLbl.isHidden = true
        isImgUpload = true
        
        // Do any additional setup after loading the view.
    }
    @IBAction func selectedDocTypeAct(_ sender: UIButton) {
        senderTag = sender.tag
        imegeorFileSelection(senderTags: sender.tag)
    }
    func imegeorFileSelection(senderTags:Int){
        switch senderTags {
        case 120:
            fileBtnOtl.setImage(.selectionIcon, for: .normal)
            imageBtnOtl.setImage(.unselectionIcon, for: .normal)
            senderTag = 120
            uploadImgView.image = .uploadImg
            uploadImg = UIImage()
            isImgUpload = false
            
        case 110:
            fileBtnOtl.setImage(.unselectionIcon, for: .normal)
            imageBtnOtl.setImage(.selectionIcon, for: .normal)
            senderTag = 110
            PDFData = Data()
            fileNameLbl.isHidden = true
            isImgUpload = true
        default:
            return
        }
    }
    @objc func viewPdf(_ sender:UITapGestureRecognizer){
        openWebView(urlString: documentsByMeObj?.response?.rest?[view.tag].extraFile ?? "", viewController: self)
    }
    @objc func viewImg(_ sender:UITapGestureRecognizer) {
        openImage(image: documentsByMeObj?.response?.rest?[sender.view?.tag ?? 0].file ?? "")
    }
    func tapGestureRecs() {
        uploadDocumentView.addTapGestureRecognizer {
            self.uploadAndViewDocument(viewType: .UploadDocument)
        }
        viewDocumentView.addTapGestureRecognizer {
            self.uploadAndViewDocument(viewType: .ViewDocument)
        }
        let assignToTap = UITapGestureRecognizer()
        assignToView.addGestureRecognizer(assignToTap)
        assignToTxtView.addGestureRecognizer(assignToTap)
        assignToTap.addTarget(self, action: #selector(assignToList))
        
        let uploadImgAndDocTap = UITapGestureRecognizer()
        uploadImgView.addGestureRecognizer(uploadImgAndDocTap)
        uploadImgAndDocTap.addTarget(self, action: #selector(uploadImageOrPdf))
    }
    func uploadAndViewDocument(viewType: ViewTypes) {
        switch viewType {
        case .UploadDocument:
            viewDocumentScreenView.isHidden = true
            uploadDocumentScreenView.isHidden = false
            uploadDocumentView.backgroundColor = UIColor(named: "AllCollectClr")
            uploadDocLbl.textColor = .white
            viewDocLbl.textColor = .black
            viewDocumentView.backgroundColor = UIColor.white
            viewDocImg.image = UIImage(named: "EyeBlkIcon")
            uploadDocImg.image = UIImage(named: "UploadIcon")
        case .ViewDocument:
            uploadDocumentScreenView.isHidden = true
            viewDocumentScreenView.isHidden = false
            viewDocumentView.backgroundColor = UIColor(named: "AllCollectClr")
            viewDocLbl.textColor = .white
            uploadDocLbl.textColor = .black
            uploadDocumentView.backgroundColor = UIColor.white
            viewDocImg.image = UIImage(named: "EyeWhiteIcon")
            uploadDocImg.image = UIImage(named: "Document")
        default :
            return
        }
    }
    
    @objc func assignToList() {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.teachersListvc.getIdentifier) as! TeachersListVC
        vc.modalPresentationStyle = .overFullScreen
        vc.teacherListObj = teacherListObj
        vc.delegate = self
        vc.screenTypes = .UploadDocumentVC
        self.present(vc, animated: true)
    }
    @objc func datePicker2(_ sender:UITapGestureRecognizer){
        if let datePicker = self.dateTextFld.inputView as? UIDatePicker {
            
            //MARK: - Date Format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            self.dateTextFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateTextFld.resignFirstResponder()
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
        uploadDocApi()
    }
    @objc func uploadImageOrPdf() {
        print(senderTag)
        switch senderTag {
        case 120:
            documentPicker()
            //checkCameraPermission()
        case 110:
            
            checkCameraPermission()
            default:
            print("Unknows Sender")
        }
//        let alertVc = UIAlertController(title: "Select Image or PDF", message: nil, preferredStyle: .actionSheet)
//        alertVc.addAction(UIAlertAction(title: "Image", style: .default,handler: { [weak self]
//            UIAlertAction in
//            self?.checkCameraPermission()
//        }))
//        alertVc.addAction(UIAlertAction(title: "PDF", style: .default,handler: { [weak self]
//            UIAlertAction in
//            self?.documentPicker()
//        }))
//        present(alertVc, animated: true)
    }
    func documentPicker() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.data])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
}
extension UploadDocumentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentsByMeObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let documentCell = tableView.dequeueReusableCell(withIdentifier:  AppStrings.AppTblVIdentifiers.viewDocumentCell.getIdentifier, for: indexPath) as! UploadDocumentViewTblCell
        documentCell.backgoundView.clipsToBounds = true
        let documentData = documentsByMeObj?.response?.rest?[indexPath.row]
        documentCell.assignedDateLbl.text = documentsByMeObj?.response?.rest?[indexPath.row].date
        documentCell.docTitleLbl.text = documentsByMeObj?.response?.rest?[indexPath.row].title
        documentCell.assignedToLbl.text = documentsByMeObj?.response?.rest?[indexPath.row].sendername
       // documentCell.docImgView.image = documentsByMeObj?.response?.rest?[indexPath.row].file
        
        switch documentData?.fileType {
        case "jpg", "jpeg":
            documentCell.ViewAttachmentView.isHidden = true
            documentCell.imgVView.isHidden = false
            let image = (documentsByMeObj?.response?.rest?[indexPath.row].file) ?? ""
            let imgUrl = URL(string: image)
            documentCell.docImgView.kf.setImage(with: imgUrl)
//        case "jpeg":
//            documentCell.ViewAttachmentView.isHidden = true
//            documentCell.imgVView.isHidden = false
//            let image = (documentsByMeObj?.response?.rest?[indexPath.row].file) ?? ""
//            let imgUrl = URL(string: image)
//            documentCell.docImgView.kf.setImage(with: imgUrl)
        case "pdf":
            documentCell.ViewAttachmentView.isHidden = false
            documentCell.imgVView.isHidden = true
            documentCell.ViewAttachmentView.tag = indexPath.row
            documentCell.ViewAttachmentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewPdf(_:))))
            
        default :
            documentCell.ViewAttachmentView.isHidden = true
            documentCell.imgVView.isHidden = true
        }
        documentCell.docImgView.tag = indexPath.row
        documentCell.docImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewImg(_:))))
        return documentCell
    }
}
extension UploadDocumentVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage ?? info[.editedImage] as? UIImage {
            uploadImgView.image = img
            uploadImg = img
            isImgUpload = true
            PDFData = Data()
            fileNameLbl.isHidden = true

        }
//            else if let img = info[.editedImage] as? UIImage {
//            uploadImgView.image = img
//        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension UploadDocumentVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
                   return
               }
        print("Selected file URL: \(selectedFileURL)")
        fileNameLbl.isHidden = false
        fileNameLbl.text = "Document - \(selectedFileURL.lastPathComponent)"
        do {
            let data = try Data(contentsOf: selectedFileURL)
            PDFData = data
            isImgUpload = false
            uploadImg = UIImage()
            uploadImgView.image = .uploadImg
        } catch {
            // Handle the case where there's an error loading the data from the URL
            print("Error loading data from URL: \(error.localizedDescription)")
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
}

extension UploadDocumentVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        selectedTeacherArr.removeAll()
        assignToTxtView.text = ""
        selectedTeacherArr = data as! [TeacherListRest]
        
        var teacherInfo = ""
        for teacherData in selectedTeacherArr {
            if let empId = teacherData.empCode, let empName = teacherData.empName {
                teacherInfo.append("\(empId). \(empName), ")
            }
        }
        if !teacherInfo.isEmpty {
            teacherInfo.removeLast(2)  // Remove the trailing comma and space
            assignToTxtView.text = teacherInfo
        }
    }
}
extension UploadDocumentVC {
    func showTeacherApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Teachers_List.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Teachers_List.getEndPoints, apiRequestURL: strUrl)
    }
    func uploadDocApi() {
        let date = dateTextFld.text ?? ""
        if date.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DATE_EMPTY, controller: self)
            return
        }
        let title = titleTxtFld.text ?? ""
        if title.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DATE_EMPTY, controller: self)
            return
        }
        var arrTempTeacherIds = [String]()
        for teacherData in selectedTeacherArr {
            print(selectedTeacherArr.count)
            //collageID.append((collegeData.college_id ?? "")+",")
            arrTempTeacherIds.append(teacherData.empCode ?? "")
        }
        let selTeacherIds = arrTempTeacherIds.joined(separator: ",")
        print(selTeacherIds)
        let parameters = ["EmpCode": UserDefaults.getUserDetail()?.EmpCode ?? "",
                          "date" : date ,
                          "title" : title,
                          "SessionId" : UserDefaults.getUserDetail()?.Session ?? "",
                          "BranchId" : UserDefaults.getUserDetail()?.BranchId ?? "",
                          "stafflist" : selTeacherIds]
//CommonObjects.shared.showProgress()
        print("Api Parameters - \(parameters)")
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName:END_POINTS.Api_Upload_Document.getEndPoints , image: uploadImg, pdfData: PDFData, parameters: parameters,isImageUpload: isImgUpload,fileOrPhoto: FileOrPhotoKey.File)// Both Image and PDF uploading.
    }
    func uploadDocByMeAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Upload_By_Me.getEndPoints).php?SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&login_user=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Upload_By_Me.getEndPoints, apiRequestURL: strUrl)
    }
}
extension UploadDocumentVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Teachers_List.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                if let teacherListDictData = Mapper<TeacherListModel>().map(JSONObject: response) {
                    teacherListObj = teacherListDictData
                    
                }
            }
        }
        if api == END_POINTS.Api_Upload_By_Me.getEndPoints {
            let status = response["status"] as! Int
            let message = response["msg"] as! String
            if status == 1 {
                if let documentsForMeDictData = Mapper<DocumentsForMeModel>().map(JSONObject: response) {
                    documentsByMeObj = documentsForMeDictData
                    DispatchQueue.main.async {
                        self.viewDocumentTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Upload_Document.getEndPoints {
            let status = response["status"] as! Bool
            if status == true {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    CommonObjects.shared.showToast(message: AppMessages.MSG_DOCUMENT_UPLOAD_SUCCESS)
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
