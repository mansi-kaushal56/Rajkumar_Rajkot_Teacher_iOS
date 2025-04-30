//
//  showCBOEntryTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 21/09/23.
//

import UIKit

class ShowCBOEntryTblCell: UITableViewCell {

    @IBOutlet weak var attendanceLbl: UILabel!
    @IBOutlet weak var attendanceView: UIView!
    @IBOutlet weak var admNoLbl: UILabel!
    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var marksTxtFld: UITextField!
    @IBOutlet weak var attendanceBtnOtl: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
