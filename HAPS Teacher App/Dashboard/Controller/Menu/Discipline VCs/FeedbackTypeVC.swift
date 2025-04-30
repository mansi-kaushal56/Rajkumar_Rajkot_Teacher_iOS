//
//  FeedbackTypeVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 11/09/23.
//

import UIKit
import ObjectMapper

class FeedbackTypeVC: UIViewController {
    var sendParameterObj: SendParameterModel?
    var selParameterObj: SendParameterRes?
    var studentListObj : StudentListModel?
    var classListObj: FillClassModel?
    var othersData: String?
    var feedbackType: String?
    var parameterId: String?
    var parameterName: String?
    var selClass: FillClassRes?
    var studentEnrollArr = [String]()
    var classId = ""
    var stEnrollNo = ""
    var selectedIndex: Int = -1

    @IBOutlet weak var addOtherView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var otherParamterTxtFld: UITextField!
    @IBOutlet weak var chooseParameterLbl: UILabel!
    @IBOutlet weak var chooseParameterView: UIView!
    @IBOutlet weak var searchByClassLbl: UILabel!
    @IBOutlet weak var searchByClassView: UIView!
    @IBOutlet weak var searchByNameTxtFld: UITextField!
    @IBOutlet weak var studentListTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Descipline")
        viewTapsGestures()
        sendParameterApi()
        tableViewHeight.constant = 0
        getAllClassApi()
        // Do any additional setup after loading the view.
    }
    @IBAction func resetBtnAction(_ sender: UIButton) {
    }
    @IBAction func searchBtnAction(_ sender: UIButton) {
        studentListApi()
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
        updateDiscipline()
    }
    func viewTapsGestures() {
        chooseParameterView.addTapGestureRecognizer {
            self.sendParameterName(type: .SendParameter)
        }
        searchByClassView.addTapGestureRecognizer {
            self.sendParameterName(type: .GetAllClass)
        }
    }
    
    func sendParameterName(type: ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.listAppearVC.getIdentifier) as! ListAppearVC
        vc.modalPresentationStyle = .overFullScreen
        switch type {
        case .SendParameter:
            vc.senderDelegate = self
            vc.type = .SendParameter
            vc.sendParameterObj = sendParameterObj
        case .GetAllClass:
            vc.senderDelegate = self
            vc.type = .GetAllClass
            vc.clListObj = classListObj
        default :
            return
            
        }
        self.present(vc, animated: true)
    }
//    @objc func checkBtnTapped1(sender:UIButton) {
//        let tappedIndex = sender.tag
//
//           if tappedIndex == selectedIndex {
//               return
//           } else {
//               selectedIndex = tappedIndex
//               stEnrollNo = studentlistObj?.response?.res?[sender.tag].enrollNo ?? ""
//               print(stEnrollNo)
//           }
//        print(selectedIndex)
//        studentListTblView.reloadData()
//
//    }
    @objc func checkBtnTapped(_ sender:UIButton) {
        var listData = studentListObj?.response?.res?[sender.tag]
        
        if let isSelected = listData?.isSelected, isSelected == false {
            listData?.isSelected = true
            studentEnrollArr.append(listData?.enrollNo ?? "")
        } else {
            if let indexToRemove = studentEnrollArr.firstIndex(of: listData?.enrollNo ?? "") {
                studentEnrollArr.remove(at: indexToRemove)
            }
            listData?.isSelected = false
        }
        studentListObj?.response?.res?[sender.tag] = listData!
        studentListTblView.reloadData()
    }
}
extension FeedbackTypeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentListObj?.response?.res?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentListCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.disciplineListCell.getIdentifier, for: indexPath) as! DisciplineStudentListTblCell
        studentListCell.studentDetailView.clipsToBounds = true
        let studentData = studentListObj?.response?.res?[indexPath.row]
        studentListCell.rollNoLbl.text = studentData?.mobileNo
        studentListCell.sectionLbl.text = studentData?.sectionName
        studentListCell.classLbl.text = studentData?.className
        studentListCell.admNoLbl.text = studentData?.enrollNo
        studentListCell.studentNmaeLbl.text = studentData?.studentName
        studentListCell.checkBtnAction.tag = indexPath.row
        //studentListCell.checkBtnAction.setImage(UIImage.unDoneCheckIcon, for: .normal)
       // print(selectedIndex)
