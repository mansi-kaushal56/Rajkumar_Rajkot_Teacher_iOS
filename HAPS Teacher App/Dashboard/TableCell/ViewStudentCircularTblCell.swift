//
//  ViewStudentCircularTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 08/09/23.
//

import UIKit

class ViewStudentCircularTblCell: UITableViewCell {

    @IBOutlet weak var viewImageView: UIView!
    @IBOutlet weak var viewPDFView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var groupLbl: UILabel!
    @IBOutlet weak var circularForLbl: UILabel!
    @IBOutlet weak var circularDateLbl: UILabel!
    @IBOutlet weak var circularTitleLbl: UILabel!
    @IBOutlet weak var viewCircularDetailView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
