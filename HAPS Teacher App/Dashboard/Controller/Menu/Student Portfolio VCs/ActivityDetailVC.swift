//
//  ActivityDetailVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 04/09/23.
//

import UIKit
import ObjectMapper

class ActivityDetailVC: UIViewController {
    var activityListObj: ActivityListMobel?
    var actLevelListObj: LevelListModel?
    var selectedActivity: ActivityListRest?
    var selectedLevel: LevelListRest?
    var actStudentSearchObj: StudentSearchModel?
    var stname : String?
    var stEnollno : String?
    var stClassName: String?
    var PDFData = Data()
    var activityImg = UIImage()

    @IBOutlet weak var actUploadImgView: UIImageView!
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var categoryTxtFld: UITextField!
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var yearTxtFld: UITextField!
    @IBOutlet weak var prizeWon: UITextField!
    @IBOutlet weak var levelTxtFld: UITextField!
   
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var activityNameTxtFld: UITextField!
   
    @IBOutlet weak var activityNameView: UIView!
    @IBOutlet weak var addDetailsView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mobileNoLabel: UILabel!
    @IBOutlet weak var fathersNameLabel: UILabel!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var studentDetailView: UIView!
    @IBOutlet weak var studentNameTxtFld: UITextField!
    @IBOutlet weak var admissionNoTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Activity Entry")
        viewRecordBtn()
        self.addDetailsView.clipsToBounds = true
        self.studentDetailView.clipsToBounds = true
        self.studentDetailView.isHidden = true
        tapgestures()
        activitylistAPI()
        levellistApi()
        // Do any additional setup after loading the view.
    }

    @IBAction func submitBtnAction(_ sender: UIButton) {
        saveActivityEntry()
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        searchStudentApi()
    }
    
    func viewRecordBtn() {
        let viewRecordButton = UIBarButtonItem(image: UIImage.viewEyeIcon, style: .plain, target: self, action: #selector(ViewRecord))
        navigationItem.rightBarButtonItem = viewRecordButton
    }
    
    @objc func ViewRecord() {
        performSegue(withIdentifier: AppStrings.AppSegue.activityEntrySegue.getDescription, sender: nil)
    }
    @objc func uploadActvityImg(sender: UITapGestureRecognizer) {
        checkCameraPermission()
    }
    
    func activityandLevelName(listType:ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.listAppearVC.getIdentifier) as! ListAppearVC
        vc.modalPresentationStyle = .overFullScreen
        switch listType {
        case .ActivityList:
            vc.senderDelegate = self
            vc.activityListObj = activityListObj
            vc.type = .ActivityList
        case .LevelList:
            vc.senderDelegate = self
            vc.levelListobj = actLevelListObj
            vc.type = .LevelList
        default :
            print("Unknow List Type")
        }
        present(vc, animated: true)
        
    }
    
    
    func tapgestures() {
        categoryView.addTapGestureRecognizer {
            self.categorySelection()
        }
        activityNameView.addTapGestureRecognizer {
            self.activityandLevelName(listType: .ActivityList)
        }
        levelView.addTapGestureRecognizer {
            self.activityandLevelName(listType: .LevelList)
        }
        let uploadImgTap = UITapGestureRecognizer()
        actUploadImgView.addGestureRecognizer(uploadImgTap)
        uploadImgTap.addTarget(self, action: #selector(uploadActvityImg))
       
    }
    func categorySelection() {
        let ac = UIAlertController.init(title: "Select a Category", message: nil, preferredStyle: .actionSheet)
        let categoryies = ["Participation", "Achievement", "Cancel"]
        
        for category in categoryies {
            let action = UIAlertAction(title: category, style: category == "Cancel" ? .cancel : .default){ [weak self] _ in
                if category != "Cancel" {
                    self?.categoryTxtFld.text = category
                }
            }
            ac.addAction(action)
        }
        present(ac, animated:true)
    }
    func showStudentdetail() {
        studentNameLabel.text = actStudentSearchObj?.name
        classLabel.text = actStudentSearchObj?.className
        fathersNameLabel.text = actStudentSearchObj?.fatherName
        mobileNoLabel.text = actStudentSearchObj?.mobileNo
        addressLabel.text = actStudentSearchObj?.address
        stname = actStudentSearchObj?.name
        stEnollno = actStudentSearchObj?.enrollNo
        stClassName = actStudentSearchObj?.className
    }
}
extension ActivityDetailVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage {
            activityImg = img
            actUploadImgView.image = img
        } else if let img = info[.editedImage] as? UIImage {
            activityImg = img
            actUploadImgView.image = img
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension ActivityDetailVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .ActivityList:
            selectedActivity = data as? ActivityListRest
            activityNameTxtFld.text = selectedActivity?.activity
        case .LevelList:
            selectedLevel = data as? LevelListRest
            levelTxtFld.text = selectedLevel?.levelName
        default:
            print("Unknown List")
        }
    }
}
extension ActivityDetailVC {
    func searchStudentApi() {
        let studentName = studentNameTxtFld.text ?? ""
        let studentAdmNo = admissionNoTxtFld.text ?? ""
        if studentName.isEmpty && studentAdmNo.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_STUDENT_EMPTY, controller: self)
        }
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Student_Search.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&adminno=\(studentAdmNo)&name=\(studentName)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Student_Search.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    func activitylistAPI() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Activity_List.getEndPoints).php?"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Activity_List.getEndPoints, apiRequestURL: strUrl)
    }
    func levellistApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Get_Level_List.getEndPoints).php?"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Get_Level_List.getEndPoints, apiRequestURL: strUrl)
    }
    func saveActivityEntry() {
        let year = yearTxtFld.text ?? ""
        if year.isEmpty {
            CommonObjects.shared.showToast(message:AppMessages.MSG_YEAR_EMPTY)
            return
        }
        let description = descriptionTxtView.text ?? ""
        if description.isEmpty {
            CommonObjects.shared.showToast(message:AppMessages.MSG_DESCRIPTION_EMPTY)
            return
        }
        let prizeWon = prizeWon.text ?? ""
        if prizeWon.isEmpty {
            CommonObjects.shared.showToast(message:AppMessages.MSG_PRIZE_WON_EMPTY)
            return
        }
        let parameters:[String:String] = ["Enollno": stEnollno ?? "",
                                          "stname": stname ?? "",
                                          "classname": stClassName ?? "",
                                          "BranchId": UserDefaults.getUserDetail()?.BranchId ?? "",
                                          "SessionId": UserDefaults.getUserDetail()?.Session ?? "",
                                          "Activity": selectedActivity?.id ?? "",
                                          "Year": year,
                                          "Level": selectedLevel?.id ?? "",
                                          "PrizeWon": prizeWon,
                                          "des": description,
                                          "category": categoryTxtFld.text ?? "",
                                          "empcode": UserDefaults.getUserDetail()?.EmpCode ?? ""]
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName: END_POINTS.Api_Save_Activity_Entry.getEndPoints, image: activityImg, pdfData:PDFData , parameters: parameters, isImageUpload: true, fileOrPhoto: FileOrPhotoKey.File) // only image uploading
    }
}
extension ActivityDetailVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Activity_List.getEndPoints {
            let status = response["status"] as! String
            if status == "true" {
                if let  activityListDictData = Mapper<ActivityListMobel>().map(JSONObject: response) {
                    activityListObj =  activityListDictData
                }
            }
        }
        if api == END_POINTS.Api_Get_Level_List.getEndPoints {
            let status = response["status"] as? String
            if status == "true" {
                if let levelListDictData = Mapper<LevelListModel>().map(JSONObject: response) {
                    actLevelListObj =  levelListDictData
                }
            }
        }
        if api == END_POINTS.Api_Student_Search.getEndPoints {
            let status = response["status"] as? String
            if status == "true" {
                if let studentDetailDictData = Mapper<StudentSearchModel>().map(JSONObject: response) {
                    actStudentSearchObj = studentDetailDictData
                    DispatchQueue.main.async {
                        self.studentDetailView.isHidden = false
                        self.showStudentdetail()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_STUDENT)
                }
            }
            
        }
        if api == END_POINTS.Api_Save_Activity_Entry.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:AppMessages.MSG_STUDENT_ACTIVITY_ENTERY)
                    self.navigationController?.popViewController(animated: true)
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
