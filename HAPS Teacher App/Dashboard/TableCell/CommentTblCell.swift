//
//  CommentTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 09/08/23.
//

import UIKit

class CommentTblCell: UITableViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var commentImgView: UIImageView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentTxtView: UIView!
    @IBOutlet weak var commentNameDateLbl: UILabel!
    @IBOutlet weak var commentTxtLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
