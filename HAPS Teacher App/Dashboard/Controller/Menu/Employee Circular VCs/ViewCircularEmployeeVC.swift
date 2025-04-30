//
//  ViewCircularEmployeeVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 07/09/23.
//

import UIKit
import ObjectMapper
import Kingfisher

class ViewCircularEmployeeVC: UIViewController {
    
    @IBOutlet weak var pdfLinkLbl: UILabel!
    @IBOutlet weak var circularImgView: UIImageView!
    @IBOutlet weak var sendImageView: UIView!
    @IBOutlet weak var pdfView: UIView!
    @IBOutlet weak var circularByLbl: UILabel!
    @IBOutlet weak var circularDateLbl: UILabel!
    @IBOutlet weak var circularTitleLbl: UILabel!
    @IBOutlet weak var circularDetailView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var viewEmpCircularObj: ViewCircularModel?
    var circularTitle: String?
    var selCircularId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewRecordBtn()
        backBtn(title: "View Circular")
        viewCircularsAPI()
        self.circularDetailView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.circularStatusSegue.getDescription {
            if let destinationVC = segue.destination as? CircularReadStatusVC {
                destinationVC.selUniqueId = viewEmpCircularObj?.unique_id
            }
        }
    }
    func viewRecordBtn() {
        let viewRecordButton = UIBarButtonItem(image: UIImage.readIcon, style: .plain, target: self, action: #selector(ViewRecord))
        navigationItem.rightBarButtonItem = viewRecordButton
    }
    @objc func ViewRecord() {
        performSegue(withIdentifier: AppStrings.AppSegue.circularStatusSegue.getDescription, sender: nil)
    }
    @objc func openPdf(sender:UITapGestureRecognizer) {
        openWebView(urlString:viewEmpCircularObj?.extraFile ?? "", viewController: self)
    }
    @objc func imgViewTapped(sender:UITapGestureRecognizer) {
        openImage(image: viewEmpCircularObj?.file ?? "")
    }
    func viewEmpCircularData() {
//        branchLbl.text = UserDefaults.getUserDetail()?.BranchId ?? ""
//        employeeTypeLbl.text = UserDefaults.getUserDetail()?.EmpCategory ?? ""
        circularByLbl.text = viewEmpCircularObj?.empName
        circularDateLbl.text = viewEmpCircularObj?.created_Date
        circularTitleLbl.text = circularTitle
        descriptionLbl.text = viewEmpCircularObj?.description
        pdfLinkLbl.text = viewEmpCircularObj?.extraFile
        
        let img = (viewEmpCircularObj?.file ?? "")
        let imgUrl = URL(string: img)
        circularImgView.kf.setImage(with: imgUrl)
        
        let pdfLblTap = UITapGestureRecognizer()
        pdfLinkLbl.addGestureRecognizer(pdfLblTap)
        pdfLblTap.addTarget(self, action: #selector(openPdf(sender: )))
        
        let imgViewTap = UITapGestureRecognizer()
        circularImgView.addGestureRecognizer(imgViewTap)
        imgViewTap.addTarget(self, action: #selector(imgViewTapped(sender: )))
        
        switch viewEmpCircularObj?.fileType {
        case "pdf":
            sendImageView.isHidden = true
            pdfView.isHidden = false
        case "jpg":
            sendImageView.isHidden = false
            pdfView.isHidden = true
            //Date:: 12, Apr 2024 - jpeg check added
        case "jpeg":
            sendImageView.isHidden = false
            pdfView.isHidden = true
        default :
            sendImageView.isHidden = true
            pdfView.isHidden = true
            
        }
    }
}
extension ViewCircularEmployeeVC {
    func viewCircularsAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_View_Circular_Staff.getEndPoints).php?id=\(selCircularId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_View_Circular_Staff.getEndPoints, apiRequestURL: strUrl)
    }
}
extension ViewCircularEmployeeVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_View_Circular_Staff.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let viewcircularDictData = Mapper<ViewCircularModel>().map(JSONObject: response) {
                    viewEmpCircularObj = viewcircularDictData
                    DispatchQueue.main.async {
                        self.viewEmpCircularData()
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

