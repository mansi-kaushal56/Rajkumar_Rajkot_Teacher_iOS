//
//  TeacherListTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 25/08/23.
//

import UIKit

class TeacherListTblCell: UITableViewCell {

    @IBOutlet weak var selectBtnOtl: UIButton!
    @IBOutlet weak var teacherNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
