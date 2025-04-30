//
//  HolisticMarksEntryTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 21/09/23.
//

import UIKit

class HolisticMarksEntryTblCell: UITableViewCell {

    @IBOutlet weak var studentDetailView: UIView!
    @IBOutlet weak var remarkTxtFld: UITextField!
    @IBOutlet weak var gradeMarksLbl: UILabel!
    @IBOutlet weak var gradeMarksView: UIView!
    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var fnameLbl: UILabel!
    @IBOutlet weak var admNoLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
