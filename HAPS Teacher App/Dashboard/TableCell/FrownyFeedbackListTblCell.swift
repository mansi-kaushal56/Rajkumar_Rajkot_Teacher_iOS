//
//  FrownyFeedbackListTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 20/09/23.
//

import UIKit

class FrownyFeedbackListTblCell: UITableViewCell {

    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var sectionLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var admissionLbl: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var feedbackDetailView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
