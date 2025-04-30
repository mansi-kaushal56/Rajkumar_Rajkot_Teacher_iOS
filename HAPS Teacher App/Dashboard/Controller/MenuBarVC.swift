//
//  MenuBarVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/07/23.
//

import UIKit

class MenuBarVC: UIViewController {

    @IBOutlet weak var menuTblView: UITableView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var sessionLbl: UILabel!
    
    var menuListArr = ["My Profile","Student Attendance","Home Work","Marks Entry","E-PTM","Hostel Parenting","Academic Calender","School Matter Calender","Medical Entry","Hostel Room Allocation","Student Portfolio","Daily Activity Log","Employee Circular","Student Circular","Discipline","E-Complaint","Request For","My Feedback List","Document Upload","Gate Pass Request","Logout"]
    var menuImgArr = ["MyProfile","StudentAttendance","HomeWork","Groupicon","E-PTM","Hostel Parenting","AcademicCalender","SchoolMatterCalender","MedicalEntry","Hostel","StudentPortfolio","DailyActivityLog","EmployeeCircular","StudentCircular","Disciline","E-Complaint","RequestFor","Feedback","Document","gatepassIcon","logout"]
    
    var principalListArr = ["My Profile","Student Attendance","E-PTM","Hostel Parenting","Academic Calender","School Matter Calender","Medical Entry","Hostel Room Allocation","Student Portfolio","Daily Activity Log","Employee Circular","Student Circular","Discipline","E-Complaint","Request For","My Feedback List","Document Upload","Gate Pass Request","Logout"]
    
    var principalImgArr = ["MyProfile","StudentAttendance","E-PTM","Hostel Parenting","AcademicCalender","SchoolMatterCalender","MedicalEntry","Hostel","StudentPortfolio","DailyActivityLog","EmployeeCircular","StudentCircular","Disciline","E-Complaint","RequestFor","Feedback","Document","gatepassIcon","logout"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLblData()
        // Do any additional setup after loading the view.
    }
   
