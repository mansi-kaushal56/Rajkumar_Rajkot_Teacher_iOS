//
//  MultipleSelListTblVCell.swift
//  HAPS Teacher App
//
//  Created by Vijay Sharma on 02/09/23.
//

import UIKit

class MultipleSelListTblVCell: UITableViewCell {

    @IBOutlet weak var selectionBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
