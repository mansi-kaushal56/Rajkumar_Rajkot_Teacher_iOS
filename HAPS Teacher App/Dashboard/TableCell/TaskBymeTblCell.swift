//
//  TaskBymeTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/08/23.
//

import UIKit

class TaskBymeTblCell: UITableViewCell {

    @IBOutlet weak var pdfLinkView: UIView!
    @IBOutlet weak var attachmentView: UIView!
    @IBOutlet weak var taskCommentView: UIView!
    @IBOutlet weak var tskDescriptionLbl: UILabel!
    @IBOutlet weak var tskNameLbl: UILabel!
    @IBOutlet weak var tskPeriorityLbl: UILabel!
    @IBOutlet weak var assignByLbl: UILabel!
    @IBOutlet weak var assignToLbl: UILabel!
    @IBOutlet weak var deadlineDateLbl: UILabel!
    @IBOutlet weak var assignTskDateLbl: UILabel!
    @IBOutlet weak var tskStatusLbl: UILabel!
    @IBOutlet weak var tskStatusView: UIView!
    @IBOutlet weak var taskDetilsView: UIView!
    
    @IBOutlet weak var pdfLinkLbl: UILabel!
    @IBOutlet weak var attachmentImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
