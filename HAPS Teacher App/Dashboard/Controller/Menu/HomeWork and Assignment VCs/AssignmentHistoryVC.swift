//
//  AssignmentHistoryVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/08/23.
//

import UIKit
import ObjectMapper

class AssignmentHistoryVC: UIViewController {
    var assignmentListObj: AssignmentListModel?

    @IBOutlet weak var assignmentHistoryTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Assignment History")
        assignmentListApi()
        // Do any additional setup after loading the view.
    }
    @objc func showImage(sender:UITapGestureRecognizer) {
        openImage(image: assignmentListObj?.response?.rest?[sender.view?.tag ?? 0].imgpath ?? "")
    }
    @objc func showPDF(sender:UITapGestureRecognizer) {
        openWebView(urlString: assignmentListObj?.response?.rest?[sender.view?.tag ?? 0].pdfpath ?? "", viewController: self)
    }
}
extension AssignmentHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignmentListObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let assignmentCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.assignHistoryCell.getIdentifier, for: indexPath) as! AssignmentHistoryTblCell
        assignmentCell.assignmentHistoryView.clipsToBounds = true
        let assignmentData = assignmentListObj?.response?.rest?[indexPath.row]
        assignmentCell.descriptionLbl.text = assignmentData?.desp
        assignmentCell.subjectLbl.text = assignmentData?.subjectName
        assignmentCell.classSectionLbl.text = "\(assignmentData?.className ?? "") - \(assignmentData?.sectionName ?? "")"
        assignmentCell.dueDateLbl.text = "Due Date: \(assignmentData?.due_date ?? "")"
        assignmentCell.pdfLinkLbl.text = assignmentData?.pdfpath
        assignmentCell.attachmentImgView.tag = indexPath.row
        assignmentCell.pdfLinkLbl.tag = indexPath.row
        let attachmentTap = UITapGestureRecognizer()
        assignmentCell.attachmentImgView.addGestureRecognizer(attachmentTap)
        attachmentTap.addTarget(self, action: #selector(showImage(sender: )))
        let pdfViewTap = UITapGestureRecognizer()
        assignmentCell.pdfLinkLbl.addGestureRecognizer(pdfViewTap)
        pdfViewTap.addTarget(self, action: #selector(showPDF(sender: )))
        
        switch assignmentData?.filetype {
        case "pdf":
            assignmentCell.imgAttachmentView.isHidden = true
            assignmentCell.pdfAttachmentView.isHidden = false
        case "jpg":
            assignmentCell.imgAttachmentView.isHidden = false
            assignmentCell.pdfAttachmentView.isHidden = true
        case "":
            assignmentCell.imgAttachmentView.isHidden = true
            assignmentCell.pdfAttachmentView.isHidden = true
        default:
            print("Wrong FileType")
        }
        return assignmentCell
    }
}
extension AssignmentHistoryVC {
    func assignmentListApi() {
        CommonObjects.shared.showProgress()
        
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Assignment_List.getEndPoints).php?empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&sessionid=\(UserDefaults.getUserDetail()?.Session ?? "")&branchid=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Assignment_List.getEndPoints, apiRequestURL: strUrl)
    }
}
extension AssignmentHistoryVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Assignment_List.getEndPoints {
            let status = response["status"] as! String
            if status == "Success" {
                if let homeworkListDictData = Mapper<AssignmentListModel>().map(JSONObject: response) {
                    assignmentListObj = homeworkListDictData
                    DispatchQueue.main.async {
                        self.assignmentHistoryTblView.reloadData()
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
