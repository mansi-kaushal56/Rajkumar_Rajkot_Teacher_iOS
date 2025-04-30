//
//  TeachersListVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 25/08/23.
//

import UIKit

class TeachersListVC: UIViewController {
    
    var teacherListObj: TeacherListModel?
    var teacherList : [TeacherListRest]? = []
    var delegate: SenderVCDelegate?
    var screenTypes : ScreenType?
    var isSearching = Bool()
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var selectAllLbl: UILabel!
    @IBOutlet weak var fullScreenView: UIView!
    @IBOutlet weak var selectAllBtnOtl: UIButton!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var teacherListTblView: UITableView!
    @IBOutlet weak var searchTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @objc func selectedTeacher(sender:UIButton) {
        if isSearching {
            var teacherData = teacherList?[sender.tag]
            if let isSelected = teacherData?.isSelected , isSelected == false {
                teacherData?.isSelected = true
            } else {
                teacherData?.isSelected = false
            }
            teacherList?[sender.tag] = teacherData!
            teacherListTblView.reloadData()
        } else {
            var teacherData = teacherListObj?.response?.rest?[sender.tag]
            if let isSelected = teacherData?.isSelected , isSelected == false {
                teacherData?.isSelected = true
            } else {
                teacherData?.isSelected = false
            }
            teacherListObj?.response?.rest?[sender.tag] = teacherData!
            teacherListTblView.reloadData()
        }
    }
    
    @IBAction func selectAllBtn(_ sender: UIButton) {
        if isSearching {
            guard let teacherDataArr = teacherList else {
                return
            }
            // Toggle the selection status for all teachers
            let updatedTeacherDataArr = teacherDataArr.map { teacherData  -> TeacherListRest in
                var updatedTeacherData = teacherData
                updatedTeacherData.isSelected.toggle()
                return updatedTeacherData
            }
            
            teacherList = updatedTeacherDataArr
            teacherListTblView.reloadData()
            updateSelectAllButtonAppearance()
        } else {
            guard let teacherDataArr = teacherListObj?.response?.rest else {
                return
            }
            // Toggle the selection status for all teachers
            let updatedTeacherDataArr = teacherDataArr.map { teacherData  -> TeacherListRest in
                var updatedTeacherData = teacherData
                updatedTeacherData.isSelected.toggle()
                return updatedTeacherData
            }
            
            teacherListObj?.response?.rest = updatedTeacherDataArr
            teacherListTblView.reloadData()
            updateSelectAllButtonAppearance()
        }
       
    }
    
    func updateSelectAllButtonAppearance() {
        if isSearching {
            let allSelected = teacherList?.allSatisfy { $0.isSelected } ?? false
            let title = allSelected ? "Deselect All" : "Select All"
            let backgroundImage = allSelected ? UIImage.checkboxIcon : UIImage.uncheckboxIcon
            selectAllBtnOtl.setTitle(title, for: .normal)
            selectAllBtnOtl.setImage(backgroundImage, for: .normal)
        } else {
            let allSelected = teacherListObj?.response?.rest?.allSatisfy { $0.isSelected } ?? false
            let title = allSelected ? "Deselect All" : "Select All"
            let backgroundImage = allSelected ? UIImage.checkboxIcon : UIImage.uncheckboxIcon
            selectAllBtnOtl.setTitle(title, for: .normal)
            selectAllBtnOtl.setImage(backgroundImage, for: .normal)
        }
        
    }
    func filterTeacherList(searchText: String) {
        guard let responseArray = teacherListObj?.response?.rest else {
            // Handle the case where teacherListObj is nil or doesn't contain a valid response array
            return
        }
        
        if searchText.isEmpty {
            // If the search text is empty, show the original unfiltered data
            teacherList = responseArray
        } else {
            // Use filter to find teachers whose names contain the search text
            teacherList = responseArray.filter { teacher in
                        if let empName = teacher.empName, let empCode = teacher.empCode {
                            let lowercasedName = empName.lowercased()
                            let lowercasedCode = empCode.lowercased()
                            let lowercasedSearchText = searchText.lowercased()

                            if lowercasedName.hasPrefix(lowercasedSearchText) || lowercasedCode.hasPrefix(lowercasedSearchText) {
                                return true
                            }
                        }
                        return false
                    }
            //print(teacherList)
            
        }
        
        // Reload your table view or collection view to display the filtered results
        // For example, if you have a UITableView:
        teacherListTblView.reloadData()
    }
    @IBAction func okBtnAction(_ sender: UIButton) {
        
        var teacherDataArr = [TeacherListRest]()
        
        if isSearching {
            for teacherData in teacherList ?? [TeacherListRest]() {
                if teacherData.isSelected {
                    teacherDataArr.append(teacherData)
                }
            }
        } else {
            for teacherData in teacherListObj?.response?.rest ?? [TeacherListRest]() {
                if teacherData.isSelected {
                    teacherDataArr.append(teacherData)
                }
            }
        }
        switch screenTypes {
        case .UploadDocumentVC, .AssignToList, .IntimationList, .IntimationForwardTaskList, .ForwardToList, .StaffList :
            self.presentingViewController!.dismiss(animated: true)
            self.delegate?.messageData(data:teacherDataArr as AnyObject, type: screenTypes)
        default :
            return
        }
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
extension TeachersListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching  {
            return teacherList?.count ?? 0
        } else {
            return teacherListObj?.response?.rest?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teacherListCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.teacherListCell.getIdentifier, for: indexPath) as! TeacherListTblCell
        if isSearching {
            let teacherListData = teacherList?[indexPath.row]
            teacherListCell.teacherNameLbl.text = "\(teacherListData?.empCode ?? ""). \(teacherListData?.empName ?? "")"
            if teacherListData?.isSelected == false {
                teacherListCell.selectBtnOtl.setBackgroundImage(.uncheckboxIcon, for: .normal)
            } else {
                teacherListCell.selectBtnOtl.setBackgroundImage(.checkboxIcon, for: .normal)
            }

            teacherListCell.selectBtnOtl.tag = indexPath.row
            teacherListCell.selectBtnOtl.addTarget(self, action: #selector(selectedTeacher(sender: )), for: .touchUpInside)
        } else {
            teacherListCell.teacherNameLbl.text = "\(teacherListObj?.response?.rest?[indexPath.row].empCode ?? ""). \(teacherListObj?.response?.rest?[indexPath.row].empName ?? "")"
            let teacherListData = teacherListObj?.response?.rest?[indexPath.row]
            if teacherListData?.isSelected == false {
                teacherListCell.selectBtnOtl.setBackgroundImage(.uncheckboxIcon, for: .normal)
            } else {
                teacherListCell.selectBtnOtl.setBackgroundImage(.checkboxIcon, for: .normal)
            }

            teacherListCell.selectBtnOtl.tag = indexPath.row
            teacherListCell.selectBtnOtl.addTarget(self, action: #selector(selectedTeacher(sender: )), for: .touchUpInside)
        }
        return teacherListCell
    }
    
}
extension TeachersListVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self.fullScreenView {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
extension TeachersListVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Construct the new search text by replacing the characters in the specified range
        let currentText = searchTxtFld.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

        // Call your filterTeacherList function with the new search text
        filterTeacherList(searchText: newText)
        isSearching = true
        return true  // Allow the text change to happen
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == searchTxtFld {
            filterTeacherList(searchText: searchTxtFld.text ?? "")
        }
    }
}
