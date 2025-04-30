//
//  ViewRequsetDetailTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 20/09/23.
//

import UIKit

class ViewRequsetDetailTblCell: UITableViewCell {

    @IBOutlet weak var requestDescriptionLbl: UILabel!
    @IBOutlet weak var requsetBtLbl: UILabel!
    @IBOutlet weak var requestDateLbl: UILabel!
    @IBOutlet weak var requestStatusLbl: UILabel!
    @IBOutlet weak var requestStatusView: UIView!
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
