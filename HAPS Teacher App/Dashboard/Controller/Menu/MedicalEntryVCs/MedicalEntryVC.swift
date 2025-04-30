//
//  MedicalEntryVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 11/09/23.
//

import UIKit
import ObjectMapper
import UniformTypeIdentifiers
struct MedicalEntryDetail {
    var addedDates = "" //dateTxtFld
    var addedMedicine = "" // prescriptionTxtFld
    var addedDays = "" // daysTxtFld
    var addedDose = "" //doseTxtFld
    var addedDoseQty = "" //doseQtyTxtFld
    var addedRate = "" //rateTxtFld
}

class MedicalEntryVC: UIViewController, UIDocumentPickerDelegate {
    var studentSearchObj : StudentSearchModel?
    var medicalEntryObj : MedicalEntryModel?
    var stname: String?
    var stEnollno: String?
    var stClassName: String?
    var pdfData = Data()
    let dateFormatter = DateFormatter()
    let currentDate = Date()
    var admittedInHospital = ""
    var medicalListObj : [MedicalEntryDetail] = []
    
    @IBOutlet weak var tblHeadView: UIView!
    @IBOutlet weak var studentMedicalListView: UIView!
    @IBOutlet weak var studentCheckupDetailView: UIView!
    @IBOutlet weak var dateToView: UIView!
    @IBOutlet weak var dateFromView: UIView!
    @IBOutlet weak var studentDetailView: UIView!
    @IBOutlet weak var searchByAdmNoView: UIView!
    @IBOutlet weak var uploadDocView: UIView!
    @IBOutlet weak var doseView: UIView!
    
    @IBOutlet weak var medicalListTblHeight: NSLayoutConstraint!
    @IBOutlet weak var submitBtnOtl: UIButton!
    
    @IBOutlet weak var doseTxtFld: UITextField!
    @IBOutlet weak var searchByAdmNoTxtFld: UITextField!
    
    //    @IBOutlet weak var enterDateTxtFld: UITextField!
    @IBOutlet weak var doseQtyTxtFld: UITextField!
    @IBOutlet weak var daysTxtFld: UITextField!
    @IBOutlet weak var prescriptionTxtFld: UITextField!
    @IBOutlet weak var diagnosisTxtFlf: UITextField!
    @IBOutlet weak var bpTxtFld: UITextField!
    @IBOutlet weak var temperatureTxtFld: UITextField!
    @IBOutlet weak var dateTxtFld: UITextField!
    @IBOutlet weak var rateTxtFld: UITextField!
    @IBOutlet weak var medicalAllergiesTxtFld: UITextField!
    @IBOutlet weak var dateToTxtFld: UITextField!
    @IBOutlet weak var dateFromTxtFld: UITextField!
    @IBOutlet weak var searchByNameTxtFld: UITextField!
    
    @IBOutlet weak var studentAddressLbl: UILabel!
    @IBOutlet weak var studentMobNoLbl: UILabel!
    @IBOutlet weak var studentfNameLbl: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var studentClassLbl: UILabel!
    
