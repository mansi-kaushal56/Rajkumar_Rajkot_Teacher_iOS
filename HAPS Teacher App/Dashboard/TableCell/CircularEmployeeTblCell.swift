//
//  CircularEmployeeTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 05/09/23.
//

import UIKit

class CircularEmployeeTblCell: UITableViewCell {

    @IBOutlet weak var sendToLbl: UILabel!
    @IBOutlet weak var employeeTypeLbl: UILabel!
    @IBOutlet weak var viewAttachmentView: UIView!
    @IBOutlet weak var circularByLbl: UILabel!
    @IBOutlet weak var circularDateLbl: UILabel!
    @IBOutlet weak var circularTitleLbl: UILabel!
    @IBOutlet weak var viewCircularListView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
