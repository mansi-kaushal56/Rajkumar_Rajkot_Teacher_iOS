//
//  PTMRecordTableCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 28/08/23.
//

import UIKit

class PTMRecordTableCell: UITableViewCell {

    @IBOutlet weak var areaLblPlaceHolder: UILabel!
    @IBOutlet weak var areaOrLbl: UILabel!
    @IBOutlet weak var ptmRecordView: UIView!
    @IBOutlet weak var admissionNoLbl: UILabel!
    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var mobileNoLbl: UILabel!
    @IBOutlet weak var talkWithLbl: UILabel!
    @IBOutlet weak var modeLbl: UILabel!
    @IBOutlet weak var pSatisfactionLbl: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
