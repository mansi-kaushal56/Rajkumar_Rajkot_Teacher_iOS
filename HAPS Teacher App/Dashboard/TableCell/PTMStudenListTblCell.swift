//
//  PTMStudenListTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 01/09/23.
//

import UIKit

class PTMStudenListTblCell: UITableViewCell {

    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var sessionLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var admissionNoLbl: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var checkBtnOtl: UIButton!
    @IBOutlet weak var studentListVuew: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
