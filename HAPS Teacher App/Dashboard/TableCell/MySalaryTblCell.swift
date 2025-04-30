//
//  MySalaryTblCell.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 02/08/23.
//

import UIKit

class MySalaryTblCell: UITableViewCell {
    
    @IBOutlet weak var viewbtn: UIButton!
    @IBOutlet weak var salaryAmountLbl: UILabel!
    @IBOutlet weak var salaryYearLbl: UILabel!
    @IBOutlet weak var salaryMonthLbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
