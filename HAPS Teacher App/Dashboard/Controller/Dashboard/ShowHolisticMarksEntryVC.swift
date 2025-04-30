//
//  ShowHolisticMarksEntryVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 21/09/23.
//

import UIKit

class ShowHolisticMarksEntryVC: UIViewController {

    @IBOutlet weak var totalStudentLbl: UILabel!
    @IBOutlet weak var holisticEntryTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Holistic Marks Entry")
        // Do any additional setup after loading the view.
    }
    @IBAction func lockGradeBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func saveGradeBtnAction(_ sender: UIButton) {
    }
}
extension ShowHolisticMarksEntryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let holisticEntryCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.holisticEntryCell.getIdentifier, for: indexPath) as! HolisticMarksEntryTblCell
        holisticEntryCell.studentDetailView.clipsToBounds = true
        return holisticEntryCell
    }
    
    
}
