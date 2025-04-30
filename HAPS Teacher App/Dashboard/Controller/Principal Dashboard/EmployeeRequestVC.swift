//
//  EmployeeRequestVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 17/10/23.
//

import UIKit

class EmployeeRequestVC: UIViewController {

    @IBOutlet weak var notMarkAttendanceView: UIView!
    @IBOutlet weak var lateAttendanceView: UIView!
    @IBOutlet weak var extraDayView: UIView!
    @IBOutlet weak var schoolNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Employee's Request")
        schoolNameLbl.text = "\(SchoolName.HAPSchool), \(UserDefaults.getUserDetail()?.branchName ?? "")"
        let extraDayTap = UITapGestureRecognizer()
        extraDayView.addGestureRecognizer(extraDayTap)
        extraDayTap.addTarget(self, action: #selector(extraDayScreen))
        // Do any additional setup after loading the view.
    }
    
    @objc func extraDayScreen() {
        performSegue(withIdentifier: AppStrings.AppSegue.forExtraDayRequestSegue.getDescription, sender: nil)
    }
    

}
