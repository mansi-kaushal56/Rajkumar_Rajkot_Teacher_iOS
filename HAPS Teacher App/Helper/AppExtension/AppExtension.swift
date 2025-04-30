//
//  AppExtension.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 28/07/23.
//

import Foundation
import UIKit
import SideMenu
import AVFoundation

extension UIViewController: UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    func backBtn(title : String) {
        let backButton = UIButton()
        backButton.setImage(UIImage.backBtn, for: .normal)
        
        backButton.addTarget(self, action: #selector(backBtnTab), for: .touchUpInside)
        
        let titleBtn = UIButton()
        titleBtn.titleLabel?.font = UIFont(name: AppFonts.Roboto_Medium, size: 16)
        titleBtn.setTitle(title, for:  .normal)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton),UIBarButtonItem(customView: titleBtn)]
    }
    @objc func backBtnTab(_ sender:UIBarButtonItem) {
        if navigationController?.viewControllers.count == 1{
        dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
            
        }
    }
    func menuBarBtn(){
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.menuBarvc.getIdentifier) as! MenuBarVC
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        menu.menuWidth = UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.3)
        menu.statusBarEndAlpha = 1
        menu.presentationStyle = .menuSlideIn
        menu.presentingViewControllerUserInteractionEnabled = false
        menu.presentationStyle.presentingEndAlpha = 0.5
        self.present(menu, animated: true)
    }
    
    func logOutBtn(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: {(UIAlertAction) in
            UserDefaults.removeAppData()
            self.openStoryboard()
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel))
        self.present(alert, animated: true)
    }
    func openStoryboard() {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.main.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.loginVC.getIdentifier) as! LogInVC
        self.present(vc, animated: true)
    }
    func openImage(image : String) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let imagevc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.viewImagevc.getIdentifier) as! ViewImageVC
        imagevc.image = image
        self.present(imagevc, animated: true)
    }
    func showAlert(title : String, message : String) {
        let alertController = UIAlertController(title: title,message:message,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func openWebView(urlString: String, viewController: UIViewController) {
        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""), UIApplication.shared.canOpenURL(url) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                CommonObjects.shared.showToast(message: "Unable to open URL", controller: viewController)
            }
        }
    }
    func emptySetMessage(str:String) -> NSAttributedString { //DZEmptyDataSet Title function
        //let str = "No Data Available!"
        let str = str
        let attStr = [NSAttributedString.Key.foregroundColor : UIColor.AppDarkGrey]
        let attributedStr = NSAttributedString(string: str,attributes: attStr as [NSAttributedString.Key : Any])
        return attributedStr
    }
    func checkCameraPermission() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .denied:
            print ("Denied status callled")
            self.presentCameraSettings()
            break
        case .restricted:
            print ("User Don't allow")
            break
        case .authorized:
            print ("Success")
            self.callCamera()
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess (for: .video) { (success) in
                if success {
                    print ("Permission Granted" )
                } else {
                    print ("Permission not granted" )
                }
            }
            break
        }
    }
    func presentCameraSettings () { // Present the setting to get the Permission to access the camera
        let alertController = UIAlertController(title: "Error",message: "Camera access is denied",preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel",style: .default))
        alertController.addAction(UIAlertAction(title: "Settings",style: .cancel) { _ in
            if let url = URL (string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:],completionHandler: { _ in })
            }})
        present (alertController, animated: true)
    }
    func callCamera(){
        let ac = UIAlertController(title : "\(SchoolName.RKCRajkot)" , message: nil, preferredStyle: .actionSheet)
        let photoLibraryBtn = UIAlertAction(title: "Photo Library", style: .default) { [weak self](_) in
            self?.showImagePicker(selectedSourcs: UIImagePickerController.SourceType.photoLibrary)
        }
        let cameraBtn = UIAlertAction(title: "Camera", style: .default) { [weak self] (_) in
            self?.showImagePicker(selectedSourcs: UIImagePickerController.SourceType.camera)
        }
        let cencelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cameraBtn)
        ac.addAction(photoLibraryBtn)
        ac.addAction(cencelBtn)
        self.present(ac, animated: true)
    }
    func showImagePicker(selectedSourcs:UIImagePickerController.SourceType){ // Show the imagepicker
        guard UIImagePickerController.isSourceTypeAvailable(selectedSourcs) else {
            print("hello")
            return
        }
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.allowsEditing = true
        imageController.sourceType = selectedSourcs
        self.present(imageController, animated: true, completion: nil)
    }
    func convertDateFormatter() -> String { // To get the current date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        return result
    }
    func updateTextViewWithTeacherInfo(teacherArray: [TeacherListRest], textView: UITextView) {
        textView.text = ""
        
        var teacherInfo = ""
        for teacherData in teacherArray {
            if let empId = teacherData.empCode, let empName = teacherData.empName {
                teacherInfo.append("\(empId). \(empName), ")
            }
        }
        
        if !teacherInfo.isEmpty {
            teacherInfo.removeLast(2)  // Remove the trailing comma and space
            textView.text = teacherInfo
        }
    }
    func updateLabelWithSectionInfo(teacherArray: [ShowSectionRest], label: UILabel) {
        label.text = ""
        
        var sectionInfo = ""
        for sectionData in teacherArray {
            if let  sectionName = sectionData.sectionName {
                sectionInfo.append("\(sectionName), ")
            }
        }
        
        if !sectionInfo.isEmpty {
            sectionInfo.removeLast(2)  // Remove the trailing comma and space
            label.text = sectionInfo
        }
    }
    func embed(viewController:UIViewController, inView view:UIView){
        
        //To embed View Controller inside a view
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    func showSelectionOptions(title: String, options: [String], completion: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
            
            for option in options {
                let action = UIAlertAction(title: option, style: option == "Cancel" ? .cancel : .default) { _ in
                    if option != "Cancel" {
                        completion(option)
                    }
                }
                ac.addAction(action)
            }
            
            present(ac, animated: true)
    }
    func invalidMarksAlert() {
        let alertController = UIAlertController(title: "Invalid Marks", message: AppMessages.MSG_INVALIS_MARKS, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

extension Date {
    func isGreater(_ date : Date) -> Bool{
        return self < date
    }
}
extension String{
    
    func validateEmailId() -> Bool {
        let emailRegEx = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }
    
    func validatePassword(mini: Int = 8, max: Int = 8) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        var passRegEx = ""
        if mini >= max{
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),}$"
        }else{
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),\(max)}$"
        }
        return applyPredicateOnRegex(regexStr: passRegEx)
    }
    
    //https://stackoverflow.com/a/39284766/8201581
    
    func applyPredicateOnRegex(regexStr: String) -> Bool{
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
    
    
}
extension Notification.Name {
    static let passNextVC = Notification.Name("passNextVC")
}
