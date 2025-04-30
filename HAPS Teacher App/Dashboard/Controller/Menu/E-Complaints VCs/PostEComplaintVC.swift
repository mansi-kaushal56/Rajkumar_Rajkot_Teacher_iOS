//
//  PostEComplaintVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 13/09/23.
//

import UIKit
import ObjectMapper

class PostEComplaintVC: UIViewController {
    var teacherListObj: TeacherListModel?
    var selectedSendToArr = [TeacherListRest]()

    @IBOutlet weak var sendToTxtView: UITextView!
    @IBOutlet weak var sendToView: UIView!
    @IBOutlet weak var complaintLocationTxtFld: UITextField!
    @IBOutlet weak var dateTxtFld: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "E-Complaint")
        showTeacherApi()
        viewTapsGestures()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
        submitEComplaint()
    }
    func showTeacherList() {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.teachersListvc.getIdentifier) as! TeachersListVC
        vc.modalPresentationStyle = .overFullScreen
        vc.teacherListObj = teacherListObj
        vc.delegate = self
        vc.screenTypes = .StaffList
        self.present(vc, animated: true)
    }
    func viewTapsGestures() {
        sendToTxtView.addTapGestureRecognizer {
            self.showTeacherList()
        }
    }
}
extension PostEComplaintVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        selectedSendToArr = data as! [TeacherListRest]
        updateTextViewWithTeacherInfo(teacherArray: selectedSendToArr, textView: sendToTxtView)
    }
}
extension PostEComplaintVC {
    func showTeacherApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Teachers_List.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Teachers_List.getEndPoints, apiRequestURL: strUrl)
    }
    func submitEComplaint() {
        let locationName = complaintLocationTxtFld.text ?? ""
        if locationName.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_LOCATION_NAME_EMPTY)
            return
        }
        let description = descriptionTxtView.text ?? ""
        if description.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DESCRIPTION_EMPTY)
            return
        }
        var arrTempStaffIds = [String]()
        for staffData in selectedSendToArr {
            arrTempStaffIds.append(staffData.empCode ?? "")
        }
        let selStaffIds = arrTempStaffIds.joined(separator: ",")
        print(selStaffIds)
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Submit_EComplaint.getEndPoints).php?LocationName=\(locationName)&description=\(description)&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&staff=\(selStaffIds)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Submit_EComplaint.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
extension PostEComplaintVC :  RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Teachers_List.getEndPoints {
            let status = response["status"] as? String
            if status == "SUCCESS" {
                if let teacherListDictData = Mapper<TeacherListModel>().map(JSONObject: response) {
                    teacherListObj = teacherListDictData
                    
                }
            }
        }
        if api == END_POINTS.Api_Submit_EComplaint.getEndPoints {
            let status = response["status"] as? String
            if status == "true" {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_E_COMPLAINT_SUCCESS)
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

