//
//  DesciplineStudentListTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 11/09/23.
//

import UIKit

class DisciplineStudentListTblCell: UITableViewCell {

    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var sectionLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var admNoLbl: UILabel!
    @IBOutlet weak var checkBtnAction: UIButton!
    @IBOutlet weak var studentNmaeLbl: UILabel!
    @IBOutlet weak var studentDetailView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
