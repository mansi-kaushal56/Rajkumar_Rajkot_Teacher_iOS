//
//  SportsEntryListTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 04/09/23.
//

import UIKit

class SportsEntryListTblCell: UITableViewCell {

    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var deleteBtnOtl: UIButton!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var uploadOnLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var calegoryLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var awardLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var admNoLabel: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var sportsListView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
