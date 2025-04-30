//
//  DocumentForMeVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 10/08/23.
//

import UIKit
import ObjectMapper
import Kingfisher

class DocumentForMeVC: UIViewController {

    var documentsForMeObj: DocumentsForMeModel?
    @IBOutlet weak var documentTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn(title: "Document For Me")
        viewDocForMeAPI()
        // Do any additional setup after loading the view.
    }
    @objc func viewPdf(_ sender:UITapGestureRecognizer){
        openWebView(urlString: documentsForMeObj?.response?.rest?[view.tag].extraFile ?? "", viewController: self)
    }
    @objc func viewImg(_ sender:UITapGestureRecognizer) {
        openImage(image: documentsForMeObj?.response?.rest?[sender.view?.tag ?? 0].file ?? "")
    }
}
extension DocumentForMeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentsForMeObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let documentCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.documentCell.getIdentifier, for: indexPath) as! ViewDocumentTblCell
        documentCell.viewDocumentView.clipsToBounds = true
        let documentData = documentsForMeObj?.response?.rest?[indexPath.row]
        documentCell.assignedByLbl.text = documentData?.date
        documentCell.documentTitleLbl.text = documentData?.title
        documentCell.assignedByLbl.text = documentData?.sendername
        let img = (documentData?.file ?? "")
        let imgUrl = URL(string: img.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        documentCell.documentImgView.kf.setImage(with: imgUrl)
        switch documentData?.fileType {
        case "jpg":
            documentCell.viewAttachmentView.isHidden = true
            documentCell.viewAttachmentImgView.isHidden = false
        case "png":
            documentCell.viewAttachmentView.isHidden = false
            documentCell.viewAttachmentImgView.isHidden = true
            documentCell.viewAttachmentView.tag = indexPath.row
            documentCell.viewAttachmentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewPdf(_:))))
            
        default :
            documentCell.viewAttachmentView.isHidden = true
            documentCell.viewAttachmentImgView.isHidden = true
        }
        documentCell.tag = indexPath.row
        documentCell.viewAttachmentImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewImg(_:))))
        return documentCell
    }
}

extension DocumentForMeVC {
    func viewDocForMeAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Upload_For_Me.getEndPoints).php?SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&login_user=\("711")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Upload_For_Me.getEndPoints, apiRequestURL: strUrl)
    }
}
extension DocumentForMeVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Upload_For_Me.getEndPoints {
            let status = response["status"] as! Int
            let message = response["msg"] as! String
            if status == 1 {
                if let documentsForMeDictData = Mapper<DocumentsForMeModel>().map(JSONObject: response) {
                    documentsForMeObj = documentsForMeDictData
                    DispatchQueue.main.async {
                        self.documentTblView.reloadData()
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
