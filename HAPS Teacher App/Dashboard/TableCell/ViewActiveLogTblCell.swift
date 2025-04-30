//
//  ViewActiveLogTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 23/08/23.
//

import UIKit

class ViewActiveLogTblCell: UITableViewCell {

    @IBOutlet weak var viewActiveLogView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var empCodeLbl: UILabel!
    @IBOutlet weak var logNameLbl: UILabel!
    @IBOutlet weak var viewAttachmentView: UIView!
    
    var dailyActData: DailyActLogRest? {
            didSet {
                // This block of code will be executed when dailyActData is set or changed

                // Update the UI elements with the data from dailyActData
                dateLabel.text = "Date: \(dailyActData?.date ?? "")"
                descriptionLbl.text = dailyActData?.description
                logNameLbl.text = dailyActData?.empName
                empCodeLbl.text = dailyActData?.empCode
            }
        }
}
