//
//  MySalaryVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 01/08/23.
//

import UIKit
import ObjectMapper

class MySalaryVC: UIViewController {

    @IBOutlet weak var salaryTblView: UITableView!
    var mySalaryObj : MySalaryModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "My Salary")
        mySalaryAPI()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.salaryRecieptSegue.getDescription {
            if let destinationVC = segue.destination as? SalaryDetailsVC {
                destinationVC.salaryID = mySalaryObj?.response?.rest?[view.tag].salaryID ?? ""
            }
        }
    }
    @objc func salaryViewBtn(sender:UIButton){
        performSegue(withIdentifier: AppStrings.AppSegue.salaryRecieptSegue.getDescription, sender: sender.tag)
    }
    
    
//    @IBAction func salaryViewBtn(_ sender: UIButton) {
//        performSegue(withIdentifier: AppSegue.salaryRecieptSegue.getDescription, sender: nil)
//    }
}
extension MySalaryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySalaryObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mySalaryCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.mySalaryCell.getIdentifier, for: indexPath) as! MySalaryTblCell
        let mySalaryData = mySalaryObj?.response?.rest?[indexPath.row]
        var monthTitle = ""

        mySalaryCell.salaryAmountLbl.text = mySalaryData?.netSalary
        mySalaryCell.salaryYearLbl.text = mySalaryData?.year
        
        if let monthNumber = Int(mySalaryData?.month ?? "") {
            let monthTitles = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
            monthTitle = monthTitles[monthNumber - 1]
        } else {
            print("Invalid Month")
        }
        mySalaryCell.viewbtn.tag = indexPath.row
        mySalaryCell.salaryMonthLbl.text = monthTitle
        mySalaryCell.viewbtn.addTarget(self, action: #selector(salaryViewBtn(sender: )), for: .touchUpInside)
        return mySalaryCell
    }
}
extension MySalaryVC {
    func mySalaryAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_SalaryList.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_SalaryList.getEndPoints, apiRequestURL: strUrl)
    }
}
extension MySalaryVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_SalaryList.getEndPoints {
            let status = response["status"] as! String
            let message = response["message"] as! String
            if status == "Success" {
                if let mySalaryDictData = Mapper<MySalaryModel>().map(JSONObject: response) {
                    mySalaryObj = mySalaryDictData
                    DispatchQueue.main.async {
                        self.salaryTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
                }            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
