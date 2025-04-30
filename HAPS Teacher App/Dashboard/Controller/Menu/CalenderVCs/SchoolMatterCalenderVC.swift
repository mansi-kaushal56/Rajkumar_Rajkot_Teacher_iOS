//
//  SchoolMatterCalenderVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 23/08/23.
//

import UIKit
import ObjectMapper

class SchoolMatterCalenderVC: UIViewController {
    var schMatterCalenderObj: CalendarModel?
    @IBOutlet weak var calenderTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "School Matter Calendar")
        schMatterCalenderApi()
        // Do any additional setup after loading the view.
    }
   @objc func showPicAndPdf(sender: UIButton) {
       if schMatterCalenderObj?.response?[sender.tag].pic == nil {
           openImage(image: schMatterCalenderObj?.response?[sender.tag].pic ?? "")
       } else {
           openWebView(urlString: schMatterCalenderObj?.response?[sender.tag].file ?? "", viewController: self)
       }
    }
}
extension SchoolMatterCalenderVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if schMatterCalenderObj?.response?[indexPath.row].pic == nil {
            openImage(image: schMatterCalenderObj?.response?[indexPath.row].pic ?? "")
        } else {
            openWebView(urlString: schMatterCalenderObj?.response?[indexPath.row].file ?? "", viewController: self)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schMatterCalenderObj?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let calenderCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.schoolCalendarCell.getIdentifier, for: indexPath) as! SchoolCalenderTblCell
        calenderCell.schoolCalenderLbl.text = schMatterCalenderObj?.response?[indexPath.row].description
        calenderCell.schoolCalenderDateLbl.text = "Updated on: \(schMatterCalenderObj?.response?[indexPath.row].createddate ?? "")"
        calenderCell.arrowBtn.tag = indexPath.row
        calenderCell.arrowBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPicAndPdf(sender: ))))
        
        return calenderCell
    }
}
extension SchoolMatterCalenderVC {
    func schMatterCalenderApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Calendar_Month.getEndPoints).php?SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Calendar_Month.getEndPoints, apiRequestURL: strUrl)
    }
}

extension SchoolMatterCalenderVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Calendar_Month.getEndPoints {
            let status = response["status"] as? String
            if status == "true" {
                if let leaveRecordsDictData = Mapper<CalendarModel>().map(JSONObject: response) {
                    schMatterCalenderObj = leaveRecordsDictData
                    DispatchQueue.main.async {
                        self.calenderTblView.reloadData()
                    }
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
