//
//  RequestForExtraDayVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/10/23.
//

import UIKit
import ObjectMapper

class RequestForExtraDayVC: UIViewController {
    var requestForExtraDayObj: RequestForExtraDayModel?
    var employeeLeaveStatusObj: MedicalEntryModel?
    @IBOutlet weak var requestExtraDayTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Request For Extra Day")
        extraDayApi()
        // Do any additional setup after loading the view.
    }
    @objc func cancelLeave() {
        
    }
    @objc func approveLeave() {
        
    }
}
extension RequestForExtraDayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestForExtraDayObj?.response?.rest?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let requestCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.extraDayForRequestCell.getIdentifier, for: indexPath) as! RequestForExtraDayTblCell
        requestCell.requestDetailView.clipsToBounds = true
        let requestData = requestForExtraDayObj?.response?.rest?[indexPath.row]
        requestCell.reasonLbl.text = requestData?.reason
        requestCell.requestByLbl.text = requestData?.EmpName
        requestCell.requestDateLbl.text = requestData?.date
        let approveTap = UITapGestureRecognizer(target: self, action: #selector(approveLeave))
        requestCell.approveView.addGestureRecognizer(approveTap)
        let cancelTap = UITapGestureRecognizer(target: self, action: #selector(cancelLeave))
        requestCell.cancelView.addGestureRecognizer(cancelTap)
        
        return requestCell
    }
}
extension RequestForExtraDayVC {
    func extraDayApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Request_For_Extra_Day.getEndPoints).php"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Request_For_Extra_Day.getEndPoints, apiRequestURL: strUrl)
    }
}
extension RequestForExtraDayVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Request_For_Extra_Day.getEndPoints {
            let status = response["status"] as? String
            if status == "true" {
                if let leaveRequestDictData = Mapper<RequestForExtraDayModel>().map(JSONObject: response) {
                    requestForExtraDayObj = leaveRequestDictData
                    DispatchQueue.main.async {
                        self.requestExtraDayTblView.reloadData()
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
