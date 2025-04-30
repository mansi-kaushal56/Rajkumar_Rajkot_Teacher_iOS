//
//  ActivityEntryListTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 04/09/23.
//

import UIKit

class ActivityEntryListTblCell: UITableViewCell {

    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var uploadOnLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var prizeWonLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var admNoLabel: UILabel!
    @IBOutlet weak var deleteBtnOtl: UIButton!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var activityListView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
