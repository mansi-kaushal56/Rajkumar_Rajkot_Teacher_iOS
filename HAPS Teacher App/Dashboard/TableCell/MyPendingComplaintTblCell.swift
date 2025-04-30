//
//  MyPendingComplaintTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 14/09/23.
//

import UIKit

class MyPendingComplaintTblCell: UITableViewCell {

    @IBOutlet weak var complaintDescriptionLbl: UILabel!
    @IBOutlet weak var complaintLocationLbl: UILabel!
    @IBOutlet weak var complaintToLbl: UILabel!
    @IBOutlet weak var complaintDateLbl: UILabel!
    @IBOutlet weak var complaintDetailView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
