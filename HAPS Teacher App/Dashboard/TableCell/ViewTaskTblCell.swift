//
//  ViewTaskTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 08/08/23.
//

import UIKit

class ViewTaskTblCell: UITableViewCell {

    @IBOutlet weak var pdfLinkView: UIView!
    @IBOutlet weak var attachmentView: UIView!
    @IBOutlet weak var tskPeriorityLbl: UILabel!
    @IBOutlet weak var tskDescriptionLbl: UILabel!
    @IBOutlet weak var tskNameLbl: UILabel!
    @IBOutlet weak var assignToLbl: UILabel!
    @IBOutlet weak var assignByLbl: UILabel!
    @IBOutlet weak var deadlineDateLbl: UILabel!
    @IBOutlet weak var assignDateLbl: UILabel!
    @IBOutlet weak var tskStatusLbl: UILabel!
    @IBOutlet weak var tskStatusView: UIView!
    @IBOutlet weak var forwardViewOtl: UIView!
    @IBOutlet weak var commentViewOtl: UIView!
    @IBOutlet weak var viewTaskTblViewOtl: UIView!
    
    @IBOutlet weak var pdflinkLbl: UILabel!
    @IBOutlet weak var attachmentIconView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewTaskTblViewOtl.clipsToBounds = true
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
