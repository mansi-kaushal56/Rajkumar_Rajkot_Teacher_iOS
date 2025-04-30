//
//  StudentCircularTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 08/09/23.
//

import UIKit

class StudentCircularTblCell: UITableViewCell {

    @IBOutlet weak var studentDetailView: UIView!
    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var sectionLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var admNoLbl: UILabel!
    @IBOutlet weak var checkBtnOtl: UIButton!
    @IBOutlet weak var studentNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
