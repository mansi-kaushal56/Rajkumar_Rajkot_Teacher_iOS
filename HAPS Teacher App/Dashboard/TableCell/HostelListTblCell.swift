//
//  HostelListTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/08/23.
//

import UIKit

class HostelListTblCell: UITableViewCell {

    @IBOutlet weak var hotelListView: ProfileViewBorder!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var studentDetailLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var sectionLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var admissionNoLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
