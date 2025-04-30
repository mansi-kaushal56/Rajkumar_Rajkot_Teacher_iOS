//
//  ActivityEntryListVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 04/09/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class ActivityEntryListVC: UIViewController {
    
    var activityEntryListObj: ActivityEntryListModel?

    @IBOutlet weak var activityListTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Activity Entry List")
        activityEntryListApi()
        
        activityListTblView.emptyDataSetSource = self
        activityListTblView.emptyDataSetDelegate = self
        
        // Do any additional setup after loading the view.
    }
    @objc func showImage(sender:UITapGestureRecognizer) {
        openImage(image:activityEntryListObj?.response?.rest?[sender.view?.tag ?? 0].file ?? "")
    }
    @objc func delActivityEntry(_ sender:UIButton) {
        delActivityEntryListApi(id:activityEntryListObj?.response?.rest?[sender.tag ].id ?? "")
    }
    
}
extension ActivityEntryListVC : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage(str: AppMessages.MSG_NO_LIST_FOUND)
    }
}
extension ActivityEntryListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityEntryListObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activityListCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.activityCell.getIdentifier, for: indexPath) as! ActivityEntryListTblCell
        activityListCell.activityListView.clipsToBounds = true
        let activityListData = activityEntryListObj?.response?.rest?[indexPath.row]
        activityListCell.descriptionLabel.text = activityListData?.des
//        activityListCell.uploadOnLabel.text = activityListData.
        activityListCell.activityLabel.text = "\(activityListData?.activity ?? "")"
        activityListCell.categoryLabel.text = "\(activityListData?.category ?? "")"
        activityListCell.levelLabel.text = "\(activityListData?.level ?? "")"
        activityListCell.prizeWonLabel.text = "\(activityListData?.prizeWon ?? "")"
        activityListCell.yearLabel.text = "\(activityListData?.year ?? "")"
        activityListCell.admNoLabel.text = "\(activityListData?.adminno ?? "")"
        activityListCell.studentNameLabel.text = "\(activityListData?.stname ?? "")"
        let img = "\(activityListData?.file ?? "")"
        let imagURL = URL(string: img)
        activityListCell.uploadImageView.kf.setImage(with: imagURL)
       
        if activityListData?.file == "" {
            activityListCell.imgView.isHidden = true
        } else {
            activityListCell.imgView.isHidden = false
        }
        activityListCell.uploadImageView.tag = indexPath.row
        activityListCell.deleteBtnOtl.tag = indexPath.row
        activityListCell.deleteBtnOtl.addTarget(self, action: #selector(delActivityEntry(_: )), for: .touchUpInside)
       
        let imgtapGesture = UITapGestureRecognizer()
        activityListCell.uploadImageView.addGestureRecognizer(imgtapGesture)
        imgtapGesture.addTarget(self, action: #selector(showImage(sender: )))
        
        return activityListCell
    }
}
extension ActivityEntryListVC {
    func activityEntryListApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Activity_Entry_List.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Activity_Entry_List.getEndPoints, apiRequestURL: strUrl)
    }
    func delActivityEntryListApi(id:String) {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Activity_Entry_Delete.getEndPoints).php?id=\(id)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Activity_Entry_Delete.getEndPoints, apiRequestURL: strUrl)
    }
}
extension ActivityEntryListVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Activity_Entry_List.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let activityEntryListDictData = Mapper<ActivityEntryListModel>().map(JSONObject: response) {
                    activityEntryListObj = activityEntryListDictData
                    DispatchQueue.main.async {
                        self.activityListTblView.reloadData()
                    }
                }
            }
        }
        if api == END_POINTS.Api_Activity_Entry_Delete.getEndPoints {
            let status = response["status"] as! String
            if status == "true" {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
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