//        if indexPath.row == selectedIndex {
//            studentListCell.checkBtnAction.setImage(UIImage.doneCheckIcon, for: .normal)
//        }
//        studentListCell.checkBtnAction.addTarget(self, action: #selector(checkBtnTapped1(sender: )), for: .touchUpInside)
        if studentData?.isSelected == false {
            studentListCell.checkBtnAction.setBackgroundImage(.ic_unselectItem, for: .normal)
        } else {
            studentListCell.checkBtnAction.setBackgroundImage(.ic_selectItem, for: .normal)
        }
        studentListCell.checkBtnAction.addTarget(self, action: #selector(checkBtnTapped(_:)), for: .touchUpInside)
        return studentListCell
    }
}
extension FeedbackTypeVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type  {
        case .SendParameter:
            if data == nil {
                parameterId = "0"
                chooseParameterLbl.text = "Others"
                parameterName = "Others"
                addOtherView.isHidden = false
            } else {
                selParameterObj = data as? SendParameterRes
                chooseParameterLbl.text = selParameterObj?.reasons
                parameterId = selParameterObj?.id
                parameterName = selParameterObj?.reasons
                otherParamterTxtFld.text = nil
                addOtherView.isHidden = true
            }
        case .GetAllClass:
            selClass = data as? FillClassRes
            searchByClassLbl.text = selClass?.className
            classId = selClass?.classId ?? ""
            
        default :
            return
        }
    }
}
extension FeedbackTypeVC {
    func getAllClassApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Get_All_Class.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Get_All_Class.getEndPoints, apiRequestURL: strUrl)
    }
    func sendParameterApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Send_Parameter.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&Type=\(feedbackType ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Send_Parameter.getEndPoints, apiRequestURL: strUrl)
    }
    func studentListApi() {
        let nameAndEnrollNo = searchByNameTxtFld.text ?? ""
//        if nameAndEnrollNo.isEmpty {
//            CommonObjects.shared.showToast(message: AppMessages.MSG_STUDENT_EMPTY, controller: self)
//            return
//        }
        if nameAndEnrollNo != "" {
            classId = ""
        }
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Studentlist.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&ClassId=\(classId)&EnrollNo=\(searchByNameTxtFld.text ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Studentlist.getEndPoints, apiRequestURL: strUrl)
    }
    func updateDiscipline() {
        // arrTempIntimationIds = [String]()
        let otherParamter = otherParamterTxtFld.text ?? ""
        let selStudentEnrollNo = studentEnrollArr.joined(separator: ",")
        print(selStudentEnrollNo)
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Update_Discipline.getEndPoints).php?Parameter=\(parameterName ?? "")&Level=\(parameterId ?? "")&Type=\(feedbackType ?? "")&EnrollNo=\(selStudentEnrollNo)&Session=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&remarks=\(otherParamter)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Update_Discipline.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
extension FeedbackTypeVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Send_Parameter.getEndPoints {
            let status = response["status"] as? String
            if status == "true" {
                if let sendParameterDictData = Mapper<SendParameterModel>().map(JSONObject: response) {
                    sendParameterObj = sendParameterDictData
                    if let others = response["others"] as? String {
                        sendParameterObj?.others = others
                        DispatchQueue.main.async {
                            self.parameterId = "0"
                            self.chooseParameterLbl.text = "Others"
                            self.parameterName = "Others"
                        }
                    }
                    DispatchQueue.main.async {
                        self.studentListTblView.reloadData()
                    }
                }
            }
        }
        if api == END_POINTS.Api_Get_All_Class.getEndPoints {
            let status = response["status"] as! String
            if status == "true" {
                if let classListDictData = Mapper<FillClassModel>().map(JSONObject: response) {
                    classListObj = classListDictData
                    DispatchQueue.main.async {
                        self.searchByClassLbl.text = self.classListObj?.response?.res?[0].className
                        self.classId = self.classListObj?.response?.res?[0].classId ?? ""
                    }
                }
            }
        }
        if api == END_POINTS.Api_Studentlist.getEndPoints {
            let status = response["status"] as! Bool
            if status == true {
                if let studentlistDictData = Mapper<StudentListModel>().map(JSONObject: response) {
                    studentListObj = studentlistDictData
                    DispatchQueue.main.async {
                        if let count = self.studentListObj?.response?.res?.count {
                            if count == 1 || count == 2 {
                                self.tableViewHeight.constant = 180
                            } else {
                                self.tableViewHeight.constant = 500
                            }
                        }
                        self.studentListTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.tableViewHeight.constant = 0
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_STUDENT)
                }
            }
        }
        if api == END_POINTS.Api_Update_Discipline.getEndPoints {
            let status = response["status"] as? Int
            if status == 1 {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    CommonObjects.shared.showToast(message: AppMessages.MSG_FEEDBACK_SUBMIT_SUCCESS)
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
