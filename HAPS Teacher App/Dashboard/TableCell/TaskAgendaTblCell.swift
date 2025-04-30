//
//  TaskAgendaTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 16/08/23.
//

import UIKit

class TaskAgendaTblCell: UITableViewCell {

    @IBOutlet weak var taskAgendaView: UIView!
    @IBOutlet weak var agendaDescriptionLbl: UILabel!
    @IBOutlet weak var updateByLbl: UILabel!
    @IBOutlet weak var agendaDateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
