//
//  StudentAttendanceVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 17/08/23.
//

import UIKit
import Kingfisher

class StudentAttendanceVC: UIViewController {

    @IBOutlet weak var TDesNameLbl: UILabel!
    @IBOutlet weak var teacherNameLbl: UILabel!
    @IBOutlet weak var teacherImgView: UIImageView!
    @IBOutlet weak var attendanceView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Attendance")
        showTeacherDetail()
        let attendanceTap = UITapGestureRecognizer()
        attendanceView.addGestureRecognizer(attendanceTap)
        attendanceTap.addTarget(self, action: #selector(viewAttendance))
        // Do any additional setup after loading the view.
    }
    func showTeacherDetail() {
        TDesNameLbl.text = UserDefaults.getUserDetail()?.DesignationName ?? ""
        teacherNameLbl.text = UserDefaults.getUserDetail()?.name
        let img = (UserDefaults.getUserDetail()?.profil_pic ?? "")
        let imgUrl = URL(string: img)
        teacherImgView.kf.setImage(with: imgUrl,placeholder: UIImage.placeHolderImg)
    }
    @objc func viewAttendance() {
        performSegue(withIdentifier: AppStrings.AppSegue.viewAttendanceSegue.getDescription, sender: nil)
    }

}
