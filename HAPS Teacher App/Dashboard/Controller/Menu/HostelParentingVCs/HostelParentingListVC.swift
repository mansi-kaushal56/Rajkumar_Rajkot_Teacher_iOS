//
//  HostelParentingListVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/08/23.
//

import UIKit
import ObjectMapper

class HostelParentingListVC: UIViewController {
    
    var hostelParentingObj : ShowHostelParentingModel?
    @IBOutlet weak var hostelListTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Hostel Parenting")
        showHostelParentingApi()
        // Do any additional setup after loading the view.
    }
}
extension HostelParentingListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hostelParentingObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hostelParentingCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.hostelListCell.getIdentifier, for: indexPath) as! HostelListTblCell
        hostelParentingCell.hotelListView.clipsToBounds = true
        let hostelParentingData = hostelParentingObj?.response?.rest?[indexPath.row]
        hostelParentingCell.dueDateLbl.text = "Date: \(hostelParentingData?.date ?? "")"
        hostelParentingCell.studentDetailLbl.text = hostelParentingData?.studentName
        hostelParentingCell.descriptionLbl.text = hostelParentingData?.description
        hostelParentingCell.sectionLbl.text = hostelParentingData?.sectionName
        hostelParentingCell.classLbl.text = hostelParentingData?.className
        hostelParentingCell.admissionNoLbl.text =  hostelParentingData?.enrollNo
        return hostelParentingCell
    }
}
extension HostelParentingListVC {
    func showHostelParentingApi() {
        CommonObjects.shared.showProgress()
        
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Show_Hostel_Parenting.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Show_Hostel_Parenting.getEndPoints, apiRequestURL: strUrl)
    }
    
}
extension HostelParentingListVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Show_Hostel_Parenting.getEndPoints {
            let status = response["status"] as! String
            if status == "SUCCESS" {
                if let hostelParentingDictData = Mapper<ShowHostelParentingModel>().map(JSONObject: response) {
                    hostelParentingObj = hostelParentingDictData
                    DispatchQueue.main.async {
                        self.hostelListTblView.reloadData()
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
