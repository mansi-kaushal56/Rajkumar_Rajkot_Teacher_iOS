//
//  EditProfileVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 01/08/23.
//

import UIKit
import AVFoundation
import Kingfisher

class EditProfileVC: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mobileNoTxtFld: UITextField!
    @IBOutlet weak var addressTxtView: UITextView!
    @IBOutlet weak var profileImgView: UIImageView!
    
    var PDFData =  Data()
    var profileImage = UIImage()
    var myProfileObj : MyProfileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "My Profile")
        setLblData()
    }
    
    @IBAction func updateBtn(_ sender: UIButton) {
        updateProfileAPI()
    }
    @IBAction func editImgBtn(_ sender: UIButton) {
        checkCameraPermission()
    }
    func setLblData() {
        let img = (myProfileObj?.empImage ?? "")
        let imgUrl = URL(string: img)
        profileImgView.kf.setImage(with: imgUrl)
        nameLbl.text = UserDefaults.getUserDetail()?.name
        mobileNoTxtFld.text = myProfileObj?.mobileno
        addressTxtView.text = myProfileObj?.address
    }

}
extension EditProfileVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage {
            profileImage = img
            profileImgView.image = img
        } else if let img = info[.editedImage] as? UIImage {
            profileImage = img
            profileImgView.image = img
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension EditProfileVC {
    func updateProfileAPI() {
        let mobileNo = mobileNoTxtFld.text ?? ""
        if mobileNo.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_MOBILE_NO_EMPTY, controller: self)
            return
        }
        let address = addressTxtView.text ?? ""
        if mobileNo.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_MOBILE_NO_EMPTY, controller: self)
            return
        }
        let parameters = ["EmpCode": UserDefaults.getUserDetail()?.EmpCode ?? "",
                          "mobileno" : mobileNo,
                          "address" : address,
                          "BranchId" : UserDefaults.getUserDetail()?.BranchId ?? ""]
        CommonObjects.shared.showProgress()
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName:END_POINTS.Api_Update_Profile.getEndPoints , image: profileImage, pdfData: PDFData, parameters: parameters, isImageUpload: true, fileOrPhoto: FileOrPhotoKey.File)
    }
}
extension EditProfileVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Update_Profile.getEndPoints {
            let status = response["status"] as? Bool
            let uploadMessage = response["upload_message"] as? String
            if status == true {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: uploadMessage ?? "")
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
extension EditProfileVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileNoTxtFld {
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

