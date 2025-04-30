//
//  DisciplineVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 11/09/23.
//

import UIKit

class DisciplineVC: UIViewController {

    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var schoolBranchLbl: UILabel!
    @IBOutlet weak var frownyView: UIView!
    @IBOutlet weak var smileyView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Discipline")
        schoolBranchLbl.text = "\(UserDefaults.getUserDetail()?.branchName ?? "")"
        //Date:: 22, Apr 2024 - schoolNameLbl added
        schoolNameLbl.text = SchoolName.RKCRajkot
        
        let smileyTap = UITapGestureRecognizer()
        smileyView.addGestureRecognizer(smileyTap)
        smileyTap.addTarget(self, action: #selector(smileyFeedbackPage))
        
        let frownyTap = UITapGestureRecognizer()
        frownyView.addGestureRecognizer(frownyTap)
        frownyTap.addTarget(self, action: #selector(frownyFeedbackPage))
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.AppSegue.feedBackSegue.getDescription {
            if let destinationVC = segue.destination as? FeedbackTypeVC {
                if sender as! Int == 1 {
                    destinationVC.feedbackType = "Smiley"
                } else {
                    destinationVC.feedbackType = "Frowny"
                }
            }
        }
    }
    @objc func smileyFeedbackPage() {
        performSegue(withIdentifier: AppStrings.AppSegue.feedBackSegue.getDescription, sender: 1)
    }
    @objc func frownyFeedbackPage() {
        performSegue(withIdentifier: AppStrings.AppSegue.feedBackSegue.getDescription, sender: 2)
    }
    
}
