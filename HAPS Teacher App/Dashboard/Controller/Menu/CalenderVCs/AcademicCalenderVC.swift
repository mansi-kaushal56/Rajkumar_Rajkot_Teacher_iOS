//
//  AcademicCalenderVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 22/08/23.
//

import UIKit
import ObjectMapper

class AcademicCalenderVC: UIViewController {
    var calendarObj: CalendarModel?

    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var updatedOnLbl: UILabel!
    @IBOutlet weak var academicCalenderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Academic Calendar")
        academicCalendarApi()
        
        let downloadCalenderTap = UITapGestureRecognizer()
        academicCalenderView.addGestureRecognizer(downloadCalenderTap)
        downloadCalenderTap.addTarget(self, action: #selector(downloadCalender))
        // Do any additional setup after loading the view.
    }
    @objc func downloadCalender() {
        openWebView(urlString: calendarObj?.response?[0].file ?? "", viewController: self)
    }
    func showDescription() {
        descriptionLbl.text = calendarObj?.response?[0].description
        updatedOnLbl.text = "Updated on: \(calendarObj?.response?[0].createddate ?? "")"
    }
}
extension AcademicCalenderVC {
    func academicCalendarApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Calendar.getEndPoints).php?SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Calendar.getEndPoints, apiRequestURL: strUrl)
    }
}
extension AcademicCalenderVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Calendar.getEndPoints {
            let status = response["status"] as? String
            if status == "true" {
                if let calenderDictData = Mapper<CalendarModel>().map(JSONObject: response) {
                    calendarObj = calenderDictData
                    DispatchQueue.main.async {
                        self.showDescription()
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
