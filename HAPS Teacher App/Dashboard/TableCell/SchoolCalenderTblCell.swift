//
//  SchoolCalenderTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 23/08/23.
//

import UIKit

class SchoolCalenderTblCell: UITableViewCell {

    @IBOutlet weak var schoolCalenderDateLbl: UILabel!
    @IBOutlet weak var schoolCalenderLbl: UILabel!
    @IBOutlet weak var arrowBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
