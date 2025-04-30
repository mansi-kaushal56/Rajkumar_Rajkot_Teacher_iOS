//
//  SportsEntryListVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 04/09/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class SportsEntryListVC: UIViewController {
    
    var sportsEntryListObj: SportsEntryListModel?
    
    @IBOutlet weak var sportsEntryListTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Sports Entry List")
        sportsEntryListApi()
        
        sportsEntryListTblView.emptyDataSetSource = self
        sportsEntryListTblView.emptyDataSetDelegate = self
        // Do any additional setup after loading the view.
    }
    @objc func showImage(sender:UITapGestureRecognizer) {
        openImage(image:sportsEntryListObj?.response?.rest?[sender.view?.tag ?? 0].file ?? "")
    }
    @objc func delSportsEntry(_ sender:UIButton) {
        delSportsEntryListApi(id:sportsEntryListObj?.response?.rest?[sender.tag ].id ?? "")
    }
}
extension SportsEntryListVC : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage(str: AppMessages.MSG_NO_LIST_FOUND)
    }
}
extension SportsEntryListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportsEntryListObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sportsListCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.sportsCell.getIdentifier, for: indexPath) as! SportsEntryListTblCell
        sportsListCell.sportsListView.clipsToBounds = true
        let sportsListData = sportsEntryListObj?.response?.rest?[indexPath.row]
        sportsListCell.descriptionLabel.text = sportsListData?.des ?? "-"
        sportsListCell.activityLabel.text = sportsListData?.sportsName ?? "-"
        sportsListCell.calegoryLabel.text = sportsListData?.category ?? "-"
        sportsListCell.levelLabel.text = sportsListData?.level ?? "-"
        sportsListCell.awardLabel.text = sportsListData?.prizeWon ?? "-"
        sportsListCell.yearLabel.text = sportsListData?.year ?? "-"
        sportsListCell.admNoLabel.text = sportsListData?.adminno ?? "-"
        sportsListCell.studentNameLbl.text = sportsListData?.stname ?? "-"
        let img = "\(sportsListData?.file ?? "")"
        let imagURL = URL(string: img)
        sportsListCell.uploadImageView.kf.setImage(with: imagURL)
       
        if sportsListData?.file == "" {
            sportsListCell.imgView.isHidden = true
        } else {
            sportsListCell.imgView.isHidden = false
        }
        sportsListCell.uploadImageView.tag = indexPath.row
        sportsListCell.deleteBtnOtl.tag = indexPath.row
        sportsListCell.deleteBtnOtl.addTarget(self, action: #selector(delSportsEntry(_: )), for: .touchUpInside)
       
        let imgtapGesture = UITapGestureRecognizer()
        sportsListCell.uploadImageView.addGestureRecognizer(imgtapGesture)
        imgtapGesture.addTarget(self, action: #selector(showImage(sender: )))
        
        return sportsListCell
    }
}
extension SportsEntryListVC {
    func sportsEntryListApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Sports_Entry_List.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&empcode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Sports_Entry_List.getEndPoints, apiRequestURL: strUrl)
    }
    func delSportsEntryListApi(id:String) {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Sports_Entry_Delete.getEndPoints).php?id=\(id)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Sports_Entry_Delete.getEndPoints, apiRequestURL: strUrl)
    }
}
extension SportsEntryListVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Sports_Entry_List.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let sportsEntryListDictData = Mapper<SportsEntryListModel>().map(JSONObject: response) {
                    sportsEntryListObj = sportsEntryListDictData
                    DispatchQueue.main.async {
                        self.sportsEntryListTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message, controller: self)
                }
            }
        }
        if api == END_POINTS.Api_Sports_Entry_Delete.getEndPoints {
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
