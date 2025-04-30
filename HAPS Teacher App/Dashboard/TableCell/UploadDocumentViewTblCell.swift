//
//  UploadDocumentViewTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 25/08/23.
//

import UIKit

class UploadDocumentViewTblCell: UITableViewCell {

    @IBOutlet weak var backgoundView: UIView!
    @IBOutlet weak var attachmentImgView: UIImageView!
    @IBOutlet weak var imgVView: UIView!
    @IBOutlet weak var ViewAttachmentView: UIView!
    @IBOutlet weak var docImgView: UIImageView!
    @IBOutlet weak var assignedToLbl: UILabel!
    @IBOutlet weak var assignedDateLbl: UILabel!
    @IBOutlet weak var docTitleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
