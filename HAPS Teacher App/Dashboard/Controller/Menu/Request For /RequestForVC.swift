//
//  RequestForVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 14/09/23.
//

import UIKit

class RequestForVC: UIViewController {

    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var noMarkAttendanceView: UIView!
    @IBOutlet weak var lateAttendanceView: UIView!
    @IBOutlet weak var extraDayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Request For")
        schoolNameLbl.text = "\(SchoolName.RKCRajkot), \(UserDefaults.getUserDetail()?.branchName ?? "")"
        viewsTapGestures()
        // Do any additional setup after loading the view.
    }
    func viewsTapGestures() {
        
        extraDayView.addTapGestureRecognizer {
            self.extraDay()
        }
        lateAttendanceView.addTapGestureRecognizer {
            self.lateAttendance()
        }
        noMarkAttendanceView.addTapGestureRecognizer {
            self.noMarkAttendance()
        }
    }
    func extraDay() {
        performSegue(withIdentifier: AppStrings.AppSegue.extraDaySegue.getDescription, sender: nil)
    }
    func lateAttendance() {
        CommonObjects.shared.showToast(message: AppMessages.MSG_Biometric_Attendance )
        
    }
    func noMarkAttendance() {
        CommonObjects.shared.showToast(message: AppMessages.MSG_Biometric_Attendance )
    }

}
