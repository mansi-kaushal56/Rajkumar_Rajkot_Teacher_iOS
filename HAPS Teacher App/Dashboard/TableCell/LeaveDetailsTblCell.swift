//
//  LeaveDetailsTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 16/08/23.
//

import UIKit

class LeaveDetailsTblCell: UITableViewCell {

    @IBOutlet weak var totalDaysLbl: UILabel!
    @IBOutlet weak var employeeNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
