//
//  AssignmentHistoryTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/08/23.
//

import UIKit

class AssignmentHistoryTblCell: UITableViewCell {

    @IBOutlet weak var attachmentImgView: UIImageView!
    @IBOutlet weak var imgAttachmentView: UIView!
    @IBOutlet weak var pdfAttachmentView: UIView!
    @IBOutlet weak var pdfLinkLbl: UILabel!
    @IBOutlet weak var assignmentHistoryView: UIView!
 
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var classSectionLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
