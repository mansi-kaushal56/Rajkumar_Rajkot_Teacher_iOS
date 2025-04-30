//
//  MultipleSelListVC.swift
//  HAPS Teacher App
//
//  Created by Vijay Sharma on 02/09/23.
//

import UIKit

class MultipleSelListVC: UIViewController {
    
    var secListObj: ShowSectionModel?
    var delegate: SenderVCDelegate?
    var type: ScreenType?
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okBtn(_ sender: UIButton) {
        var listDataArr = [ShowSectionRest]()
        
        for teacherData in secListObj?.response?.rest ?? [ShowSectionRest]() {
            if teacherData.isSelected {
                listDataArr.append(teacherData)
            }
        }
        self.presentingViewController!.dismiss(animated: true)
        self.delegate?.messageData(data:listDataArr as AnyObject, type: type)
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @objc func selectedTeacher(sender:UIButton) {
        var listData = secListObj?.response?.rest?[sender.tag]
        if let isSelected = listData?.isSelected, isSelected == false {
            listData?.isSelected = true
        } else {
            listData?.isSelected = false
        }
        secListObj?.response?.rest?[sender.tag] = listData!
        listTableView.reloadData()
    }
}
extension MultipleSelListVC: UITableViewDelegate {
    
}
extension MultipleSelListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secListObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.multiListCell.getIdentifier, for: indexPath) as! MultipleSelListTblVCell
        let listData = secListObj?.response?.rest?[indexPath.row]
        listCell.titleLbl.text = secListObj?.response?.rest?[indexPath.row].sectionName
        listCell.selectionBtn.tag = indexPath.row
        listCell.selectionBtn.addTarget(self, action: #selector(selectedTeacher(sender: )), for: .touchUpInside)
        if listData?.isSelected == false {
            listCell.selectionBtn.setBackgroundImage(.uncheckboxIcon, for: .normal)
        } else {
            listCell.selectionBtn.setBackgroundImage(.checkboxIcon, for: .normal)
        }
        return listCell
    }
}
