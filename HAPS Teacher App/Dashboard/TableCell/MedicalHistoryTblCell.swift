//
//  MedicalHistoryTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 12/09/23.
//

import UIKit

class MedicalHistoryTblCell: UITableViewCell {

    @IBOutlet weak var actionBtnOtl: UIButton!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var doseQtyLbl: UILabel!
    @IBOutlet weak var doseLbl: UILabel!
    @IBOutlet weak var daysLbl: UILabel!
    @IBOutlet weak var medicineLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
