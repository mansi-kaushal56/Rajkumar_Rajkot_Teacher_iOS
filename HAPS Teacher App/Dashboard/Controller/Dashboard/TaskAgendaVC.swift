//
//  TaskAgendaVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 16/08/23.
//

import UIKit
import ObjectMapper

class TaskAgendaVC: UIViewController {
    var dailyAgendaObj : DailyAgendaModel?

    @IBOutlet weak var agendaTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Daily Task Agenda")
        taskAgendaApi()
        // Do any additional setup after loading the view.
    }

}
extension TaskAgendaVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyAgendaObj?.response?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let agendaCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.agendaCell.getIdentifier, for: indexPath) as! TaskAgendaTblCell
        agendaCell.taskAgendaView.clipsToBounds = true
        let agendaData = dailyAgendaObj?.response?.data?[indexPath.row]
        //agendaData?.item
        //agendaData?.item
        return agendaCell
    }
}
extension TaskAgendaVC {
    func taskAgendaApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Daily_Agenda.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Daily_Agenda.getEndPoints, apiRequestURL: strUrl)
    }
    
}
extension TaskAgendaVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Daily_Agenda.getEndPoints {
            let status = response["status"] as! Bool
            //let message = response["message"] as! String
            if status == true {
                if let dailyAgendaDictData = Mapper<DailyAgendaModel>().map(JSONObject: response) {
                    dailyAgendaObj = dailyAgendaDictData
                    DispatchQueue.main.async {
                        //self.leaveData()
                        self.agendaTblView.reloadData()
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
