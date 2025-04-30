//
//  EmpComplaintRecordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/10/23.
//

import UIKit

class EmpComplaintRecordVC: UIViewController {

    @IBOutlet weak var pandingView: UIView!
    @IBOutlet weak var resolvedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "E-Complaint Record")
        
        let pandingTap = UITapGestureRecognizer()
        pandingView.addGestureRecognizer(pandingTap)
        pandingTap.addTarget(self, action: #selector(pandingComplaints))
        
        let resolveTag = UITapGestureRecognizer()
        resolvedView.addGestureRecognizer(resolveTag)
        resolveTag.addTarget(self, action: #selector(resolveComplaints))
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.pandingComplaintSegue.getDescription {
            if let destinationVC = segue.destination as? PandingResolveComplaintVC {
                if sender as! Int == 1 {
                    destinationVC.eComplaintType = "Pending"
                } else {
                    destinationVC.eComplaintType = "Resolve"
                }
            }
        }
    }
    @objc func pandingComplaints() {
        performSegue(withIdentifier: AppStrings.AppSegue.pandingComplaintSegue.getDescription, sender: 1)
    }
    @objc func resolveComplaints() {
        performSegue(withIdentifier: AppStrings.AppSegue.pandingComplaintSegue.getDescription, sender: 2)
    }
}
