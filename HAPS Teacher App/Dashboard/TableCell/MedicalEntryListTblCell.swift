//
//  MedicalEntryListTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 12/09/23.
//

import UIKit

class MedicalEntryListTblCell: UITableViewCell {
    
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var doseQualityLbl: UILabel!
    @IBOutlet weak var daysLbl: UILabel!
    @IBOutlet weak var doseLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var studentMedicalDetailView: UIView!
    @IBOutlet weak var hideShowDetailBtnOtl: UIButton!
    @IBOutlet weak var medicalDetailView: UIView!
    @IBOutlet weak var todateLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var diagnosisLbl: UILabel!
    @IBOutlet weak var bloodPLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var medicalHistoryLbl: UILabel!
    @IBOutlet weak var medicalAllergiesLbl: UILabel!
    @IBOutlet weak var admNoLbl: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var medicineDetailTblView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
//extension MedicalEntryListTblCell: UITableViewDataSource {
  //  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    print("row number is \(rowNumber)")
   //     return rowNumber
    //}
    
    //func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let medicalDetailCell = tableView.dequeueReusableCell(withIdentifier: AppTblVIndentifiers.medicalHistoryCell.getIdentifier, for: indexPath) as! MedicalHistoryTblCell
        //return medicalDetailCell
    //}
//}

