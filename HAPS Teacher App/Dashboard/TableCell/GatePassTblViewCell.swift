//
//  GatePassTblViewCell.swift
//  HAPS Teacher App
//
//  Created by Vijay Sharma on 26/12/23.
//

import UIKit

class GatePassTblViewCell: UITableViewCell {

    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var boardingNoLbl: UILabel!
    @IBOutlet weak var dateFromLbl: UILabel!
    @IBOutlet weak var dateToLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
