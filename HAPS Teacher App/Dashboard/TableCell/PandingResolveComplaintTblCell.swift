//
//  PandingResolveComplaintTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/10/23.
//

import UIKit

class PandingResolveComplaintTblCell: UITableViewCell {

 
    @IBOutlet weak var resolvedDescriptionView: UIView!
    @IBOutlet weak var complaintDetailView: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var complaintDateLbl: UILabel!
    @IBOutlet weak var complaintLocationLbl: UILabel!
    @IBOutlet weak var complaintByLbl: UILabel!
    @IBOutlet weak var complaintToLbl: UILabel!
    @IBOutlet weak var complaintDescriptionLbl: UILabel!
    @IBOutlet weak var resolveDescriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
