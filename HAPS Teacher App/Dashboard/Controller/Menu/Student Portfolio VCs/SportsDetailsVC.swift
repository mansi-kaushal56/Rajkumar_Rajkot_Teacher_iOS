//
//  SportsDetailsVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 04/09/23.
//

import UIKit
import ObjectMapper

class SportsDetailsVC: UIViewController {
    
    var studentSearchObj: StudentSearchModel?
    var listTypes: ScreenType?
    var sportsListObj: SportsListMobel?
    var levelListObj: LevelListModel?
    var selectedSport: SportsListRest?
    var selectedLevel: LevelListRest?
    var stname: String?
    var stEnollno: String?
    var stClassName: String?
    var PDFData = Data()
    var sportsEntryImage  = UIImage()
    
    @IBOutlet weak var uploadImgView: UIImageView!
    @IBOutlet weak var studentDetailViewHeight: NSLayoutConstraint!
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var awardTxtFld: UITextField!
    @IBOutlet weak var yearTxtFld: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var sportsNameLbl: UILabel!
    @IBOutlet weak var sportsNameView: UIView!
    @IBOutlet weak var addDetailView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var studentDetailView: UIView!
    @IBOutlet weak var mobileNoLbl: UILabel!
    @IBOutlet weak var fatherNameLabel: UILabel!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var studentNmaeTxtFld: UITextField!
    @IBOutlet weak var admissionNoTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Sports Entry")
        viewRecordBtn()
        sportslistApi()
        levellistApi()
        self.addDetailView.clipsToBounds = true
        self.studentDetailView.clipsToBounds = true
        studentDetailView.isHidden = true
        tapGestures()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func searchBtnAction(_ sender: UIButton) {
        searchStudentApi()
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
        saveSportsEntryApi()
    }
    @objc func uploadImg(sender:UITapGestureRecognizer) {
        checkCameraPermission()
    }
    func viewRecordBtn() {
        let viewRecordButton = UIBarButtonItem(image: UIImage.viewEyeIcon, style: .plain, target: self, action: #selector(ViewRecord))
        navigationItem.rightBarButtonItem = viewRecordButton
    }
    
    @objc func ViewRecord() {
        performSegue(withIdentifier: AppStrings.AppSegue.sportsEntrySegue.getDescription, sender: nil)
    }
    
    func sportsName(type:ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.listAppearVC.getIdentifier) as! ListAppearVC
        vc.modalPresentationStyle = .popover
        switch type {
        case .SportsList:
            vc.senderDelegate = self
            vc.sportslistobj = sportsListObj
            vc.type = .SportsList
        case .LevelList:
            vc.senderDelegate = self
            vc.levelListobj = levelListObj
            vc.type = .LevelList
            
        default:
            print("Unkown List Type")
        }
        self.present(vc, animated: true)
    }

