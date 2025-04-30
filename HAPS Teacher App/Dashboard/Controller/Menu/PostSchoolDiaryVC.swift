//
//  PostSchoolDiaryVC.swift
//  HAPS Teacher App
//
//  Created by Vijay Sharma on 23/10/23.
//

import UIKit

class PostSchoolDiaryVC: UIViewController {
    var postSchDiaryImg = UIImage()
    var PDFData = Data()
    var isImgUpload = Bool()
    

    @IBOutlet weak var dateTxtFld: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var schDiaryImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker))
    }
    
    @IBAction func submitSchoolDiaryBtn(_ sender: UIButton) {
        //postSchoolDiaryApi()
    }
    @IBAction func imgViewTapped(_ sender: UITapGestureRecognizer) {
        checkCameraPermission()
    }
    @objc func datePicker(_ sender:UITapGestureRecognizer){
           if let datePicker = self.dateTxtFld.inputView as? UIDatePicker {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd-MM-yyyy"
               
               self.dateTxtFld.text = dateFormatter.string(from: datePicker.date)
           }
           self.dateTxtFld.resignFirstResponder()
       }
}
extension PostSchoolDiaryVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage ?? info[.editedImage] as? UIImage {
            schDiaryImgView.image = img
            postSchDiaryImg = img
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension PostSchoolDiaryVC {
    
    func postSchoolDiaryApi() {
        let description = descriptionTxtView.text ?? ""
        if description.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DESCRIPTION_EMPTY, controller: self)
            return
        }
        
        let parameters = ["date": dateTxtFld.text ?? "",
                          "description": description,
                          "BranchId": UserDefaults.getUserDetail()?.BranchId ?? "",
                          "SessionId": UserDefaults.getUserDetail()?.Session ?? ""]
       
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName: END_POINTS.Api_School_Dairy_Entry.getEndPoints, image: postSchDiaryImg, pdfData: PDFData, parameters: parameters, isImageUpload: isImgUpload, fileOrPhoto: FileOrPhotoKey.File)
    }
}
extension PostSchoolDiaryVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_School_Dairy_Entry.getEndPoints {
            let status = response["status"] as! String
            if status == "true" {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    CommonObjects.shared.showToast(message: AppMessages.MSG_POST_SCHOOL_DIARY)
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
 
