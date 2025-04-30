//
//  ViewDocumentTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 10/08/23.
//

import UIKit

class ViewDocumentTblCell: UITableViewCell {

    @IBOutlet weak var assignedByLbl: UILabel!
    @IBOutlet weak var assignedDateLbl: UILabel!
    @IBOutlet weak var documentTitleLbl: UILabel!
    @IBOutlet weak var viewAttachmentImgView: UIView!
    
    @IBOutlet weak var documentImgView: UIImageView!
    @IBOutlet weak var viewAttachmentView: UIView!
    @IBOutlet weak var viewDocumentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
