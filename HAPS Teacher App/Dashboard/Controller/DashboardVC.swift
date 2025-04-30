//
//  DashboardVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 28/07/23.
//

import UIKit
import SideMenu
import ObjectMapper

struct TeacherPrincipleItems {
    var id: String?
    var title: String?
    var image: String?
}


class DashboardVC: UIViewController {
    
    @IBOutlet weak var designationNmeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var attendanceChartView: ViewBorder!
    @IBOutlet weak var absentLbl: UILabel!
    @IBOutlet weak var presentLbl: UILabel!
    @IBOutlet weak var studentLeaveLbl: UILabel!
    @IBOutlet weak var dashboardCollectView: UICollectionView!

    
    var teacherItemsList = [
        TeacherPrincipleItems(id: "1", title: "Task Management", image: "task-management 1"),
        TeacherPrincipleItems(id: "2", title: "Leave Report", image: "ic_leaveStatus"),
        TeacherPrincipleItems(id: "3", title: "Employee Circular", image: "ic_circular"),
        TeacherPrincipleItems(id: "4", title: "Document", image: "ic_documents"),
        TeacherPrincipleItems(id: "5", title: "Daily Task Agenda", image: "taskagenda 1"),
        TeacherPrincipleItems(id: "6", title: "No Dues", image: "nodues 1"),
        TeacherPrincipleItems(id: "7", title: "Holistic Entry", image: "ic_holistic"),
        TeacherPrincipleItems(id: "8", title: "CBO Entry", image: "ic_CBOentry")
    ]
    //Principal login title and image arrays
    
