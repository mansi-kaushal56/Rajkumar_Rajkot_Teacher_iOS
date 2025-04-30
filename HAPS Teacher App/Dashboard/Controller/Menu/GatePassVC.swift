//
//  GatePassVC.swift
//  HAPS Teacher App
//
//  Created by Vijay Sharma on 26/12/23.
//

import UIKit

class GatePassVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Gate Pass Request")
    }
}
extension GatePassVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.gatePassCell.getIdentifier, for: indexPath) as! GatePassTblViewCell
        return cell
    }
}
