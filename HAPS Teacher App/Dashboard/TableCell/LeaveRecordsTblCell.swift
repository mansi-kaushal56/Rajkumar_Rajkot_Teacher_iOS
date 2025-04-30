//
//  LeaveRecordsTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 07/08/23.
//

import UIKit

class LeaveRecordsTblCell: UITableViewCell {

    @IBOutlet weak var leaveDetailView: UIView!
    @IBOutlet weak var dateFromLbl: UILabel!
    @IBOutlet weak var dateToLbl: UILabel!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var leaveTypeLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        leaveDetailView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