    func setLblData() {
        let img = (UserDefaults.getUserDetail()?.profil_pic ?? "")
        let imgUrl = URL(string: img)
        profileImgView.kf.setImage(with: imgUrl,placeholder: UIImage.placeHolderImg)
        nameLbl.text = UserDefaults.getUserDetail()?.name
        sessionLbl.text = "(Current Session: \(UserDefaults.getUserDetail()?.SessionName ?? ""))"
    }
}
//MARK: (18-OCT-2023)
extension MenuBarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UserDefaults.getUserDetail()?.DesignationName == "PRINCIPAL" {
            switch indexPath.row {
            case 0:
                performSegue(withIdentifier: AppStrings.AppSegue.profileSegue.getDescription, sender: nil)
            case 1:
                performSegue(withIdentifier: AppStrings.AppSegue.attendanceSegue.getDescription, sender: nil)
            case 2:
                performSegue(withIdentifier: AppStrings.AppSegue.ePTMSegue.getDescription, sender: nil)
            case 3:
                performSegue(withIdentifier: AppStrings.AppSegue.hostelParentingSegue.getDescription, sender: nil)
            case 4:
                performSegue(withIdentifier: AppStrings.AppSegue.calenderSegue.getDescription, sender: nil)
            case 5:
                performSegue(withIdentifier: AppStrings.AppSegue.schoolCalenderSegue.getDescription, sender: nil)
            case 6:
                performSegue(withIdentifier: AppStrings.AppSegue.medicalEntrySegue.getDescription, sender: nil)
            case 7:
                performSegue(withIdentifier: AppStrings.AppSegue.roomAllocationSegue.getDescription, sender: nil)
            case 8:
                performSegue(withIdentifier: AppStrings.AppSegue.studentPortfolioSegue.getDescription, sender: nil)
            case 9:
                performSegue(withIdentifier: AppStrings.AppSegue.activityLogSegue.getDescription, sender: nil)
            case 10:
                performSegue(withIdentifier: AppStrings.AppSegue.circularSegue.getDescription, sender: nil)
            case 11:
                performSegue(withIdentifier: AppStrings.AppSegue.studentCircularSegue.getDescription, sender: nil)
            case 12:
                performSegue(withIdentifier: AppStrings.AppSegue.disciplineSegue.getDescription, sender: nil)
            case 13:
                performSegue(withIdentifier: AppStrings.AppSegue.eComplaintSegue.getDescription, sender: nil)
            case 14:
                performSegue(withIdentifier: AppStrings.AppSegue.requestForSegue.getDescription, sender: nil)
            case 15:
                performSegue(withIdentifier: AppStrings.AppSegue.feedbackListSegue.getDescription, sender: nil)
            case 16:
                performSegue(withIdentifier: AppStrings.AppSegue.uploadDocumentSegue.getDescription, sender: nil)
            case 17:
                performSegue(withIdentifier: AppStrings.AppSegue.gatePassSegue.getDescription, sender: nil)
            case 18:
                logOutBtn(title: "Sign Out", message: "Are you sure, you want to logout")
                
            default:
                break
            }
        } else {
            switch indexPath.row {
            case 0:
                performSegue(withIdentifier: AppStrings.AppSegue.profileSegue.getDescription, sender: nil)
            case 1:
                performSegue(withIdentifier: AppStrings.AppSegue.attendanceSegue.getDescription, sender: nil)
            case 2:
                performSegue(withIdentifier: AppStrings.AppSegue.homeWorkSegue.getDescription, sender: nil)
            case 3:
                performSegue(withIdentifier: AppStrings.AppSegue.marksEntrySegue.getDescription, sender: nil)
            case 4:
                performSegue(withIdentifier: AppStrings.AppSegue.ePTMSegue.getDescription, sender: nil)
            case 5:
                performSegue(withIdentifier: AppStrings.AppSegue.hostelParentingSegue.getDescription, sender: nil)
            case 6:
                performSegue(withIdentifier: AppStrings.AppSegue.calenderSegue.getDescription, sender: nil)
            case 7:
                performSegue(withIdentifier: AppStrings.AppSegue.schoolCalenderSegue.getDescription, sender: nil)
            case 8:
                performSegue(withIdentifier: AppStrings.AppSegue.medicalEntrySegue.getDescription, sender: nil)
            case 9:
                performSegue(withIdentifier: AppStrings.AppSegue.roomAllocationSegue.getDescription, sender: nil)
            case 10:
                performSegue(withIdentifier: AppStrings.AppSegue.studentPortfolioSegue.getDescription, sender: nil)
            case 11:
                performSegue(withIdentifier: AppStrings.AppSegue.activityLogSegue.getDescription, sender: nil)
            case 12:
                performSegue(withIdentifier: AppStrings.AppSegue.circularSegue.getDescription, sender: nil)
            case 13:
                performSegue(withIdentifier: AppStrings.AppSegue.studentCircularSegue.getDescription, sender: nil)
            case 14:
                performSegue(withIdentifier: AppStrings.AppSegue.disciplineSegue.getDescription, sender: nil)
            case 15:
                performSegue(withIdentifier: AppStrings.AppSegue.eComplaintSegue.getDescription, sender: nil)
            case 16:
                performSegue(withIdentifier: AppStrings.AppSegue.requestForSegue.getDescription, sender: nil)
            case 17:
                performSegue(withIdentifier: AppStrings.AppSegue.feedbackListSegue.getDescription, sender: nil)
            case 18:
                performSegue(withIdentifier: AppStrings.AppSegue.uploadDocumentSegue.getDescription, sender: nil)
            case 19:
                performSegue(withIdentifier: AppStrings.AppSegue.gatePassSegue.getDescription, sender: nil)
            case 20:
                logOutBtn(title: "Sign Out", message: "Are you sure, you want to logout")
            default:
                break
            }
            
        }
        
    }
    //MARK: (18-OCT-2023)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserDefaults.getUserDetail()?.DesignationName == "PRINCIPAL" {
            return principalImgArr.count
        } else {
            return menuListArr.count
        }
    }
    //MARK: (18-OCT-2023)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.menuCell.getIdentifier, for: indexPath) as! MenuTblCell
        if UserDefaults.getUserDetail()?.DesignationName == "PRINCIPAL" {
            cell.MenuTblLbl.text = principalListArr[indexPath.row]
            cell.menuTblImg.image = UIImage(named: principalImgArr[indexPath.row])
        } else {
            cell.MenuTblLbl.text = menuListArr[indexPath.row]
            cell.menuTblImg.image = UIImage(named: menuImgArr[indexPath.row])
        }
        return cell
    }
    
    
}
