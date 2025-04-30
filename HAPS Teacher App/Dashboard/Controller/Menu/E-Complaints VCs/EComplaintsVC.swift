//
//  EComplaintsVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 13/09/23.
//

import UIKit

class EComplaintsVC: UIViewController {

    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var myEComplaintsView: UIView!
    @IBOutlet weak var eComplaintRecord: UIView!
    @IBOutlet weak var postEComplainttView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "E-Complaint")
        schoolNameLbl.text = "\(SchoolName.RKCRajkot), \(UserDefaults.getUserDetail()?.branchName ?? "")"
        
        let postComplaintTap = UITapGestureRecognizer()
        postEComplainttView.addGestureRecognizer(postComplaintTap)
        postComplaintTap.addTarget(self, action: #selector(postComplaint))
        
        let recordComplaintTap = UITapGestureRecognizer()
        eComplaintRecord.addGestureRecognizer(recordComplaintTap)
        recordComplaintTap.addTarget(self, action: #selector(recordComplaint))
        
        let myComplaintTap = UITapGestureRecognizer()
        myEComplaintsView.addGestureRecognizer(myComplaintTap)
        myComplaintTap.addTarget(self, action: #selector(myComplaint))
        // Do any additional setup after loading the view.
    }
    @objc func postComplaint() {
        performSegue(withIdentifier: AppStrings.AppSegue.postComplaintSegue.getDescription, sender: nil)
    }
    @objc func recordComplaint() {
        performSegue(withIdentifier: AppStrings.AppSegue.complaintRecordSegue.getDescription, sender: nil)
    }
    @objc func myComplaint() {
        performSegue(withIdentifier: AppStrings.AppSegue.myComplaintSegue.getDescription, sender: nil)
    }
}
