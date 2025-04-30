//
//  MenuTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/07/23.
//

import UIKit

class MenuTblCell: UITableViewCell {

    @IBOutlet weak var MenuTblLbl: UILabel!
    @IBOutlet weak var menuTblImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
