//
//  CircularStatusTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 07/09/23.
//

import UIKit

class CircularStatusTblCell: UITableViewCell {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var empCodeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
