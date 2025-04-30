//
//  NotificationVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 11/08/23.
//

import UIKit
import ObjectMapper



class NotificationVC: UIViewController {
    var notificationsObj: NotificationsModel?
    
    var dashboardVCBackDelegate: DashboardVCBackDelegate? = nil
    @IBOutlet weak var notificationTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Notification")
        notificationAPI()
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppNotificationSegue.taskbymeSegue.getIdentifier {
            if let destinationVC = segue.destination as? CommentVC {
                destinationVC.taskId = notificationsObj?.response?[sender as! Int].id
                destinationVC.tasksName = notificationsObj?.response?[sender as! Int].taskname ?? ""
                destinationVC.typeOf = .TaskAssignByMe
            }
        }
        if segue.identifier == AppStrings.AppNotificationSegue.tasktomeSegue.getIdentifier {
            if let destinationVC = segue.destination as? CommentVC {
                destinationVC.taskId = notificationsObj?.response?[sender as! Int].id
                destinationVC.tasksName = notificationsObj?.response?[sender as! Int].taskname ?? ""
                destinationVC.typeOf = .TaskAssignToMe
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        notificationAPI()
    }
    
}
extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch notificationsObj?.response?[indexPath.row].type {
           case "document":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.forMeUploadDocSegue.getIdentifier, sender: nil)
            
           case "Circular":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.empCircularsegue.getIdentifier, sender: nil)
            
           case "task":
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.notificationToTaskAssignToMeSegue.getIdentifier, sender: self)
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            
           case "complaint":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.myEComplaintsActSgue.getIdentifier, sender: nil)
            
           case "leave":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.leavesRecordSegue.getIdentifier, sender: nil)
            
           case "taskbyme":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.taskbymeSegue.getIdentifier, sender: indexPath.row)
            
           case "tasktome":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.tasktomeSegue.getIdentifier, sender: indexPath.row)
            
           case "princicomplaint":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.princiComplaintSegue.getIdentifier, sender: nil)
            
           case "princiappliedleave":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.princiAppliedLeaveSegue.getIdentifier, sender: nil)
            
           case "princiextraday":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.princiExtraDaySegue.getIdentifier, sender: nil)
            
           case "princidailyagenda":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.princiDailyAgendaSegue.getIdentifier, sender: nil)
            
           case "princiactivitylog":
            delNotificationApi(notificationid: notificationsObj?.response?[indexPath.row].id ?? "", notificationType: notificationsObj?.response?[indexPath.row].type ?? "")
            performSegue(withIdentifier: AppStrings.AppNotificationSegue.princiActLogSegue.getIdentifier, sender: nil)
            
        default :
            print("Unknown Notification Type")

        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationsObj?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.notificationCell.getIdentifier, for: indexPath) as! NotificationTblCell
        notificationCell.notificationDate.text = notificationsObj?.response?[indexPath.row].createdate
        notificationCell.notificationLbl.text = notificationsObj?.response?[indexPath.row].messages
        return notificationCell
    }
}
extension NotificationVC {
    func notificationAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Notifications.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Notifications.getEndPoints, apiRequestURL: strUrl)
    }
    func delNotificationApi(notificationid:String,notificationType: String) {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Delete_Notification.getEndPoints).php?type=\(notificationType)&id=\(notificationid)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Delete_Notification.getEndPoints, apiRequestURL: strUrl)
    }
}
extension NotificationVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Notifications.getEndPoints {
            let status = response["status"] as! Int
            let message = response["msg"] as! String
            if status == 1 {
                if let notificationsDictData = Mapper<NotificationsModel>().map(JSONObject: response) {
                    notificationsObj = notificationsDictData
                    DispatchQueue.main.async {
                        self.notificationTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Delete_Notification.getEndPoints {
            let status = response["status"] as! String
            if status == "SUCCESS" {
                DispatchQueue.main.async {
                    //self.navigationController?.popViewController(animated: true)
                    self.notificationTblView.reloadData()
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
