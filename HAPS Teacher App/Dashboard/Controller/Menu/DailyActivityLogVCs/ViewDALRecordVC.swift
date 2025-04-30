//
//  ViewDALRecordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 23/08/23.
//

import UIKit
import ObjectMapper

class ViewDALRecordVC: UIViewController {

    var dailyActLogObj: DailyActLogModel?
    
//    @IBOutlet weak var monthTxtFld: UITextField!
//    @IBOutlet weak var yearTxtFld: UITextField!
//    @IBOutlet weak var searchView: UIView!
//    @IBOutlet weak var monthView: UIView!
//    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var avtiveLogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "My DAL Record")
        viewDALRecordApi()
//        let searchViewTap = UITapGestureRecognizer()
//        searchView.addGestureRecognizer(searchViewTap)
//        searchViewTap.addTarget(self, action: #selector(serachViewAction))
        // Do any additional setup after loading the view.
    }
//    @objc func serachViewAction() {
//
//    }
    //Date:: 12, Apr 2024 - show Pdf from dailyActLogObj
    @objc func showPdf(sender:UITapGestureRecognizer) {
        openWebView(urlString: dailyActLogObj?.response?.rest?[sender.view?.tag ?? 0].file?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "", viewController: self)
    }
}
extension ViewDALRecordVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyActLogObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let logCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.viewActiveLogCell.getIdentifier, for: indexPath) as! ViewActiveLogTblCell
        logCell.viewActiveLogView.clipsToBounds = true
        let dailyActData = dailyActLogObj?.response?.rest?[indexPath.row]
            logCell.dailyActData = dailyActData
        //Date:: 12, Apr 2024 - file check added to show the image and pdf
        logCell.viewAttachmentView.tag = indexPath.row
        logCell.viewAttachmentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPdf(sender:))))
        
        if dailyActData?.file == "" {
            logCell.viewAttachmentView.isHidden = true
        } else {
            logCell.viewAttachmentView.isHidden = false

        }
        // ------
        return logCell
    }
}
extension ViewDALRecordVC {
    func viewDALRecordApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Daily_Activity_Log.getEndPoints).php?SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Daily_Activity_Log.getEndPoints, apiRequestURL: strUrl)
    }
    }
extension ViewDALRecordVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Daily_Activity_Log.getEndPoints {
            if let status = response["status"] as? String , status == "true"{
                if let dailyActLogDictData = Mapper<DailyActLogModel>().map(JSONObject: response) {
                    dailyActLogObj = dailyActLogDictData
                    DispatchQueue.main.async {
                        self.avtiveLogTableView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Daily_Activity.getEndPoints {
            let status = response["status"] as? Bool
            if status == true {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_LOGIN_FAIL, controller: self)
                    self.navigationController?.popViewController(animated: true)
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