    @IBOutlet weak var medicalListStackView: UIStackView!
    @IBOutlet weak var hospitalCheckBtnOtl: UIButton!
    @IBOutlet weak var medicalHistoryTxtView: UITextView!
    @IBOutlet weak var medicalDetailTblView: UITableView!
    @IBOutlet weak var uploadImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Medical Entry")
        viewRecordBtn()
        hidesViews()
        setdatePickerAsInputView()
        tapgestures()
        self.hospitalCheckBtnOtl.setImage(UIImage(named: "RectangleImgIcon"), for: .normal)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        admittedInHospital = "No"
        
        
        // Do any additional setup after loading the view.
    }
    func tapgestures() {
        doseView.addTapGestureRecognizer {
            self.doseListSelection()
        }
        uploadImageView.addTapGestureRecognizer {
            self.uploadImageOrPdf()
        }
    }
    func hidesViews() {
        dateFromView.isHidden = true
        dateToView.isHidden = true
        studentMedicalListView.isHidden = true
        studentDetailView.isHidden = true
        studentDetailView.clipsToBounds = true
        studentCheckupDetailView.clipsToBounds = true
        studentMedicalListView.isHidden = true
    }
    func setdatePickerAsInputView() {
        self.dateToTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker2))
        self.dateFromTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker3))
        self.dateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker4))
    }
    func doseListSelection() {
        let doseList = ["BD", "TDS", "AD", "OD","Cancel"]
        showSelectionOptions(title: "Dose", options: doseList) { [weak self] selectedOption in
            if selectedOption != "Cancel" {
                self?.doseTxtFld.text = selectedOption
            }
        }
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
    func showStudentdetail() {
        studentNameLbl.text = studentSearchObj?.name
        studentClassLbl.text = studentSearchObj?.className
        studentfNameLbl.text = studentSearchObj?.fatherName
        studentMobNoLbl.text = studentSearchObj?.mobileNo
        studentAddressLbl.text = studentSearchObj?.address
        stname = studentSearchObj?.name
        stEnollno = studentSearchObj?.enrollNo
        stClassName = studentSearchObj?.className
    }
    @IBAction func hospitalCheckBtnAction(_ sender: UIButton) {
        if dateFromView.isHidden{
            dateFromView.isHidden = false
            dateToView.isHidden = false
            hospitalCheckBtnOtl.setImage(UIImage(named: "checkboxIcon"), for: .normal)
            admittedInHospital = "Yes"
        } else{
            dateFromView.isHidden = true
            dateToView.isHidden = true
            hospitalCheckBtnOtl.setImage(UIImage(named: "RectangleImgIcon"), for: .normal)
            admittedInHospital = "No"
        }
    }
    @IBAction func addPrescriptionBtnAction(_ sender: UIButton) {
        studentMedicalListView.isHidden = false
        let days = daysTxtFld.text ?? ""
        if days.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DAYS_EMPTY, controller: self)
            return
        }
        let dose = doseTxtFld.text ?? ""
        if dose.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DOSE_EMPTY, controller: self)
            return
        }
        let rate = rateTxtFld.text ?? ""
        if rate.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_RATE_EMPTY, controller: self)
            return
        }
        let doseqty = doseQtyTxtFld.text ?? ""
        if doseqty.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DOSE_QTY_EMPTY, controller: self)
            return
        }
        let date = dateTxtFld.text ?? ""
        if date.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_STUDENT_EMPTY, controller: self)
            return
        }
        let prescription = prescriptionTxtFld.text ?? ""
        if prescription.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_PRESCRIPTION_EMPTY, controller: self)
            return
        }
        let medicalEntryDetailData = MedicalEntryDetail(addedDates: date,addedMedicine: prescription, addedDays: days,addedDose: dose,addedDoseQty: doseqty, addedRate: rate)
        medicalListObj.append(medicalEntryDetailData)
                // Clear the text fields
        daysTxtFld.text = ""
        doseTxtFld.text = ""
        rateTxtFld.text = ""
        doseQtyTxtFld.text = ""
        dateTxtFld.text = ""
        prescriptionTxtFld.text = ""
        medicalDetailTblView.reloadData()
    }
    @IBAction func searchBtnAction(_ sender: UIButton) {
        searchStudentApi()
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
        medicalEntryApi()
    }
    @objc func actionBtnTap(_ sender: UIButton) {
        print("Tapped")
    }
    func viewRecordBtn() {
        let viewRecordButton = UIBarButtonItem(image: UIImage.viewEyeIcon, style: .plain, target: self, action: #selector(ViewRecord))
        navigationItem.rightBarButtonItem = viewRecordButton
    }
    @objc func datePicker2(_ sender:UITapGestureRecognizer){
        if let datePicker = self.dateToTxtFld.inputView as? UIDatePicker {
            self.dateToTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateToTxtFld.resignFirstResponder()
    }
    @objc func datePicker3(_ sender:UITapGestureRecognizer){
        if let datePicker = self.dateFromTxtFld.inputView as? UIDatePicker {
            self.dateFromTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateFromTxtFld.resignFirstResponder()
    }
    @objc func datePicker4(_ sender:UITapGestureRecognizer){
        if let datePicker = self.dateTxtFld.inputView as? UIDatePicker {
            self.dateTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateTxtFld.resignFirstResponder()
    }
    @objc func ViewRecord() {
        performSegue(withIdentifier: AppStrings.AppSegue.medicalListSegue.getDescription, sender: nil)
    }
}
extension MedicalEntryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicalListObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let medicalDetailCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.medicalHistoryCell.getIdentifier, for: indexPath) as! MedicalHistoryTblCell
        medicalDetailCell.dateLbl.text = medicalListObj[indexPath.row].addedDates
        medicalDetailCell.doseLbl.text = medicalListObj[indexPath.row].addedDose
        medicalDetailCell.daysLbl.text = medicalListObj[indexPath.row].addedDays
        medicalDetailCell.medicineLbl.text = medicalListObj[indexPath.row].addedMedicine
        medicalDetailCell.rateLbl.text = medicalListObj[indexPath.row].addedRate
        medicalDetailCell.doseQtyLbl.text = medicalListObj[indexPath.row].addedDoseQty
        
        return medicalDetailCell
    }
}
extension MedicalEntryVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage {
            uploadImageView.image = img
        } else if let img = info[.editedImage] as? UIImage {
            uploadImageView.image = img
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension MedicalEntryVC {
    func searchStudentApi() {
        let searchByAdmissionNo = searchByAdmNoTxtFld.text ?? ""
        let searchByName = searchByNameTxtFld.text ?? ""
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Student_Search.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&adminno=\(searchByAdmissionNo)&name=\(searchByName)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Student_Search.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    func medicalEntryApi() {
        let formattedDate = dateFormatter.string(from: currentDate)
        let addedDates = medicalListObj.map { $0.addedDates }.joined(separator: ",")
        let addedDays = medicalListObj.map { $0.addedDays }.joined(separator: ",")
        let addedDoses = medicalListObj.map { $0.addedDose }.joined(separator: ",")
        let addedRates = medicalListObj.map { $0.addedRate }.joined(separator: ",")
        let addedMedicines = medicalListObj.map { $0.addedMedicine }.joined(separator: ",")
        let addedDoseQty = medicalListObj.map {$0.addedDoseQty }.joined(separator: ",")
        
        let allergies = medicalAllergiesTxtFld.text ?? ""
        if allergies.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_MEDICAL_ALLERGIES_EMPTY, controller: self)
            return
        }
        let medicalHistory = medicalHistoryTxtView.text ?? ""
        if medicalHistory.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_MEDICAL_HISTORY_EMPTY, controller: self)
            return
        }
        let hospitaldatefrom = dateFromTxtFld.text ?? ""
        let hospitaldateto = dateToTxtFld.text ?? ""
        if admittedInHospital == "Yes" {
            if hospitaldatefrom.isEmpty {
                CommonObjects.shared.showToast(message: AppMessages.MSG_DATE_EMPTY, controller: self)
                return
            }
            if hospitaldateto.isEmpty {
                CommonObjects.shared.showToast(message: AppMessages.MSG_DATE_EMPTY, controller: self)
                return
            }
        }
        let temperature = temperatureTxtFld.text ?? ""
        if temperature.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_TEMP_EMPTY, controller: self)
            return
        }
        let bp = bpTxtFld.text ?? ""
        if bp.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_BP_EMPTY, controller: self)
            return
        }
        let diagnosis = diagnosisTxtFlf.text ?? ""
        if diagnosis.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DIAGNOSIS_EMPTY, controller: self)
            return
        }
        //        let days = daysTxtFld.text ?? ""
        //        if days.isEmpty {
        //            CommonObjects.shared.showToast(messege: AppMessages.MSG_DAYS_EMPTY, controller: self)
        //            return
        //        }
        //        let dose = doseTxtFld.text ?? ""
        //        if dose.isEmpty {
        //            CommonObjects.shared.showToast(messege: AppMessages.MSG_DOSE_EMPTY, controller: self)
        //            return
        //        }
        //        let rate = rateTxtFld.text ?? ""
        //        if rate.isEmpty {
        //            CommonObjects.shared.showToast(messege: AppMessages.MSG_RATE_EMPTY, controller: self)
        //            return
        //        }
        //        let doseqty = doseQtyTxtFld.text ?? ""
        //        if doseqty.isEmpty {
        //            CommonObjects.shared.showToast(messege: AppMessages.MSG_DOSE_QTY_EMPTY, controller: self)
        //            return
        //        }
        //        let date = dateTxtFld.text ?? ""
        //        if date.isEmpty {
        //            CommonObjects.shared.showToast(messege: AppMessages.MSG_STUDENT_EMPTY, controller: self)
        //            return
        //        }
        //        let prescription = prescriptionTxtFld.text ?? ""
        //        if prescription.isEmpty {
        //            CommonObjects.shared.showToast(messege: AppMessages.MSG_PRESCRIPTION_EMPTY, controller: self)
        //            return
        //        }
        
        
        
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Medical_Entries.getEndPoints).php?adminno=\(stEnollno ?? "")&allergies=\(allergies)&medicalHistory=\(medicalHistory)&hospitaldatefrom=\(hospitaldatefrom)&hospitaldateto=\(hospitaldateto)&temperature=\(temperature)&bp=\(bp)&diagnosis=\(diagnosis)&admittedinhospital=\(admittedInHospital)&adate=\(addedDates)&medicine=\(addedMedicines)&days=\(addedDays)&dose=\(addedDoses)&rate=\(addedRates)&doseqty=\(addedDoseQty)&empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&sessionid=\(UserDefaults.getUserDetail()?.Session ?? "")&date=\(formattedDate)"
        print(strUrl)
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Medical_Entries.getEndPoints, apiRequestURL: strUrl)
    }
}

extension MedicalEntryVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Student_Search.getEndPoints {
            let status = response["status"] as! String
            if status == "true" {
                if let studentlistDictData = Mapper<StudentSearchModel>().map(JSONObject: response) {
                    studentSearchObj = studentlistDictData
                    DispatchQueue.main.async {
                        self.studentDetailView.isHidden = false
                        self.showStudentdetail()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.studentDetailView.isHidden = true
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_STUDENT)
                }
            }
        }
        if api == END_POINTS.Api_Medical_Entries.getEndPoints {
            let status = response["status"] as! String
            if status == "true" {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:AppMessages.MSG_MEDICAL_SUCCESS)
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

