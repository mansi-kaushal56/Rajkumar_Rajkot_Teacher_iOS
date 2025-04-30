//
//  CircularEmployeeVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 05/09/23.
//

import UIKit
import ObjectMapper
import UniformTypeIdentifiers

class CircularEmployeeVC: UIViewController {

    var employeeCircularListObj: EmployeeCircularListModel?
    
    var teacherListObj: TeacherListModel?
    var selectedTeacherArr = [TeacherListRest]()
    var branchId: String?
    var empCatorgy: String?
    var employeeCircularImg = UIImage()
    var PDFData = Data()
    var isImgUpload = Bool()
    
    @IBOutlet weak var documentAddressLbl: UILabel!
    @IBOutlet weak var uploadImgView : UIImageView!
    @IBOutlet weak var staffViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewCircularTblView: UITableView!
    @IBOutlet weak var viewCircularScreen: UIView!
    
    @IBOutlet weak var chooseStaffTxtView: UITextView!
    @IBOutlet weak var selectBranchTxtFld: UITextField!
    @IBOutlet weak var uploadView: UIView!
    
    @IBOutlet weak var staffView: UIView!
    
    @IBOutlet weak var branchView: UIView!
    @IBOutlet weak var employeeTypeTxtFld: UITextField!
    
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var employeeTypeView: UIView!
    @IBOutlet weak var circularNameTxtFld: UITextField!
    @IBOutlet weak var createCircularSreen: UIView!
    
    @IBOutlet weak var viewCircularLbl: UILabel!
    @IBOutlet weak var viewCircularImg: UIImageView!
    @IBOutlet weak var viewCircularView: UIView!
    @IBOutlet weak var createCircularLbl: UILabel!
    @IBOutlet weak var createCircularImg: UIImageView!
    @IBOutlet weak var createCircularView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Employee Circular")
        circularPages(type: .CreateCircular)
        circularEmployeeListApi()
        tapGestures()
        staffView.isHidden = true
        staffViewHeight.constant = 0
        isImgUpload = true
        documentAddressLbl.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.circularViewSegue.getDescription {
            if let destinationVC = segue.destination as? ViewCircularEmployeeVC {
                destinationVC.selCircularId = employeeCircularListObj?.response?.res?[sender as! Int].id
                destinationVC.circularTitle = employeeCircularListObj?.response?.res?[sender as! Int].title
            }
        }
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
        submitCircularApi()
    }
    @IBAction func uploadImgTapped(_ sender: UITapGestureRecognizer) {
        uploadImageOrPdf()
    }
    func getBranchId(branchName:String) {
        chooseStaffTxtView.text = nil
        selectedTeacherArr.removeAll()
        switch branchName {
        case "Both":
            branchId = ""
        case "HiraNagar":
            branchId = "1"
        case "VikasNagar" :
            branchId = "2"
        default:
            print("Invaild Branch Name")
        }
    }
    func getEmpCatorgy(catorgyName:String) {
        chooseStaffTxtView.text = nil
        selectedTeacherArr.removeAll()
        switch catorgyName {
        case "All":
            empCatorgy = ""
        case "NonTeaching":
            empCatorgy = "NonTeaching"
        case "Teaching" :
            empCatorgy = "Teaching"
        default:
            print("Invalid Catorgy Name")
        }
    }
    func employeeTypeSelection() {
        let groups = ["All", "NonTeaching", "Teaching", "Cancel"]
        showSelectionOptions(title: "Select The Employee Type", options: groups) { [weak self] selectedOption in
            if selectedOption != "Cancel" {
                self?.employeeTypeTxtFld.text = selectedOption
                self?.getEmpCatorgy(catorgyName: selectedOption)
                self?.circularFilterTListApi()
            }
        }
    }
    func schoolGroupSelection() {
        let groups = ["Rajkot", "Cancel"]
        showSelectionOptions(title: "Select a Group", options: groups) { [weak self] selectedOption in
            if selectedOption != "Cancel" {
                self?.selectBranchTxtFld.text = selectedOption
                self?.staffView.isHidden = false
                self?.staffViewHeight.constant = 80
                self?.getBranchId(branchName: selectedOption)
                self?.circularFilterTListApi()
                
            }
        }
    }

    func circularPages(type:ScreenType) {
        switch type {
        case .CreateCircular:
            viewCircularScreen.isHidden = true
            createCircularSreen.isHidden = false
            createCircularView.backgroundColor = UIColor(named: "AllCollectClr")
            createCircularLbl.textColor = .white
            viewCircularLbl.textColor = .black
            viewCircularView.backgroundColor = UIColor.white
            viewCircularImg.image = UIImage(named: "EyeBlkIcon")
            createCircularImg.image = UIImage(named: "createCircularIcon")
        case .ViewCircular:
            viewCircularScreen.isHidden = false
            createCircularSreen.isHidden = true
            createCircularView.backgroundColor = UIColor.white
            createCircularLbl.textColor = .black
            viewCircularLbl.textColor = .white
            viewCircularView.backgroundColor = UIColor(named: "AllCollectClr")
            viewCircularImg.image = UIImage(named: "EyeWhiteIcon")
            createCircularImg.image = UIImage(named: "EmployeeCircular")
        default:
             print("Unknown Type")
        }
    }
    func tapGestures() {
        createCircularView.addTapGestureRecognizer {
            self.circularPages(type: .CreateCircular)
        }
        viewCircularView.addTapGestureRecognizer {
            self.circularPages(type: .ViewCircular)
        }
        employeeTypeView.addTapGestureRecognizer {
            self.employeeTypeSelection()
        }
        branchView.addTapGestureRecognizer {
            self.schoolGroupSelection()
        }
        staffView.addTapGestureRecognizer {
            self.showTeacherList(type: .StaffList)
        }
        chooseStaffTxtView.addTapGestureRecognizer {
            self.showTeacherList(type: .StaffList)
        }
        
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
extension CircularEmployeeVC: UIDocumentPickerDelegate {
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
            employeeCircularImg = UIImage()
            uploadImgView.image = .uploadImg
            
        } catch {
            // Handle the case where there's an error loading the data from the URL
            print("Error loading data from URL: \(error.localizedDescription)")
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
}
extension CircularEmployeeVC : SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .StaffList:
            selectedTeacherArr = data as! [TeacherListRest]
            updateTextViewWithTeacherInfo(teacherArray: selectedTeacherArr, textView: chooseStaffTxtView)
           
        default:
            return
        }
    }
}
extension CircularEmployeeVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage ?? info[.editedImage] as? UIImage {
            uploadImgView.image = img
            employeeCircularImg = img
            isImgUpload = true
            PDFData = Data()
            documentAddressLbl.isHidden = true
        }
