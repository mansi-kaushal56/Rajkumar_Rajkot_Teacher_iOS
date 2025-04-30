//
//  RequestForExtraDayTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/10/23.
//

import UIKit

class RequestForExtraDayTblCell: UITableViewCell {

    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var approveView: UIView!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var requestByLbl: UILabel!
    @IBOutlet weak var requestDateLbl: UILabel!
    @IBOutlet weak var requestDetailView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
