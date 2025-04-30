//
//  TaskAssignTomeVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 08/08/23.
//

import UIKit
import ObjectMapper

class TaskAssignTomeVC: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var viewTaskTblView: UITableView!
    @IBOutlet weak var viewTaskCollectionView: UICollectionView!
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
    var apiEndPoint: String?
    var taskAssignObj: TasksModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Task Assign to Me")
        allTasksListAPI(apiNames: END_POINTS.Api_Viewtask.getEndPoints)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.commentSegue.getDescription {
            if let destinationVC = segue.destination as? CommentVC {
                destinationVC.taskId = taskAssignObj?.response?.rest?[sender as! Int].id
                //destinationVC.status = taskAssignObj?.response?.rest?[sender as! Int].taskstatus
                destinationVC.tasksName = taskAssignObj?.response?.rest?[sender as! Int].taskname ?? ""
                destinationVC.typeOf = .TaskAssignToMe
                
            }
        }
        if segue.identifier == AppStrings.AppSegue.forwardScreenSegue.getDescription {
            if let destinationVC = segue.destination as? ForwardTaskVC {
                destinationVC.taskId = taskAssignObj?.response?.rest?[sender as! Int].id
                destinationVC.taskObj = taskAssignObj?.response?.rest?[sender as! Int]
            }
        }
    }
    
    @objc func forwardTaskScreen(_ sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: AppStrings.AppSegue.forwardScreenSegue.getDescription, sender: sender.view?.tag)
    }
    @objc func commentScreen(_ sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: AppStrings.AppSegue.commentSegue.getDescription, sender: sender.view?.tag)
    }
    @objc func openPdf(_ sender:UITapGestureRecognizer) {
        openWebView(urlString: taskAssignObj?.response?.rest?[sender.view?.tag ?? 0].pdf ?? "", viewController: self)
    }
    @objc func showImg(_ sender:UITapGestureRecognizer) {
        openImage(image: taskAssignObj?.response?.rest?[sender.view?.tag ?? 0].image ?? "")
    }
}
extension TaskAssignTomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            allTasksListAPI(apiNames: END_POINTS.Api_Viewtask.getEndPoints)
        }
        if indexPath.row == 1 {
            allTasksListAPI(apiNames: END_POINTS.Api_Pendingtasks.getEndPoints)
        }
        if indexPath.row == 2 {
            allTasksListAPI(apiNames: END_POINTS.Api_Inprogress.getEndPoints)
        }
        if indexPath.row == 3 {
            allTasksListAPI(apiNames: END_POINTS.Api_Complete_Task.getEndPoints)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewTsk.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewTaskcell = collectionView.dequeueReusableCell(withReuseIdentifier: AppStrings.AppCViewIdentifiers.myTaskCVCell.getIdentifier, for: indexPath) as! ViewTaskCollectCell
        viewTaskcell.viewTaskView.backgroundColor = UIColor(named: viewTskColor[indexPath.row])
        viewTaskcell.viewTskCollectLbl.text = viewTsk[indexPath.row]
        viewTaskcell.viewTskCollectImg.image = UIImage(named: viewTsk[indexPath.row])
        
        return viewTaskcell
    }
}
extension TaskAssignTomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskAssignObj?.response?.rest?.count ?? 0
       //return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewTstTblCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.viewTskTblCell.getIdentifier, for: indexPath) as! ViewTaskTblCell

        let tasksData = taskAssignObj?.response?.rest?[indexPath.row]
        viewTstTblCell.assignByLbl.text = tasksData?.assignedby
        viewTstTblCell.assignToLbl.text = tasksData?.assignto
        viewTstTblCell.tskDescriptionLbl.text = tasksData?.des
        viewTstTblCell.tskNameLbl.text = tasksData?.taskname
        viewTstTblCell.deadlineDateLbl.text = tasksData?.deadline
        viewTstTblCell.assignDateLbl.text = tasksData?.datefrom
        viewTstTblCell.tskStatusLbl.text = tasksData?.taskstatus
        viewTstTblCell.tskPeriorityLbl.text = tasksData?.priority
        viewTstTblCell.pdflinkLbl.text = tasksData?.pdf
        switch tasksData?.taskstatus {
        case "Completed":
            viewTstTblCell.tskStatusView.backgroundColor = .AppLightGreen
        case "In Progrss":
            viewTstTblCell.tskStatusView.backgroundColor = .AppYellow
        case "Pending":
            viewTstTblCell.tskStatusView.backgroundColor = .AppRed
        default:
            print("Unknown")
        }
        if tasksData?.attachment == "Yes" {
            viewTstTblCell.attachmentView.isHidden = false
            viewTstTblCell.pdfLinkView.isHidden = true
        } else {
            if tasksData?.pdf == "" {
                viewTstTblCell.pdfLinkView.isHidden = true
                viewTstTblCell.attachmentView.isHidden = true
            } else {
                viewTstTblCell.pdfLinkView.isHidden = false
                viewTstTblCell.attachmentView.isHidden = true
            }
        }
        if tasksData?.type == "intimation" {
            viewTstTblCell.forwardViewOtl.isHidden = true
            viewTstTblCell.viewTaskTblViewOtl.backgroundColor = .AppLightGreen
        } else {
            viewTstTblCell.forwardViewOtl.isHidden = false
            viewTstTblCell.viewTaskTblViewOtl.backgroundColor = .AppLightBlue
        }
        viewTstTblCell.commentViewOtl.tag = indexPath.row
        viewTstTblCell.forwardViewOtl.tag = indexPath.row
        viewTstTblCell.pdflinkLbl.tag = indexPath.row
        viewTstTblCell.attachmentIconView.tag = indexPath.row
        
        viewTstTblCell.pdflinkLbl.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        viewTstTblCell.pdflinkLbl.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(openPdf(_:)))
        tapGesture.delegate = self
        
        let imgTapGesture = UITapGestureRecognizer()
        viewTstTblCell.attachmentIconView.addGestureRecognizer(imgTapGesture)
        imgTapGesture.addTarget(self, action: #selector(showImg(_:)))
        
        viewTstTblCell.forwardViewOtl.addGestureRecognizer(UITapGestureRecognizer(target: self,action:#selector(forwardTaskScreen(_:))))
        viewTstTblCell.commentViewOtl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(commentScreen(_:))))

        return viewTstTblCell
    }
    
}
extension TaskAssignTomeVC {
    func allTasksListAPI(apiNames:String) {
        CommonObjects.shared.showProgress()
        apiEndPoint = apiNames
        let strUrl = "\(BASE_URL)\(apiNames).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&BranchId=\(UserDefaults.getUserDetail()?.Session ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: apiNames, apiRequestURL: strUrl)
    }
}

extension TaskAssignTomeVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == apiEndPoint {
            let status = response["status"] as! String
            if status == "SUCCESS" {
                if let TaskAssignDictData = Mapper<TasksModel>().map(JSONObject: response) {
                    taskAssignObj = TaskAssignDictData
                    print(TaskAssignDictData)
                    DispatchQueue.main.async {
                        self.viewTaskTblView.reloadData()
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
extension TaskAssignTomeVC : DashboardVCBackDelegate {
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