    func tapGestures() {
        sportsNameView.addTapGestureRecognizer {
            self.sportsName(type: .SportsList)
        }
        levelView.addTapGestureRecognizer {
            self.sportsName(type: .LevelList)
        }
        categoryView.addTapGestureRecognizer {
            self.categorySelection()
        }
        let uploadImgTap = UITapGestureRecognizer()
        uploadImgView.addGestureRecognizer(uploadImgTap)
        uploadImgTap.addTarget(self, action: #selector(uploadImg))
//        uploadImgView.addTapGestureRecognizer {
//            self.checkCameraPermission()
//        }
    }
    
    func categorySelection() {
        let categoryies = ["Participation", "Achievement", "Cancel"]
        showSelectionOptions(title: "Select a Category", options: categoryies) { [weak self] selectedOption in
            if selectedOption != "Cancel" {
                self?.categoryLabel.text = selectedOption
            }
        }
//        let ac = UIAlertController.init(title: "Select a Category", message: nil, preferredStyle: .actionSheet)
//        let categoryies = ["Participation", "Achievement", "Cancel"]
//
//        for category in categoryies {
//            let action = UIAlertAction(title: category, style: category == "Cancel" ? .cancel : .default){ [weak self] _ in
//                if category != "Cancel" {
//                    self?.categoryLabel.text = category
//                }
//            }
//            ac.addAction(action)
//        }
//        present(ac, animated:true)
    }
    func showStudentdetail() {
        studentNameLabel.text = studentSearchObj?.name
        classLabel.text = studentSearchObj?.className
        fatherNameLabel.text = studentSearchObj?.fatherName
        mobileNoLbl.text = studentSearchObj?.mobileNo
        addressLabel.text = studentSearchObj?.address
        stname = studentSearchObj?.name
        stEnollno = studentSearchObj?.enrollNo
        stClassName = studentSearchObj?.className
    }
}
extension SportsDetailsVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage {
            sportsEntryImage = img
            uploadImgView.image = img
        } else if let img = info[.editedImage] as? UIImage {
            sportsEntryImage = img
            uploadImgView.image = img
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension SportsDetailsVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .SportsList:
            selectedSport = data as? SportsListRest
            sportsNameLbl.text = selectedSport?.sportsName
        case .LevelList:
            selectedLevel = data as? LevelListRest
            levelLabel.text = selectedLevel?.levelName
        default:
            return
        }
    }
}
extension SportsDetailsVC {
    func searchStudentApi() {
        let studentName = studentNmaeTxtFld.text ?? ""
        let studentAdmNo = admissionNoTxtFld.text ?? ""
        if studentName.isEmpty && studentAdmNo.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_STUDENT_EMPTY, controller: self)
        }
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Student_Search.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&adminno=\(studentAdmNo)&name=\(studentName)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Student_Search.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    func sportslistApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Student_Get_Sportslist.getEndPoints).php?"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Student_Get_Sportslist.getEndPoints, apiRequestURL: strUrl)
    }
    func levellistApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Get_Level_List.getEndPoints).php?"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Get_Level_List.getEndPoints, apiRequestURL: strUrl)
    }
    func saveSportsEntryApi() {
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
        let awardWon = awardTxtFld.text ?? ""
        if awardWon.isEmpty {
            CommonObjects.shared.showToast(message:AppMessages.MSG_PRIZE_WON_EMPTY)
            return
        }
        //Date:: 22, Apr 2024 - change Enollno to Enrollno
        let parameters:[String:String] = ["Enrollno": stEnollno ?? "",
                                          "stname": stname ?? "",
                                          "classname": stClassName ?? "",
                                          "BranchId": UserDefaults.getUserDetail()?.BranchId ?? "",
                                          "SessionId": UserDefaults.getUserDetail()?.Session ?? "",
                                          "SportsId": selectedSport?.id ?? "",
                                          "Year": year,
                                          "Level": selectedLevel?.id ?? "",
                                          "PrizeWon": awardWon,
                                          "des": description,
                                          "category": categoryLabel.text ?? "",
                                          "empcode": UserDefaults.getUserDetail()?.EmpCode ?? ""]
        //let strUrl = "\(BASE_URL)\(END_POINTS.Api_Save_Sports_Entry.getEndPoints).php?"
        print("API Parameters -- \(parameters)")
        let obj = ApiRequest()
        obj.delegate = self
        //obj.requestAPI(apiName: END_POINTS.Api_Save_Sports_Entry.getEndPoints, apiRequestURL: strUrl)
        obj.requestNativeImageUpload(apiName: END_POINTS.Api_Save_Sports_Entry.getEndPoints, image:sportsEntryImage, pdfData:PDFData , parameters: parameters, isImageUpload: true, fileOrPhoto: FileOrPhotoKey.File) // only image uploading
    }
}
extension SportsDetailsVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Save_Sports_Entry.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:AppMessages.MSG_SUDENT_SPORTS_ENTRY)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        if api == END_POINTS.Api_Student_Search.getEndPoints {
            let status = response["status"] as? String
            if status == "true" {
                if let studentDetailDictData = Mapper<StudentSearchModel>().map(JSONObject: response) {
                    studentSearchObj = studentDetailDictData
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
        if api == END_POINTS.Api_Student_Get_Sportslist.getEndPoints {
            let status = response["status"] as? String
            if status == "true" {
                if let sportsListDictData = Mapper<SportsListMobel>().map(JSONObject: response) {
                    sportsListObj =  sportsListDictData
                }
            }
        }
        if api == END_POINTS.Api_Get_Level_List.getEndPoints {
            let status = response["status"] as? String
            if status == "true" {
                if let levelListDictData = Mapper<LevelListModel>().map(JSONObject: response) {
                    levelListObj =  levelListDictData
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
