//
//  RoomAllocationDetailTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 13/09/23.
//

import UIKit

class RoomAllocationDetailTblCell: UITableViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var floorLbl: UILabel!
    @IBOutlet weak var roomNoLbl: UILabel!
    @IBOutlet weak var hostelLbl: UILabel!
    @IBOutlet weak var allocationDateLbl: UILabel!
    @IBOutlet weak var admNoLbl: UILabel!
    @IBOutlet weak var editBtnOtl: UIButton!
    @IBOutlet weak var studentNameLbl: UILabel!
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
