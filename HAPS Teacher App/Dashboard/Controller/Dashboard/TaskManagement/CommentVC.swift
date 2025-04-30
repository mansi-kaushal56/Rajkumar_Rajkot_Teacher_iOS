//
//  CommentVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/08/23.
//

import UIKit
import ObjectMapper
import Kingfisher

class CommentVC: UIViewController {
    
    var taskId: String?
    var status: String?
    var tasksName = ""
    var showCommentObj: ShowTaskCommentsModel?
    var type: String?
    var commentImage = UIImage()
    var pdfData = Data()
    var typeOf: ViewTypes?
    
    @IBOutlet weak var inProgressAndCompleteLbl: UILabel!
    @IBOutlet weak var messageTxtFld: UITextField!
    @IBOutlet weak var periorityLbl: UILabel!
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var queryBtnOtl: UIButton!
    @IBOutlet weak var progressBtnOtl: UIButton!
    @IBOutlet weak var taskNameLbl: UILabel!
    @IBOutlet weak var commentTblView: UITableView!
    @IBOutlet weak var ibInProgressCompleteBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Comments")
        queryBtnOtl.setImage(.unselectionIcon, for: .normal)
        progressBtnOtl.setImage(.selectionIcon, for: .normal)
        switch typeOf {
        case .TaskAssignByMe:
            ibInProgressCompleteBtn.isSelected = false
            type = "In Progress"
            inProgressAndCompleteLbl.text = "Complete"
        case .TaskAssignToMe:
            ibInProgressCompleteBtn.isSelected = true
            ibInProgressCompleteBtn.setBackgroundImage(.selectionIcon, for: .normal)
            type = "In Progress"
            inProgressAndCompleteLbl.text = "In Progress"
        default :
            return
        }
        status = "Progess"
        taskNameLbl.text = "Name of the task \n\(tasksName)"
        showCommentApi()
        // Do any additional setup after loading the view.
    }
    @IBAction func periorityCheckBtn(_ sender: UIButton) {
        switch sender.tag {
        case 301:
            queryBtnOtl.setImage(.unselectionIcon, for: .normal)
            progressBtnOtl.setImage(.selectionIcon, for: .normal)
            status = "Progress"
        case 302:
            queryBtnOtl.setImage(.selectionIcon, for: .normal)
            progressBtnOtl.setImage(.unselectionIcon, for: .normal)
            status = "Query"
        default:
            return
        }
    }
    
    @IBAction func inProgresszCompleteBtn(_ sender: UIButton) {
        switch typeOf {
        case .TaskAssignByMe:
            if ibInProgressCompleteBtn.isSelected {
                ibInProgressCompleteBtn.isSelected = false
                type = "Complete"
                ibInProgressCompleteBtn.setBackgroundImage(.selectionIcon, for: .normal)
            } else {
                type = "In Progress"
                ibInProgressCompleteBtn.isSelected = true
                ibInProgressCompleteBtn.setBackgroundImage(.unselectionIcon, for: .normal)
            }
        case .TaskAssignToMe:
            if ibInProgressCompleteBtn.isSelected {
                type = "In Progress"
                ibInProgressCompleteBtn.setBackgroundImage(.selectionIcon, for: .normal)
            }
        default :
            return
        }
        
    }
    @IBAction func sendMessageBtn(_ sender: Any) {
        submitCommentApi()
    }
    @IBAction func sendImgBtn(_ sender: UIButton) {
        checkCameraPermission()
    }
}
extension CommentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showCommentObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.commentCell.getIdentifier, for: indexPath) as! CommentTblCell
        let commentObjData = showCommentObj?.response?.rest?[indexPath.row]
        commentCell.commentNameDateLbl.text = commentObjData?.loginname
        commentCell.statusLbl.text = commentObjData?.type
        commentCell.commentTxtLbl.text = commentObjData?.msg
        
        let image = (commentObjData?.pic ?? "")
        let imgURL = URL(string: image)
        commentCell.commentImgView.kf.setImage(with: imgURL)
        
        if commentObjData?.pic == "" {
            commentCell.commentView.isHidden = true
        } else {
            commentCell.commentView.isHidden = false
        }
        return commentCell
    }
}
extension CommentVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage {
            commentImage = img
        } else if let img = info[.editedImage] as? UIImage {
            commentImage = img
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension CommentVC {
    func showCommentApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Showtask_Comments.getEndPoints).php?task_id=\(taskId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Showtask_Comments.getEndPoints, apiRequestURL: strUrl)
    }
    func submitCommentApi() {
        let message = messageTxtFld.text ?? ""
        if message.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_MESSAGE_EMPTY, controller: self)
            return
        }
        
        let parameters = ["empcode": UserDefaults.getUserDetail()?.EmpCode ?? "",
                          "task_id" : taskId ?? "",
                          "msg" : message,
                          "type" : type ?? "",// In progess
                          "status" : status ?? ""] // Progress and Query
        
        CommonObjects.shared.showProgress()
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName:END_POINTS.Api_Save_Task_Communications.getEndPoints , image: commentImage, pdfData: pdfData, parameters: parameters, isImageUpload: true, fileOrPhoto: FileOrPhotoKey.File)// Only Image uploading.
    }
    
}

extension CommentVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Showtask_Comments.getEndPoints {
            let status = response["status"] as! String
            if status == "SUCCESS" {
                if let showCommentsDictData = Mapper<ShowTaskCommentsModel>().map(JSONObject: response) {
                    showCommentObj = showCommentsDictData
                    DispatchQueue.main.async {
                        self.commentTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Save_Task_Communications.getEndPoints {
            let status = response["status"] as! String
            let message = response["message"] as! String
            if status == "SUCCESS" {
                showCommentApi()
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message)
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
