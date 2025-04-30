//
//  EPTMsprVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 25/08/23.
//

import UIKit
import ObjectMapper

class EPTMsprVC: UIViewController {
    var studentlistObj: StudentListModel?
    var modes = ""
    var stEnrollNo = ""
    var selectedIndex: Int = -1
    
    @IBOutlet weak var areaView: UIView!
    @IBOutlet weak var parentSatView: UIView!
    @IBOutlet weak var talkWithView: UIView!
    @IBOutlet weak var orView: UIView!
    @IBOutlet weak var modileView: UIView!
    
    @IBOutlet weak var talkWithLbl: UILabel!
    @IBOutlet weak var parentSatLbl: UILabel!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var modileNoTxtFld: UITextField!
    @IBOutlet weak var orTextField: UITextField!
    @IBOutlet weak var areaTxtFld: UITextField!
    @IBOutlet weak var searchStudentTxtFld: UITextField!
    @IBOutlet weak var dateTxtFld: UITextField!
    
    @IBOutlet weak var studentListTblView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var offlineBtnOtl: UIButton!
    @IBOutlet weak var onlineModelBtnOtl: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "E-PTM SPR")
        viewRecordBtn()
        self.tableViewHeight.constant = 0
        dateTxtFld.text = convertDateFormatter()
        self.dateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker2))
        tapgestures()
        selModeTapped(sender: 1001)
        orView.isHidden = true
        areaView.isHidden = true
        modileView.isHidden = false
        // Do any additional setup after loading the view.
    }
    @IBAction func modeBtnAction(_ sender: UIButton) {
        selModeTapped(sender: sender.tag)
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        studentListApi()
    }
    @IBAction func submitBtn(_ sender: UIButton) {
        saveEPTMEntey()
    }
    
    func selModeTapped(sender: Int) {
        switch sender {
        case 1001:
            onlineModelBtnOtl.setImage(.selectionIcon, for: .normal)
            offlineBtnOtl.setImage(.unselectionIcon, for: .normal)
            modileView.isHidden = false
            modes = "Online"
        case 1002:
            offlineBtnOtl.setImage(.selectionIcon, for: .normal)
            onlineModelBtnOtl.setImage(.unselectionIcon, for: .normal)
            modileView.isHidden = true
            modes = "Offline"
        default :
            print("Unknown Sender")
        }
    }
    
    func tapgestures() {
        talkWithView.addTapGestureRecognizer {
            self.talkWithSelection()
        }
        parentSatView.addTapGestureRecognizer {
            self.pSATSelection()
        }
        areaView.addTapGestureRecognizer {
            self.areaSelection()
        }
    }
    func viewRecordBtn() {
        let viewRecordButton = UIBarButtonItem(image: UIImage.viewEyeIcon, style: .plain, target: self, action: #selector(ViewRecord))
        navigationItem.rightBarButtonItem = viewRecordButton
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
    
    @objc func ViewRecord() {
        performSegue(withIdentifier: AppStrings.AppSegue.ptmRecordSegue.getDescription, sender: nil)
    }
    func notSatisfiedSeleced() {
        if parentSatLbl.text == "Not Satisfied" {
            areaView.isHidden = false
            orView.isHidden = false
        } else {
            areaView.isHidden = true
            orView.isHidden = true
        }
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
        print(selectedIndex)
        studentListTblView.reloadData()
       
    }
    func talkWithSelection() {
        let talkWiths = ["Mother", "Father", "Both", "Student","Brother", "Sister", "Guardian","Cancel"]
        showSelectionOptions(title: "Talk With", options: talkWiths) { [weak self] selectedOption in
            if selectedOption != "Cancel" {
                 self?.talkWithLbl.text = selectedOption
            }
        }
    }
    func pSATSelection() {
        let pSATs = ["Very Good", "Good", "Not Satisfied","Cancel"]
        showSelectionOptions(title: "Choose...", options: pSATs) { [weak self] selectedOption in
            if selectedOption != "Cancel" {
                self?.parentSatLbl.text = selectedOption
                self?.notSatisfiedSeleced()
            }
        }
    }
    func areaSelection() {
        let areas = ["Teaching", "Infrastructure", "Transport", "Cleanline","Cancel"]
        showSelectionOptions(title:"Select..." , options: areas) { [weak self] selectedOption in
            if selectedOption != "Cancel" {
                 self?.areaTxtFld.text = selectedOption
            }
        }
    }
    
}
extension EPTMsprVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentlistObj?.response?.res?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentListCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.listSearchStudent.getIdentifier, for: indexPath) as! PTMStudenListTblCell
        studentListCell.studentListVuew.clipsToBounds = true
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

extension EPTMsprVC {
    func studentListApi() {
        let nameAndEnrollNo = searchStudentTxtFld.text ?? ""
        if nameAndEnrollNo.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_STUDENT_EMPTY, controller: self)
            return
        }
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Studentlist.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&ClassId=\("")&EnrollNo=\(nameAndEnrollNo)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Studentlist.getEndPoints, apiRequestURL: strUrl)
    }
    func saveEPTMEntey() {
        let mobileNo = modileNoTxtFld.text ?? ""
        if mobileNo.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_MOBILE_NO_EMPTY, controller: self)
            return
        }
        let descripation = descriptionTxtView.text ?? ""
        if descripation.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DESCRIPTION_EMPTY, controller: self)
        }
        
        let area = areaTxtFld.text ?? ""
        let others = orTextField.text ?? ""
        if parentSatLbl.text == "Not Satisfied" {
            if area.isEmpty {
                CommonObjects.shared.showToast(message: AppMessages.MSG_SELECT_AREA, controller: self)
                return
            }
            if others.isEmpty {
                CommonObjects.shared.showToast(message: AppMessages.MSG_OTHER_EMPTY, controller: self)
                return
            }
        }
        
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Insertptm1.getEndPoints).php?date=\(dateTxtFld.text ?? "")&Branch_id=\(UserDefaults.getUserDetail()?.BranchId ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&EnrollNo=\(stEnrollNo)&Mobile=\(mobileNo)&TalkWith=\(talkWithLbl.text ?? "")&description=\(descripation)&mode=\(modes)&psat=\(parentSatLbl.text ?? "")&area=\(area)&others=\(others)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Insertptm1.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
}
extension EPTMsprVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Studentlist.getEndPoints {
            let status = response["status"] as! Bool
            if status == true {
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
        if api == END_POINTS.Api_Insertptm1.getEndPoints {
            let status = response["status"] as? Bool
            if status == true {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:AppMessages.MSG_STUDENT_EPTM_ENTERY)
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
extension EPTMsprVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == modileNoTxtFld {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            newString.rangeOfCharacter(from: CharacterSet.decimalDigits)
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return newString.length <= maxLength && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
