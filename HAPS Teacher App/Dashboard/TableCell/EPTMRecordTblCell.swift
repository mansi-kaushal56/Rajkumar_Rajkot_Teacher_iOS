//
//  EPTMRecordTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 06/10/23.
//

import UIKit

class EPTMRecordTblCell: UITableViewCell {

    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var studentLbl: UILabel!
    @IBOutlet weak var talkWithLbl: UILabel!
    @IBOutlet weak var mobileNoLbl: UILabel!
    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var admissionLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var employeeNameLbl: UILabel!
    @IBOutlet weak var employeeDetailView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
