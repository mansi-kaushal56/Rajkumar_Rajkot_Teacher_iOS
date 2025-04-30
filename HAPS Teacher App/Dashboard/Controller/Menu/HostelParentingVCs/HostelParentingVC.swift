//
//  HostelParentingVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/08/23.
//

import UIKit
import ObjectMapper

class HostelParentingVC: UIViewController {
    
    var studentlistObj : StudentListModel?
    var stEnrollNo = ""
    var selectedIndex: Int = -1
    

    @IBOutlet weak var studentListTblView: UITableView!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var searchStudentTxtFld: UITextField!
    @IBOutlet weak var dateTxtFld: UITextField!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Hostel Parenting")
        viewRecordBtn()
        self.tableViewHeight.constant = 0
        dateTxtFld.text = convertDateFormatter()
        self.dateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker2))
      
    }
    
    func viewRecordBtn() {
        let viewRecordButton = UIBarButtonItem(image: UIImage.viewEyeIcon, style: .plain, target: self, action: #selector(ViewRecord))
        navigationItem.rightBarButtonItem = viewRecordButton
    }
    
    @objc func ViewRecord() {
        performSegue(withIdentifier: AppStrings.AppSegue.hostelListSegue.getDescription, sender: nil)
    }
    
    @objc func datePicker2(_ sender:UITapGestureRecognizer){
        if let datePicker = self.dateTxtFld.inputView as? UIDatePicker {
            
            //MARK: - Date Format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            self.dateTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateTxtFld.resignFirstResponder()
    }
    @objc func checkBtnTapped(sender:UIButton) {
        let tappedIndex = sender.tag

           if tappedIndex == selectedIndex {
               return
           } else {
               selectedIndex = tappedIndex
               stEnrollNo = studentlistObj?.response?.res?[sender.tag].enrollNo ?? ""
               print(stEnrollNo)
           }
//        print(selectedIndex)
        studentListTblView.reloadData()
       
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        studentListApi()
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
        saveHostelParenting()
    }
}
extension HostelParentingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentlistObj?.response?.res?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentListCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.hostelStudentList.getIdentifier, for: indexPath) as! HostelStudentListTblCell
        studentListCell.studentListView.clipsToBounds = true
        let studentDetailData = studentlistObj?.response?.res?[indexPath.row]
        studentListCell.rollNoLbl.text = studentDetailData?.mobileNo
        studentListCell.sessionLbl.text = studentDetailData?.sectionName
        studentListCell.classLbl.text = studentDetailData?.className
        studentListCell.admissionNoLbl.text = studentDetailData?.enrollNo
        studentListCell.studentNameLbl.text = studentDetailData?.studentName
        studentListCell.checkBtnOtl.tag = indexPath.row
        studentListCell.checkBtnOtl.setImage(UIImage.ic_unselectItem, for: .normal)
        print(selectedIndex)
        if indexPath.row == selectedIndex {
            studentListCell.checkBtnOtl.setImage(UIImage.ic_selectItem, for: .normal)
        }
        studentListCell.checkBtnOtl.addTarget(self, action: #selector(checkBtnTapped(sender: )), for: .touchUpInside)
        return studentListCell
    }
}
extension HostelParentingVC  {
    func studentListApi() {
        let nameAndEnrollNo = searchStudentTxtFld.text ?? ""
        if nameAndEnrollNo.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_ADDRESS_EMPTY, controller: self)
            return
        }
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Studentlist.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&ClassId=\("")&EnrollNo=\(nameAndEnrollNo)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Studentlist.getEndPoints, apiRequestURL: strUrl)
    }
    func saveHostelParenting() {
        let description = descriptionTxtView.text ?? ""
        if description.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DESCRIPTION_EMPTY, controller: self)
            return
        }
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Hostel_Parenting_Remarks.getEndPoints).php?SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&EnrollNo=\(stEnrollNo)&description=\(description)&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Hostel_Parenting_Remarks.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
    }
}
extension HostelParentingVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Studentlist.getEndPoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let studentlistDictData = Mapper<StudentListModel>().map(JSONObject: response) {
                    studentlistObj = studentlistDictData
                    DispatchQueue.main.async {
                        if let count = self.studentlistObj?.response?.res?.count {
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
        if api == END_POINTS.Api_Hostel_Parenting_Remarks.getEndPoints {
            let status = response["status"] as? Bool
            if status == true {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:AppMessages.MSG_HOSTEL_PARENTING_REMARKS)
                    self.navigationController?.popViewController(animated: true)
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
