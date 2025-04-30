//
//  EmployeeCircularTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/08/23.
//

import UIKit

class EmployeeCircularTblCell: UITableViewCell {

    @IBOutlet weak var circularTitleLbl: UILabel!
    @IBOutlet weak var viewAttachmentView: UIView!
    @IBOutlet weak var circularByLblOtl: UILabel!
    @IBOutlet weak var circularDateLblOtl: UILabel!
    @IBOutlet weak var employeeCircularView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
