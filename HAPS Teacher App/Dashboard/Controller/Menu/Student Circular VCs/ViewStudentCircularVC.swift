//
//  ViewStudentCircularVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 08/09/23.
//

import UIKit
import ObjectMapper

class ViewStudentCircularVC: UIViewController {
    var studentCircularObj: StudentCircularModel?

    @IBOutlet weak var studentCircularTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Student Circular List")
        viewStudentCircularAPI()
        // Do any additional setup after loading the view.
    }

}
extension ViewStudentCircularVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentCircularObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewCircularCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.viewStudentCircularCell.getIdentifier, for: indexPath) as! ViewStudentCircularTblCell
        let  studentCircularData = studentCircularObj?.response?.rest?[indexPath.row]
        viewCircularCell.circularTitleLbl.text = studentCircularData?.title
        viewCircularCell.circularDateLbl.text = studentCircularData?.circular_date
        viewCircularCell.circularForLbl.text = "\(studentCircularData?.studentType ?? "-")"
        viewCircularCell.groupLbl.text = studentCircularData?.groupName
        viewCircularCell.classLbl.text = "\(studentCircularData?.className ?? "") - \(studentCircularData?.sectionName ?? "")(\(studentCircularData?.count ?? 0))"
        viewCircularCell.viewCircularDetailView.clipsToBounds = true
//        viewCircularCell.descriptionLbl.text = studentCircularData?.description
//        viewCircularCell.pdfLinkLbl.text = studentCircularData?.pdf
//        if studentCircularData?.file == "" {
//            viewCircularCell.pdfView.isHidden = true
//            viewCircularCell.imgViewView.isHidden = false
//        } else if studentCircularData?.pdf == "" {
//            viewCircularCell.pdfView.isHidden = false
//            viewCircularCell.imgViewView.isHidden = true
//        } else {
//            viewCircularCell.pdfView.isHidden = true
//            viewCircularCell.imgViewView.isHidden = true
//        }
        return viewCircularCell
    }
}
extension ViewStudentCircularVC {
    func viewStudentCircularAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Student_Circular_Send_By_Me.getEndPoints).php?branch_id=\(UserDefaults.getUserDetail()?.BranchId ?? "")&session_id=\(UserDefaults.getUserDetail()?.Session ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Student_Circular_Send_By_Me.getEndPoints, apiRequestURL: strUrl)
    }
}
extension ViewStudentCircularVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Student_Circular_Send_By_Me.getEndPoints {
            let status = response["status"] as! Int
           // let message = response["msg"] as! String
            if status == 1 {
                if let viewcircularDictData = Mapper<StudentCircularModel>().map(JSONObject: response) {
                    studentCircularObj = viewcircularDictData
                    //print(studentCircularObj)
                    DispatchQueue.main.async {
                        self.studentCircularTblView.reloadData()
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
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR)
        }
    }
}
