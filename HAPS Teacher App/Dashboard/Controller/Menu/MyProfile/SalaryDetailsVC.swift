//
//  SalaryDetailsVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 03/08/23.
//

import UIKit
import ObjectMapper

class SalaryDetailsVC: UIViewController {
    
    @IBOutlet weak var netSalaryView: ProfileViewBorder!
    @IBOutlet weak var deductionSalaryView: ProfileViewBorder!
    @IBOutlet weak var salaryDetailView: ProfileViewBorder!
    @IBOutlet weak var employeeDetailView: ProfileViewBorder!
    @IBOutlet weak var mySalaryDetailTblView: UITableView!
    @IBOutlet weak var monthAndYearLbl: UILabel!
    
    @IBOutlet weak var academyNameLbl: UILabel!
    @IBOutlet weak var empCodeLbl: UILabel!
    @IBOutlet weak var jobTypeLbl: UILabel!
    @IBOutlet weak var empNameLbl: UILabel!
    @IBOutlet weak var noOfDaysLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
    @IBOutlet weak var noOfPresentsLbl: UILabel!
    @IBOutlet weak var accountNoLbl: UILabel!
    @IBOutlet weak var extraDaysLbl: UILabel!
    @IBOutlet weak var UANnoLbl: UILabel!
    @IBOutlet weak var basicPayLbl: UILabel!
    @IBOutlet weak var grandePayLbl: UILabel!
    @IBOutlet weak var holidayPayLbl: UILabel!
    @IBOutlet weak var earningTotalLbl: UILabel!
    @IBOutlet weak var EPFLbl: UILabel!
    @IBOutlet weak var advanceSalaryLbl: UILabel!
    @IBOutlet weak var TDSLbl: UILabel!
    @IBOutlet weak var totalDeductionsLbl: UILabel!
    @IBOutlet weak var earningLbl: UILabel!
    @IBOutlet weak var deductionsLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
    var salaryID = String()
    var mySalaryDetailObj: MySalaryDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Salary Receipt")
        self.academyNameLbl.text = "\(SchoolName.RKCRajkot), \(UserDefaults.getUserDetail()?.branchName ?? "")"
        downloadBtn()
        mySalaryDetailAPI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        employeeDetailView.clipsToBounds = true
        salaryDetailView.clipsToBounds = true
        deductionSalaryView.clipsToBounds = true
        netSalaryView.clipsToBounds = true
    }
    
    func downloadBtn() {
        let downloadView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        downloadView.layer.cornerRadius = downloadView.frame.width / 2
        downloadView.backgroundColor = .white
        
        let downloadBtn = UIButton(frame: CGRect(x: 0, y: 0, width: downloadView.bounds.width, height: downloadView.bounds.height))
        downloadBtn.setImage(UIImage(named: "downloadBtn"), for: .normal)
        downloadBtn.addTarget(self, action: #selector(downloadRecieptBtn), for: .touchUpInside)
        downloadView.addSubview(downloadBtn)
        let download = UIBarButtonItem(customView: downloadView)
        navigationItem.rightBarButtonItem = download
    }
    func showLblsData() {
        empCodeLbl.text = mySalaryDetailObj?.empCode
        jobTypeLbl.text = mySalaryDetailObj?.employeeTypeName
        empNameLbl.text = mySalaryDetailObj?.empName
        noOfDaysLbl.text = mySalaryDetailObj?.totalWorkingDays
        designationLbl.text = mySalaryDetailObj?.designationName
        noOfPresentsLbl.text = mySalaryDetailObj?.totalPresentDays
        accountNoLbl.text = mySalaryDetailObj?.aCCNO
        extraDaysLbl.text = mySalaryDetailObj?.extraDays
        UANnoLbl.text = mySalaryDetailObj?.uANNo
        basicPayLbl.text = mySalaryDetailObj?.actualBasicSalary
        grandePayLbl.text = mySalaryDetailObj?.gradePay
        holidayPayLbl.text = mySalaryDetailObj?.extraDaysPay
        earningTotalLbl.text = mySalaryDetailObj?.grossPay
        EPFLbl.text = mySalaryDetailObj?.ePF
        advanceSalaryLbl.text = mySalaryDetailObj?.advSalary
        TDSLbl.text = mySalaryDetailObj?.tDS
        totalDeductionsLbl.text = mySalaryDetailObj?.totalDeductions
        earningLbl.text = mySalaryDetailObj?.grossPay
        deductionsLbl.text = mySalaryDetailObj?.totalDeductions
        totalLbl.text = mySalaryDetailObj?.netSalary
    }
    @objc func downloadRecieptBtn() {
        let url = (mySalaryDetailObj?.file ?? "")
        openWebView(urlString: url, viewController: self)
    }
}
extension SalaryDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySalaryDetailObj?.earnings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let earningDetailCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.earningDetailCell.getIdentifier, for: indexPath) as! EarningDetailTblVCell
        earningDetailCell.earningNameLbl.text = mySalaryDetailObj?.earnings?[indexPath.row].name
        earningDetailCell.earningValueLbl.text = mySalaryDetailObj?.earnings?[indexPath.row].value
        
        return earningDetailCell
    }
}

extension SalaryDetailsVC {
    func mySalaryDetailAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_GenerateSalary.getEndPoints).php?SalaryID=\(salaryID)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_GenerateSalary.getEndPoints, apiRequestURL: strUrl)
    }
}
extension SalaryDetailsVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_GenerateSalary.getEndPoints {
            let status = response["status"] as! String
            let message = response["message"] as! String
            if status == "Success" {
                if let mySalaryDictData = Mapper<MySalaryDetailModel>().map(JSONObject: response) {
                    mySalaryDetailObj = mySalaryDictData
                    DispatchQueue.main.async {
                        self.showLblsData()
                        self.mySalaryDetailTblView.reloadData()
                        self.monthAndYearLbl.text = "Pay Slip for the Month of \(self.mySalaryDetailObj?.month ?? "") \(self.mySalaryDetailObj?.year ?? "")"
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
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
