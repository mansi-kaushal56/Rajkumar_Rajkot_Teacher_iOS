//
//  HostelRoomAllocationDetailVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 13/09/23.
//

import UIKit

class HostelRoomAllocationDetailVC: UIViewController {

    @IBOutlet weak var allocationDetailTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Hotel Room Allocation")
        // Do any additional setup after loading the view.
    }

}
extension HostelRoomAllocationDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let roomDetailCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.roomAllocateDetailCell.getIdentifier, for: indexPath) as! RoomAllocationDetailTblCell
        roomDetailCell.studentDetailView.clipsToBounds = true
        return roomDetailCell
    }
    
    
}
