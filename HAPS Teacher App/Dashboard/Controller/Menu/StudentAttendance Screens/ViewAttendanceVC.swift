//
//  ViewAttendanceVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 17/08/23.
//

import UIKit

class ViewAttendanceVC: UIViewController {

    @IBOutlet weak var coachingClassView: UIView!
    @IBOutlet weak var mainClassView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "View Attendance")
        tapGestureRec()
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.mainClassSegue.getDescription {
            if let destinationVC = segue.destination as? ClassesAttendanceVC {
                switch sender as? Int {
                case 1:
                    destinationVC.type = .MainClassAttendance
                case 2:
                    destinationVC.type = .CoachingClassAttendance
                default:
                    print("Unknow")
                }
                //destinationVC.type = .MainClassAttendance
            }
        }
    }
    func tapGestureRec() {
        let mainClassTap = UITapGestureRecognizer()
        mainClassView.addGestureRecognizer(mainClassTap)
        mainClassTap.addTarget(self, action: #selector(mainClass))
        
        let coachingClassTap = UITapGestureRecognizer()
        coachingClassView.addGestureRecognizer(coachingClassTap)
        coachingClassTap.addTarget(self, action: #selector(coachingClass))
    }
    @objc func mainClass() {
        performSegue(withIdentifier: AppStrings.AppSegue.mainClassSegue.getDescription, sender: 1)
    }
    @objc func coachingClass() {
        performSegue(withIdentifier: AppStrings.AppSegue.mainClassSegue.getDescription, sender: 2)
    }
   
}
