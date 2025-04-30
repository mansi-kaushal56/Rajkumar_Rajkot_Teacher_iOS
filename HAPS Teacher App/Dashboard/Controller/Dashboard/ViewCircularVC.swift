//
//  ViewCircularVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 10/08/23.
//

import UIKit
import ObjectMapper
import Kingfisher

class ViewCircularVC: UIViewController {
    var selCircularId: String?
    var viewcircularObj: ViewCircularModel?
    @IBOutlet weak var viewCircularTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "View Circular")
        viewCircularsAPI()
        // Do any additional setup after loading the view.
    }
    @objc func showImg(){
        openImage(image: viewcircularObj?.file ?? "")
    }
    @objc func openPDF(){
        openWebView(urlString: viewcircularObj?.extraFile?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "", viewController: self)
    }
    
}
extension ViewCircularVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewCircularCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.viewCircularCell.getIdentifier, for: indexPath) as! ViewCircularTblCell
        viewCircularCell.viewCircularView.clipsToBounds = true
        viewCircularCell.branchLblOtl.text = UserDefaults.getUserDetail()?.branchName
        viewCircularCell.circularByLblOtl.text = viewcircularObj?.empName
        viewCircularCell.circularDateLblOtl.text = viewcircularObj?.created_Date
        viewCircularCell.descriptionLblOtl.text = viewcircularObj?.description
        viewCircularCell.employeeTypeLblOtl.text = UserDefaults.getUserDetail()?.EmpTypeID
        viewCircularCell.circularImgView.tag = indexPath.row
        viewCircularCell.viewAttachmentView.tag = indexPath.row
        let img = (viewcircularObj?.file ?? "")
        let imgUrl = URL(string: img.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        viewCircularCell.circularImgView.kf.setImage(with: imgUrl)
        switch viewcircularObj?.fileType {
        case "jpg":
            viewCircularCell.viewAttachmentView.isHidden = true
            viewCircularCell.viewAttachmentImgView.isHidden = false
        case "pdf":
            viewCircularCell.viewAttachmentImgView.isHidden = true
            viewCircularCell.viewAttachmentView.isHidden = false
        default:
            viewCircularCell.viewAttachmentImgView.isHidden = true
            viewCircularCell.viewAttachmentView.isHidden = true
        }
        viewCircularCell.circularImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showImg)))
        viewCircularCell.viewAttachmentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPDF)))
        return viewCircularCell
    }
}
extension ViewCircularVC {
    func viewCircularsAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_View_Circular_Staff.getEndPoints).php?id=\(selCircularId ?? "")&SessionId=\("25")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_View_Circular_Staff.getEndPoints, apiRequestURL: strUrl)
    }
}
extension ViewCircularVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_View_Circular_Staff.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let viewcircularDictData = Mapper<ViewCircularModel>().map(JSONObject: response) {
                    viewcircularObj = viewcircularDictData
                    DispatchQueue.main.async {
                        self.viewCircularTbl.reloadData()
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