//        else if let img = info[.editedImage] as? UIImage {
//            uploadImgView.image = img
//            employeeCircularImg = img
//        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension CircularEmployeeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: AppStrings.AppSegue.circularViewSegue.getDescription, sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeCircularListObj?.response?.res?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let circularCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.circularCell.getIdentifier, for: indexPath) as! CircularEmployeeTblCell
        circularCell.viewCircularListView.clipsToBounds = true
        let employeeCircularData = employeeCircularListObj?.response?.res?[indexPath.row]
        circularCell.circularByLbl.text = employeeCircularData?.by
        circularCell.circularDateLbl.text = employeeCircularData?.created_Date
        circularCell.circularTitleLbl.text = employeeCircularData?.title
        circularCell.sendToLbl.text = employeeCircularData?.count
        switch employeeCircularData?.attachment {
        case "yes":
            circularCell.viewAttachmentView.isHidden = false
        case "no":
            circularCell.viewAttachmentView.isHidden = true
        default:
            print("Unknown Type")
        }
        
        return circularCell
    }

}
extension CircularEmployeeVC {
    func circularEmployeeListApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Send_By_Me_CircularList.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Send_By_Me_CircularList.getEndPoints, apiRequestURL: strUrl)
    }
    func circularFilterTListApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Teacherlist_Filter.getEndPoints).php?BranchId=\(branchId ?? "")&EmpCategory=\(empCatorgy ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Teacherlist_Filter.getEndPoints, apiRequestURL: strUrl)
    }
    func submitCircularApi(){
        var temlistArr = [String]()
        for listaData in selectedTeacherArr {
            temlistArr.append(listaData.empCode ?? "")
        }
        let selTeacherIds = temlistArr.joined(separator: ",")
        let title = circularNameTxtFld.text ?? ""
        if title.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_CIRCULAR_NAME_EMPTY)
            return
        }
        let description = descriptionTxtView.text ?? ""
        if description.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DESCRIPTION_EMPTY)
            return
        }
        
        let parameters = ["EmpCode":UserDefaults.getUserDetail()?.EmpCode ?? "",
                          "title" :title,
                          "staff" :selTeacherIds,
                          "description" :description,
                          "SessionId" :UserDefaults.getUserDetail()?.Session ?? ""]
        print("API Parameters - -\(parameters)")
        let obj = ApiRequest()
        obj.delegate = self
        print(employeeCircularImg)
        print(FileOrPhotoKey.File)
        obj.requestNativeImageUpload(apiName:END_POINTS.Api_Staff_Circular.getEndPoints, image: employeeCircularImg, pdfData: PDFData, parameters: parameters, isImageUpload: isImgUpload, fileOrPhoto: FileOrPhotoKey.File) //Both Image and PDF uploading.
        // both image and pdf upolad
    }
}

extension CircularEmployeeVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Send_By_Me_CircularList.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let employeeCircularListDictData = Mapper<EmployeeCircularListModel>().map(JSONObject: response) {
                    employeeCircularListObj = employeeCircularListDictData
                    DispatchQueue.main.async {
                        self.viewCircularTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Teacherlist_Filter.getEndPoints {
            let status = response["status"] as! String
            
            if status == "SUCCESS" {
                if let teacherListDictData = Mapper<TeacherListModel>().map(JSONObject: response) {
                    teacherListObj = teacherListDictData
                }
            }
        }
        if api == END_POINTS.Api_Staff_Circular.getEndPoints {
            let status = response["status"] as! Bool
            let msg = response["msg"] as! String
            if status == true {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    CommonObjects.shared.showToast(message: AppMessages.MSG_EMPLOYEE_CIRCULAR_SUBMIT)
                }
            } else {
                DispatchQueue.main.async {
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
