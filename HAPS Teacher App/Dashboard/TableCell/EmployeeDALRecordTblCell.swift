//
//  EmployeeDALRecordTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 06/10/23.
//

import UIKit

class EmployeeDALRecordTblCell: UITableViewCell {

    @IBOutlet weak var recordDetailView: UIView!
    @IBOutlet weak var viewAttachmentView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var empCodeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var attachmentLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
