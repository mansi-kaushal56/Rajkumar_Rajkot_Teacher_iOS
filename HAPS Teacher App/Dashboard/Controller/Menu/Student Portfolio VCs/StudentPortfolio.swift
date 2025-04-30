//
//  StudentPortfolio.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 01/09/23.
//

import UIKit

class StudentPortfolio: UIViewController {

    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var activityDetailView: UIView!
    @IBOutlet weak var sportsDetailView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Student Portfolio")
        schoolNameLbl.text = "\(SchoolName.RKCRajkot), \(UserDefaults.getUserDetail()?.branchName ?? "")"
        
        let sportsTap = UITapGestureRecognizer()
        sportsDetailView.addGestureRecognizer(sportsTap)
        sportsTap.addTarget(self, action: #selector(sportsDetail))
        
        let activityTap = UITapGestureRecognizer()
        activityDetailView.addGestureRecognizer(activityTap)
        activityTap.addTarget(self, action: #selector(activityDetail))
        // Do any additional setup after loading the view.
    }
    @objc func sportsDetail() {
        performSegue(withIdentifier: AppStrings.AppSegue.sportsDetailSegue.getDescription, sender: nil)
    }
    @objc func activityDetail() {
        performSegue(withIdentifier: AppStrings.AppSegue.activityDetailSegue.getDescription, sender: nil)
    }
    
    
}
