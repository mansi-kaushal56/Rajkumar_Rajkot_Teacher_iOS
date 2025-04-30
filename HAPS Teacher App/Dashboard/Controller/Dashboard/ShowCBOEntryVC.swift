//
//  ShowCBOEntryVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 21/09/23.
//

import UIKit

class ShowCBOEntryVC: UIViewController {
    
    @IBOutlet weak var totalStudentLbl: UILabel!
    @IBOutlet weak var testDetailLbl: UILabel!
    @IBOutlet weak var classDetailLbl: UILabel!
    @IBOutlet weak var cboEntryTblView: UITableView!
    var attendType: String?
    var studentAttend: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "CBO Entry")
        // Do any additional setup after loading the view.
    }
    @objc func attendanceVC(sender: UITapGestureRecognizer) {
        studentAttend = sender.view?.tag
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.marksEntryAttendancevc.getIdentifier) as! MarksEntryAttendanceVC
        vc.delegate = self
        //vc.indexPath = sender.view?.tag
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func saveMarksBtnAction(_ sender: UIButton) {
    }
    @IBAction func lockMarksBtnAction(_ sender: UIButton) {
    }
}
extension ShowCBOEntryVC: AttendenceDelegate {
    func attendence(index: Int?, data: StudentDetailListRest?) {
        
    }
    
    func attendence(studentAttend : String?) {
//        attendType = attendenceType
//        print(attendenceType ?? "")
        cboEntryTblView.reloadData()
    }
}
extension ShowCBOEntryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cboEntryCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.showCBOEntryCell.getIdentifier, for: indexPath) as! ShowCBOEntryTblCell
        let cboAttendTap = UITapGestureRecognizer()
        cboEntryCell.attendanceView.addGestureRecognizer(cboAttendTap)
        cboAttendTap.addTarget(self, action: #selector(attendanceVC))
        cboEntryCell.attendanceView.tag = indexPath.row
        if indexPath.row == studentAttend {
            cboEntryCell.attendanceLbl.text = attendType
                //cboEntryTblView.reloadData()
        }
        //cboEntryCell.attendanceBtnOtl.addTarget(self, action: #selector(attendanceVC), for: .touchUpInside)
        return cboEntryCell
    }
    
    
}