    var principleItemsList = [
        TeacherPrincipleItems(id: "1", title: "Employee DAL Record", image: "DALRecordImg"),
        TeacherPrincipleItems(id: "2", title: "E-PTM Report", image: "EPTMReportImg"),
        TeacherPrincipleItems(id: "3", title: "Task Management", image: "task-management 1"),
        TeacherPrincipleItems(id: "4", title: "Leave Report", image: "ic_leaveStatus"),
        TeacherPrincipleItems(id: "5", title: "Suggestions by Parents/Students", image: "suggestionImg"),
        TeacherPrincipleItems(id: "6", title: "Employee Leave Request", image: "LeaveRequestImg"),
        TeacherPrincipleItems(id: "7", title: "Employee Circular", image: "ic_circular"),
        TeacherPrincipleItems(id: "8", title: "Documents", image: "ic_documents"),
        TeacherPrincipleItems(id: "9", title: "Daily Task Agenda" , image: "taskagenda 1"),
        TeacherPrincipleItems(id: "10", title: "No Dues", image: "nodues 1"),
        TeacherPrincipleItems(id: "11", title: "E-Complaint Records", image: "complaintRecordImg"),
        TeacherPrincipleItems(id: "12", title: "Employee Request For", image: "EmployeeRequestImg"),
        TeacherPrincipleItems(id: "13", title: "Holistic Entry", image:  "ic_holistic"),
        TeacherPrincipleItems(id: "14", title: "CBO Entry", image: "ic_CBOentry")
    ]
    var attendanceObj : CountAttendanceModel?
    var userObj : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attendanceChartView.clipsToBounds = true
        updateLoginAPI()
        dashboardAPI()
        navigationItem.title = "RKC, \(UserDefaults.getUserDetail()?.branchName ?? "")"
        
        
        notificanSignOutBtn()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLoginAPI()
        dashboardAPI()
    }
    @IBAction func menuButton(_ sender: UIButton) {
        menuBarBtn()
    }
    func attendanceCount() {
        //daysCountLbl.text = "Days: \(attendanceObj?.days ?? "")"
        absentLbl.text = "\(attendanceObj?.absents ?? 0)"
        studentLeaveLbl.text = "\(attendanceObj?.leaves ?? 0)"
        presentLbl.text = "\(attendanceObj?.Presents ?? 0)"
    }
    func setProfileData() {
        nameLbl.text = userObj?.name
        designationNmeLbl.text = userObj?.DesignationName
        let img = (userObj?.profil_pic ?? "")
        let imgURL =  URL(string: img)
        profileImgView.kf.setImage(with: imgURL,placeholder: UIImage.placeHolderImg)
    }
    func notificanSignOutBtn() {
        let signOutButton = UIBarButtonItem(image: UIImage(named: "signOutIcon"), style: .plain, target: self, action: #selector(signOutTaped))
        
        let notificationButton = UIButton()
        notificationButton.setImage(UIImage(named: "ic_notification"), for: .normal)
        notificationButton.addTarget(self, action: #selector(notificationTaped), for: .touchUpInside)
        let notificationCount = UILabel(frame: CGRect(x: -5, y: -5, width: 16, height: 16))
        notificationCount.text = "0"
        notificationCount.backgroundColor = .AppRed
        notificationCount.textColor = .white
        notificationCount.textAlignment = .center
        notificationCount.layer.cornerRadius = notificationCount.frame.width / 2
        notificationCount.clipsToBounds = true
        notificationCount.font = UIFont(name: AppFonts.Roboto_Regular, size: 14)
        notificationButton.addSubview(notificationCount)
        let notification = UIBarButtonItem(customView: notificationButton)
        navigationItem.rightBarButtonItems = [signOutButton, notification]
    }
    @objc func signOutTaped() {
        logOutBtn(title: "Sign Out", message: "Are you sure, you want to logout")
    }
    @objc func notificationTaped() {
        performSegue(withIdentifier: AppStrings.AppSegue.notificationSegue.getDescription, sender: nil)
    }
}
extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if UserDefaults.getUserDetail()?.DesignationName == "PRINCIPAL" {
//MARK: (17-oct-2023)
            switch principleItemsList[indexPath.row].id {
            case "1":
                performSegue(withIdentifier: AppStrings.AppSegue.employeeDALSegue.getDescription, sender: nil)
            case "2":
                performSegue(withIdentifier: AppStrings.AppSegue.ePTMRecordSegue.getDescription, sender: nil)
            case "3":
                performSegue(withIdentifier: AppStrings.AppSegue.taskManagementSegue.getDescription, sender: nil)
            case "4":
                performSegue(withIdentifier: AppStrings.AppSegue.empLeaveRecordSegue.getDescription, sender: nil)
            case "5":
                performSegue(withIdentifier: AppStrings.AppSegue.suggestionSegue.getDescription, sender: nil)
            case "6":
                performSegue(withIdentifier: AppStrings.AppSegue.suggestionSegue.getDescription, sender: nil)
            case "7":
                performSegue(withIdentifier: AppStrings.AppSegue.employeeCircularSegue.getDescription, sender: nil)
            case "8":
                performSegue(withIdentifier: AppStrings.AppSegue.documentForMeSegue.getDescription, sender: nil)
            case "9":
                performSegue(withIdentifier: AppStrings.AppSegue.taskAgendaSegue.getDescription, sender: nil)
            case "10":
                break
            case "11":
                performSegue(withIdentifier: AppStrings.AppSegue.eComplaintRecordSegue.getDescription, sender: nil)
            case "12":
                performSegue(withIdentifier: AppStrings.AppSegue.empRequestSegue.getDescription, sender: nil)
            case "13":
                performSegue(withIdentifier: AppStrings.AppSegue.holisticMarksSegue.getDescription, sender: nil)
            case "14":
                performSegue(withIdentifier: AppStrings.AppSegue.cboEntrySegue.getDescription, sender: nil)
            default:
                break
            }
        } else {
            switch teacherItemsList[indexPath.row].id {
            case "1":
                performSegue(withIdentifier: AppStrings.AppSegue.taskManagementSegue.getDescription, sender: nil)
            case "2":
                performSegue(withIdentifier: AppStrings.AppSegue.leaveReportSegue.getDescription, sender: nil)
            case "3":
                performSegue(withIdentifier: AppStrings.AppSegue.employeeCircularSegue.getDescription, sender: nil)
            case "4":
                performSegue(withIdentifier: AppStrings.AppSegue.documentForMeSegue.getDescription, sender: nil)
            case "5":
                performSegue(withIdentifier: AppStrings.AppSegue.taskAgendaSegue.getDescription, sender: nil)
            case "6":
                break
            case "7":
                performSegue(withIdentifier: AppStrings.AppSegue.holisticMarksSegue.getDescription, sender: nil)
            case "8":
                performSegue(withIdentifier: AppStrings.AppSegue.cboEntrySegue.getDescription, sender: nil)
            default:
                break
            }
        }
        
    }
    //MARK: (17-OCT-2023)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if UserDefaults.getUserDetail()?.DesignationName == "PRINCIPAL" {
            return principleItemsList.count
        } else {
            return teacherItemsList.count
        }
       
       
    }
  //MARK: (17-OCT-2023)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppStrings.AppCViewIdentifiers.collectCell.getIdentifier, for: indexPath) as! DashboardCollectCell
        if UserDefaults.getUserDetail()?.DesignationName == "PRINCIPAL" {
            cell.collectionImg.image = UIImage(named: principleItemsList[indexPath.row].image ?? "")
            cell.collectionLbl.text = principleItemsList[indexPath.row].title
        } else {
            cell.collectionImg.image = UIImage(named: teacherItemsList[indexPath.row].image ?? "")
            cell.collectionLbl.text = teacherItemsList[indexPath.row].title
        }
        return cell
    }
}
extension DashboardVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30) / 3
        return CGSize(width: width, height: width)
    }
}
extension DashboardVC {
    func dashboardAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Count_Attendance.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Count_Attendance.getEndPoints, apiRequestURL: strUrl)
        
    }
    func updateLoginAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Update_Login.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Update_Login.getEndPoints, apiRequestURL: strUrl)
    }
}
extension DashboardVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Count_Attendance.getEndPoints {
            let status = response["status"] as! Bool
            if status == true {
                if let userModelDictData = Mapper<CountAttendanceModel>().map(JSONObject: response) {
                    attendanceObj = userModelDictData
                    DispatchQueue.main.async {
                        self.attendanceCount()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Update_Login.getEndPoints {
            let responseStatus = response["response"] as! String
            if responseStatus == "Logged" {
                if let userModelUpdate = Mapper<UserModel>().map(JSONObject: response) {
                    userObj = userModelUpdate
                    print("\(userModelUpdate)")
                    UserDefaults.removeAppData()
                    UserDefaults.setUserDetail(userModelUpdate)
                    DispatchQueue.main.async {
                        self.setProfileData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA, controller: self)
                }
            }
        }
    }
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.stopProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
