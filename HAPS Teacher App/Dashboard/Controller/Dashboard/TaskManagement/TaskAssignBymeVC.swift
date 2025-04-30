//
//  TaskAssignBymeVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/08/23.
//

import UIKit
import ObjectMapper

class TaskAssignBymeVC: UIViewController {

    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var taskAssignBymeTblView: UITableView!
    @IBOutlet weak var taskAssignBymeCollectView: UICollectionView!
    var viewTsk = [
        "All",
        "Pending",
        "Progress",
        "Complete"
    ]
    var viewTskColor = [
        "AllCollectClr",
        "PendingCollectClr",
        "ProgressCollectClr",
        "CompleteCollectClr"
    ]
    var apiEndPoint : String?
    var taskAssignByMeObj: TasksModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn(title: "Task Assign by Me")
        taskAssignBymeApi(apiNames: END_POINTS.Api_Task_Assigned_By_All_Tasks.getEndPoints)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.taskCommentSegue.getDescription {
            if let destinationvc = segue.destination as? CommentVC {
                destinationvc.taskId = taskAssignByMeObj?.response?.rest?[sender as! Int].id
                destinationvc.tasksName = taskAssignByMeObj?.response?.rest?[sender as! Int].taskname ?? ""
                destinationvc.typeOf = .TaskAssignByMe
            }
        }
    }
    @objc func commentScreen(_ sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: AppStrings.AppSegue.taskCommentSegue.getDescription, sender: sender.view?.tag)
    }
    @objc func openPdf(_ sender:UITapGestureRecognizer) {
        openWebView(urlString: taskAssignByMeObj?.response?.rest?[sender.view?.tag ?? 0].pdf ?? "", viewController: self)
    }
    @objc func showImg(_ sender:UITapGestureRecognizer) {
        openImage(image: taskAssignByMeObj?.response?.rest?[sender.view?.tag ?? 0].image ?? "")
    }
}
extension TaskAssignBymeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            taskAssignBymeApi(apiNames: END_POINTS.Api_Task_Assigned_By_All_Tasks.getEndPoints)
        }
        if indexPath.row == 1 {
            taskAssignBymeApi(apiNames: END_POINTS.Api_By_Me_Pending_Task.getEndPoints)
        }
        if indexPath.row == 2 {
            taskAssignBymeApi(apiNames: END_POINTS.Api_ByMe_In_Progress.getEndPoints)
        }
        if indexPath.row == 3 {
            taskAssignBymeApi(apiNames: END_POINTS.Api_ByMe_Complete_Task.getEndPoints)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewTsk.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myTaskCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppStrings.AppCViewIdentifiers.myTaskCVCell.getIdentifier, for: indexPath) as! TaskAssignBymeCollectCell
        myTaskCell.taskCollectLblOtl.text = viewTsk[indexPath.row]
        myTaskCell.taskImgOtl.image = UIImage(named: viewTsk[indexPath.row])
        myTaskCell.taskCollectView.backgroundColor = UIColor(named: viewTskColor[indexPath.row])
        
        return myTaskCell
    }
    
    
}
extension TaskAssignBymeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskAssignByMeObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewMyTaskCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.myTaskCell.getIdentifier, for: indexPath) as! TaskBymeTblCell
        //viewMyTaskCell.taskCommentView.addGestureRecognizer(UITapGestureRecognizer(target: self,action:#selector(commentBtn)))
        let myTasksData = taskAssignByMeObj?.response?.rest?[indexPath.row]
        viewMyTaskCell.tskDescriptionLbl.text = myTasksData?.des
        viewMyTaskCell.tskNameLbl.text = myTasksData?.taskname
        viewMyTaskCell.tskPeriorityLbl.text = myTasksData?.priority
        viewMyTaskCell.assignByLbl.text = myTasksData?.assignedby
        viewMyTaskCell.assignToLbl.text =  myTasksData?.assignto
        viewMyTaskCell.deadlineDateLbl.text = myTasksData?.deadline
        viewMyTaskCell.assignTskDateLbl.text =  myTasksData?.datefrom
        viewMyTaskCell.tskStatusLbl.text = myTasksData?.taskstatus
        viewMyTaskCell.pdfLinkLbl.text = myTasksData?.pdf
        viewMyTaskCell.pdfLinkLbl.tag = indexPath.row
        let pdfLinkTapGesture = UITapGestureRecognizer()
        viewMyTaskCell.pdfLinkLbl.addGestureRecognizer(pdfLinkTapGesture)
        pdfLinkTapGesture.addTarget(self, action: #selector(openPdf(_:)))
        
        let imgGesture = UITapGestureRecognizer()
        viewMyTaskCell.attachmentImgView.addGestureRecognizer(imgGesture)
        imgGesture.addTarget(self, action: #selector(showImg(_:)))
        
        switch myTasksData?.taskstatus {
        case "Completed":
            viewMyTaskCell.tskStatusView.backgroundColor = .AppLightGreen
        case "Inprogrss":
            viewMyTaskCell.tskStatusView.backgroundColor = .AppYellow
        case "Pending":
            viewMyTaskCell.tskStatusView.backgroundColor = .AppRed
        default:
            print("Unknown")
        }
        if myTasksData?.attachment == "Yes" {
            viewMyTaskCell.attachmentView.isHidden = false
            viewMyTaskCell.pdfLinkView.isHidden = true
        } else {
            if myTasksData?.pdf == "" {
                viewMyTaskCell.pdfLinkView.isHidden = true
                viewMyTaskCell.attachmentView.isHidden = true
            } else {
                viewMyTaskCell.pdfLinkView.isHidden = false
                viewMyTaskCell.attachmentView.isHidden = true
            }
        }
        viewMyTaskCell.taskCommentView.tag = indexPath.row
        viewMyTaskCell.taskCommentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(commentScreen(_:))))
        
        return viewMyTaskCell
    }
}
extension TaskAssignBymeVC {
    func taskAssignBymeApi(apiNames:String) {
        CommonObjects.shared.showProgress()
        apiEndPoint = apiNames
        let strUrl = "\(BASE_URL)\(apiNames).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: apiNames, apiRequestURL: strUrl)
    }
}

extension TaskAssignBymeVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == apiEndPoint {
            let status = response["status"] as! String
            if status == "SUCCESS" {
                if let TaskAssignDictData = Mapper<TasksModel>().map(JSONObject: response) {
                    taskAssignByMeObj = TaskAssignDictData
                    print(TaskAssignDictData)
                    DispatchQueue.main.async {
                        self.taskAssignBymeTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA, controller: self)
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
