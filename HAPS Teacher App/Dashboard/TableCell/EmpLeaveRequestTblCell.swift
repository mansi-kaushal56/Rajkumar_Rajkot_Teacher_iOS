//
//  EmpLeaveRequestTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/10/23.
//

import UIKit

class EmpLeaveRequestTblCell: UITableViewCell {

    @IBOutlet weak var rejectView: UIView!
    @IBOutlet weak var approvedView: UIView!
    @IBOutlet weak var daysLbl: UILabel!
    @IBOutlet weak var reasonForLeaveLbl: UILabel!
    @IBOutlet weak var dateToLbl: UILabel!
    @IBOutlet weak var dateFromLbl: UILabel!
    @IBOutlet weak var empCodeLbl: UILabel!
    @IBOutlet weak var empNameLbl: UILabel!
    @IBOutlet weak var leaveDetailView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
