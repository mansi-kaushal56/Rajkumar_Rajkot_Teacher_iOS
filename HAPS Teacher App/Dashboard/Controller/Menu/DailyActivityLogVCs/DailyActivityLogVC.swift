//
//  DailyActivityLogVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 23/08/23.
//

import UIKit
import UniformTypeIdentifiers

class DailyActivityLogVC: UIViewController {
    
    @IBOutlet weak var viewActivityLogView: UIView!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var dateTxlFld: UITextField!
    @IBOutlet weak var uploadImgView: UIImageView!
    var PDFData = Data()
    var isImgUpload = Bool()
    var dailyActivityLogImg = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn(title: "Daily Activity Log")
        tapGestures()
        isImgUpload = true
        //self.dateTxlFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker2))
        // Do any additional setup after loading the view.
    }
    @objc func viewActiveLog() {
        performSegue(withIdentifier: AppStrings.AppSegue.viewLogSegue.getDescription, sender: nil)
    }
    func tapGestures() {
        let viewActiveTap = UITapGestureRecognizer()
        viewActivityLogView.addGestureRecognizer(viewActiveTap)
        viewActiveTap.addTarget(self, action: #selector(viewActiveLog))
    
        uploadImgView.addTapGestureRecognizer {
            self.checkCameraPermission()
        }
    }
//    @objc func datePicker2(_ sender:UITapGestureRecognizer){
//        if let datePicker = self.dateTxlFld.inputView as? UIDatePicker {
//
//            //MARK: - Date Format
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM-yyyy"
//            self.dateTxlFld.text = dateFormatter.string(from: datePicker.date)
//        }
//        self.dateTxlFld.resignFirstResponder()
//    }
//    func uploadImageOrPdf() {
//        let alertVc = UIAlertController(title: "Select Image or PDF", message: nil, preferredStyle: .actionSheet)
//        alertVc.addAction(UIAlertAction(title: "Image", style: .default,handler: { [weak self]
//            UIAlertAction in
//            self?.checkCameraPermission()
//        }))
//        alertVc.addAction(UIAlertAction(title: "PDF", style: .default,handler: { [weak self]
//            UIAlertAction in
//            self?.documentPicker()
//        }))
//        alertVc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        present(alertVc, animated: true)
//    }
//    func documentPicker() {
//        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.data])
//        documentPicker.delegate = self
//        documentPicker.allowsMultipleSelection = false
//        present(documentPicker, animated: true, completion: nil)
//    }
    @IBAction func submitLogBtn(_ sender: UIButton) {
        dailyActivityLogApi()
    }
    
}
extension DailyActivityLogVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage {
            uploadImgView.image = img
            dailyActivityLogImg = img
        } else if let img = info[.editedImage] as? UIImage {
            uploadImgView.image = img
            dailyActivityLogImg = img
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
//extension DailyActivityLogVC: UIDocumentPickerDelegate {
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        guard let selectedFileURL = urls.first else {
//            return
//        }
//        print("Selected file URL: \(selectedFileURL)")
//        do {
//            let data = try Data(contentsOf: selectedFileURL)
//            pdfData = data
//            isImgUpload = false
//
//        } catch {
//            // Handle the case where there's an error loading the data from the URL
//            print("Error loading data from URL: \(error.localizedDescription)")
//        }
//    }
//    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//
//    }
//}
extension DailyActivityLogVC {
    func dailyActivityLogApi() {
        let description = descriptionTxtView.text ?? ""
        if description.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DESCRIPTION_EMPTY, controller: self)
            return
        }
        let parameters = ["EmpCode": UserDefaults.getUserDetail()?.EmpCode ?? "",
                          "description" : description,
                          "SessionId" : UserDefaults.getUserDetail()?.Session ?? "",
                          "BranchId" : UserDefaults.getUserDetail()?.BranchId ?? ""]
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName:END_POINTS.Api_Daily_Activity.getEndPoints, image: dailyActivityLogImg, pdfData: PDFData, parameters: parameters, isImageUpload: isImgUpload, fileOrPhoto: FileOrPhotoKey.File) //Only Img uploading.
    }
}
extension DailyActivityLogVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Daily_Activity.getEndPoints {
            let status = response["status"] as? Bool
            let uploadMessage = response["upload_message"] as? String
            if status == true {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_DAL_SUCCESS)
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
