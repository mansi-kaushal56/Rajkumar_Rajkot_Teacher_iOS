//
//  FeedbackSuggestionTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 18/10/23.
//

import UIKit

class FeedbackSuggestionTblCell: UITableViewCell {

    @IBOutlet weak var suggestionDetailView: UIView!
    @IBOutlet weak var suggestionDescriptionLbl: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var admNoLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
