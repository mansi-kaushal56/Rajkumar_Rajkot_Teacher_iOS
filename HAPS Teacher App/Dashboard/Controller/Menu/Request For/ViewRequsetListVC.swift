//
//  ViewRequsetListVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 20/09/23.
//

import UIKit
import ObjectMapper
class ViewRequsetListVC: UIViewController {
    
//  (27-sep-2023)
    var extraDayEntryListObj : ExtraDayEntryListModel?
    @IBOutlet weak var requestDetailListTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Extra Day Request")
        extraDayRequestApi()
        
        // Do any additional setup after loading the view.
    }
    
}
extension ViewRequsetListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extraDayEntryListObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let requestDetailCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.requestDetailCell.getIdentifier, for: indexPath) as! ViewRequsetDetailTblCell
        requestDetailCell.requestDetailView.clipsToBounds = true
        
    //  (27-sep-2023)
        let  extraDayList = extraDayEntryListObj?.response?.rest?[indexPath.row]
        requestDetailCell.requestDateLbl.text = extraDayList?.date
        requestDetailCell.requestDescriptionLbl.text = extraDayList?.reason
        requestDetailCell.requsetBtLbl.text = extraDayList?.empName
        switch extraDayList?.status {
        case "Cancel":
            requestDetailCell.requestStatusLbl.text = extraDayList?.status
            requestDetailCell.requestStatusView.backgroundColor = .AppRed
        case "Pending":
            requestDetailCell.requestStatusLbl.text = extraDayList?.status
            requestDetailCell.requestStatusView.backgroundColor = .AppDarkOrange
        case "Approved":
            requestDetailCell.requestStatusLbl.text = extraDayList?.status
            requestDetailCell.requestStatusView.backgroundColor = .AppDarkGreen
        default:
            print("Unknown")
        }
        return requestDetailCell
    }
    
    
}
//  (27-sep-2023)

extension ViewRequsetListVC {
    func extraDayRequestApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Extra_Day_Request.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Extra_Day_Request.getEndPoints, apiRequestURL: strUrl)
    }
}

//  (27-sep-2023)
extension ViewRequsetListVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Extra_Day_Request.getEndPoints {
            let status = response["status"] as! String
           // let message = response["msg"] as! String
            if status == "true" {
                if let viewExtraDayRequestData = Mapper<ExtraDayEntryListModel>().map(JSONObject: response) {
                    extraDayEntryListObj = viewExtraDayRequestData
                    //print(studentCircularObj)
                    DispatchQueue.main.async {
                        self.requestDetailListTblView.reloadData()
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
