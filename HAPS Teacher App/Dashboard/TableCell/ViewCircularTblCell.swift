//
//  ViewCircularTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 10/08/23.
//

import UIKit

class ViewCircularTblCell: UITableViewCell {

    @IBOutlet weak var viewAttachmentImgView: UIView!
    @IBOutlet weak var viewAttachmentView: UIView!
    @IBOutlet weak var circularImgView: UIImageView!
    @IBOutlet weak var titleOfCircularLblOtl: UILabel!
    @IBOutlet weak var descriptionLblOtl: UILabel!
    @IBOutlet weak var branchLblOtl: UILabel!
    @IBOutlet weak var employeeTypeLblOtl: UILabel!
    @IBOutlet weak var circularByLblOtl: UILabel!
    @IBOutlet weak var circularDateLblOtl: UILabel!
    @IBOutlet weak var viewCircularView: UIView!
    
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
