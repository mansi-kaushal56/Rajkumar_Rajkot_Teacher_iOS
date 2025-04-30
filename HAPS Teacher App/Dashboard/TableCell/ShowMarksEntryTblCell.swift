//
//  ShowMarksEntryTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 20/09/23.
//

import UIKit
protocol ShowMarksEntryTblCellDelegate {
    func marksTextFieldDidEdit(cell: ShowMarksEntryTblCell, editedText: String)
}

class ShowMarksEntryTblCell: UITableViewCell {

    @IBOutlet weak var attendanceLbl: UILabel!
    @IBOutlet weak var attendanceView: UIView!
    @IBOutlet weak var attendanceBtnOtl: UIButton!
    @IBOutlet weak var marksTxtFld: UITextField!
    @IBOutlet weak var admNoLbl: UILabel!
    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    
    var delegate: ShowMarksEntryTblCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        marksTxtFld.addTarget(self, action: #selector(marksTextFieldEditingChanged), for: .editingChanged)
    }
    @objc func marksTextFieldEditingChanged() {
        if let text = marksTxtFld.text {
            delegate?.marksTextFieldDidEdit(cell: self, editedText: text)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
