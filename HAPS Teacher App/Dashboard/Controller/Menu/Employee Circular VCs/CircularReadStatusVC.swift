//
//  CircularReadStatusVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 07/09/23.
//

import UIKit
import ObjectMapper

class CircularReadStatusVC: UIViewController {
    var selUniqueId: String?
    var readStatusObj: ReadStatusListModel?
    
    @IBOutlet weak var circularStatusListTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Circular Read Status")
        readStatusAPI()
        // Do any additional setup after loading the view.
    }
}
extension CircularReadStatusVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readStatusObj?.response?.res?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let statusCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.circularStatusCell.getIdentifier, for: indexPath) as! CircularStatusTblCell
        statusCell.statusLbl.text = readStatusObj?.response?.res?[indexPath.row].status
        statusCell.empCodeLbl.text = "Emp Code - \(readStatusObj?.response?.res?[indexPath.row].staffcode ?? "")"
        statusCell.nameLbl.text =  readStatusObj?.response?.res?[indexPath.row].staff
        switch readStatusObj?.response?.res?[indexPath.row].status {
        case "Unread":
            statusCell.statusLbl.textColor = .red
            statusCell.statusView.backgroundColor = .red
        case "Read":
            statusCell.statusLbl.textColor = .AppLightGreen
            statusCell.statusView.backgroundColor = .AppLightGreen
        default:
            print("Unknown Status")
        }
        return statusCell
    }
}
extension CircularReadStatusVC {
    
    func readStatusAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Info_Read_Status.getEndPoints).php?unique_id=\(selUniqueId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Info_Read_Status.getEndPoints, apiRequestURL: strUrl)
    }
}
extension CircularReadStatusVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Info_Read_Status.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let viewcircularDictData = Mapper<ReadStatusListModel>().map(JSONObject: response) {
                    readStatusObj = viewcircularDictData
                    DispatchQueue.main.async {
                        self.circularStatusListTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
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
