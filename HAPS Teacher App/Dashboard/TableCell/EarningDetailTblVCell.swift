//
//  EarningDetailTblVCell.swift
//  HAPS Teacher App
//
//  Created by Vijay Sharma on 05/08/23.
//

import UIKit

class EarningDetailTblVCell: UITableViewCell {
    @IBOutlet weak var earningNameLbl: UILabel!
    @IBOutlet weak var earningValueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
