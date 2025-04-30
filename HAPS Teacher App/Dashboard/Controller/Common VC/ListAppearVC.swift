//
//  ListAppearVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 22/08/23.
//

import UIKit

class ListAppearVC: UIViewController {
    var type : ScreenType?
    var clListObj: FillClassModel?
    var secListObj: ShowSectionModel?
    var delegate : SenderViewControllerDelegate?
    var senderDelegate : SenderVCDelegate?
    var subListObj: SubjectListModel?
    var sportslistobj: SportsListMobel?
    var activityListObj: ActivityListMobel?
    var levelListobj: LevelListModel?
    var othersData: String?
    
    var classId: String?
    var leaveTypeObj: LeaveTypeModel?
    
    var marksClassOrSecObj: MarksClassSecListModel?
    var marksExamHeadObj: ExamHeadListModel?
    var marksExamTypeObj: ExamHeadListModel?
    var marksExamTestObj: ExamtestListModel?
    var marksPaperTypeObj: ExamTypeListModel?
    var marksSelectSubjectObj: SubjectsListModel?
    var sendParameterObj: SendParameterModel?
    var hostelListAppearObj: HostelListModel?
    var floorListAppearObj: FloorListModel?
    var roomListAppearObj: RoomListModel?
    
    var stType: StudentTypeListModel?
    var stCircularObj: StCircularClListModel?
    var selClassIndex: Int?
    var selSecIndex: Int?
    
    @IBOutlet var fullScreenView: UIView!
    @IBOutlet weak var listAppearTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
extension ListAppearVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentingViewController!.dismiss(animated: true)
        switch type  {
        case .ClassList:
            self.delegate?.messageData(data:clListObj?.response?.res?[indexPath.row] as AnyObject, type: type, selClassIndex: indexPath.row, selSectionIndex: selSecIndex ?? 0)
        case .GetAllClass:
            self.senderDelegate?.messageData(data: clListObj?.response?.res?[indexPath.row] as AnyObject, type: type)
        case .SectionList:
            self.delegate?.messageData(data:secListObj?.response?.rest?[indexPath.row] as AnyObject, type: type, selClassIndex: selClassIndex ?? 0, selSectionIndex: indexPath.row)
        case .LeaveTypeList:
            self.senderDelegate?.messageData(data: leaveTypeObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .SubjectList:
            self.senderDelegate?.messageData(data: subListObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .SportsList:
            self.senderDelegate?.messageData(data: sportslistobj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .LevelList:
            self.senderDelegate?.messageData(data: levelListobj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .ActivityList:
            self.senderDelegate?.messageData(data: activityListObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .MarksClassSecList:
            self.senderDelegate?.messageData(data: marksClassOrSecObj?.response?.res?[indexPath.row] as AnyObject, type: type)
        case .MarksExamHeadList, .CBOTermList, .CBOUnitList, .HolisticTermList:
            self.senderDelegate?.messageData(data: marksExamHeadObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .MarksExamTypeList:
            self.senderDelegate?.messageData(data: marksExamTypeObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .MarksExamTestList:
            self.senderDelegate?.messageData(data: marksExamTestObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .MarksExamPaperTypeList:
            self.senderDelegate?.messageData(data: marksPaperTypeObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .MarksSubjectList:
            self.senderDelegate?.messageData(data: marksSelectSubjectObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .StudentType:
            self.senderDelegate?.messageData(data: stType?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .CircularClassesList:
            self.senderDelegate?.messageData(data: stCircularObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
            
//MARK: (04/OCT/2023)
        case .hostelList:
            self.senderDelegate?.messageData(data: hostelListAppearObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .floorList:
            self.senderDelegate?.messageData(data: floorListAppearObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .roomList:
            self.senderDelegate?.messageData(data: roomListAppearObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .SendParameter:
            if indexPath.row == 0 {
                self.senderDelegate?.messageData(data: nil, type: type)
            } else {
                if let selectedData = sendParameterObj?.response?.res?[indexPath.row] {
                    self.senderDelegate?.messageData(data: selectedData as AnyObject, type: type)
                }
            }
            //self.senderDelegate?.messageData(data: sendParameterObj?.response?.res?[indexPath.row] as AnyObject, type: type)
        default:
            print("Unknown type")
            return
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .ClassList, .GetAllClass:
            return clListObj?.response?.res?.count ?? 0
        case .SectionList:
            return secListObj?.response?.rest?.count ?? 0
        case .LeaveTypeList:
            return leaveTypeObj?.response?.rest?.count ?? 0
        case .SubjectList:
            return subListObj?.response?.rest?.count ?? 0
        case .SportsList:
            return sportslistobj?.response?.rest?.count ?? 0
        case .LevelList:
            return levelListobj?.response?.rest?.count ?? 0
        case .ActivityList:
            return activityListObj?.response?.rest?.count ?? 0
        case .MarksClassSecList:
            return marksClassOrSecObj?.response?.res?.count ?? 0
        case .MarksExamHeadList, .CBOTermList, .CBOUnitList, .HolisticTermList:
            return marksExamHeadObj?.response?.rest?.count ?? 0
        case .MarksExamTypeList:
            return marksExamTypeObj?.response?.rest?.count ?? 0
        case .MarksExamTestList:
            return marksExamTestObj?.response?.rest?.count ?? 0
        case .MarksExamPaperTypeList:
            return marksPaperTypeObj?.response?.rest?.count ?? 0
        case .MarksSubjectList:
            return marksSelectSubjectObj?.response?.rest?.count ?? 0
        case .StudentType:
            return stType?.response?.rest?.count ?? 0
        case .CircularClassesList:
            return stCircularObj?.response?.rest?.count ?? 0
        case .hostelList:
            return hostelListAppearObj?.response?.rest?.count ?? 0
        case .floorList:
            return floorListAppearObj?.response?.rest?.count ?? 0
        case .roomList:
            return roomListAppearObj?.response?.rest?.count ?? 0
        case .SendParameter:
            if let sendParameterObj = sendParameterObj {
                return (sendParameterObj.response?.res?.count ?? 0) + (sendParameterObj.others != nil ? 1 : 0)
            } else {
                return 0
            }
            //return sendParameterObj?.response?.res?.count ?? 0
            
        default :
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.listTblCell.getIdentifier, for: indexPath) as! ListAppearTableCell
        switch type {
        case .ClassList, .GetAllClass:
            listCell.listLabel.text = clListObj?.response?.res?[indexPath.row].className
            return listCell
        case .SectionList:
            listCell.listLabel.text = secListObj?.response?.rest?[indexPath.row].sectionName
            return listCell
        case .LeaveTypeList:
            listCell.listLabel.text = leaveTypeObj?.response?.rest?[indexPath.row].leaveTypeName
            return listCell
        case .SubjectList:
            listCell.listLabel.text = subListObj?.response?.rest?[indexPath.row].subjectName
            return listCell
        case .SportsList:
            listCell.listLabel.text = sportslistobj?.response?.rest?[indexPath.row].sportsName
            return listCell
        case .LevelList:
            listCell.listLabel.text = levelListobj?.response?.rest?[indexPath.row].levelName
            return listCell
        case .ActivityList:
            listCell.listLabel.text = activityListObj?.response?.rest?[indexPath.row].activity
            return listCell
        case .MarksClassSecList:
            listCell.listLabel.text = marksClassOrSecObj?.response?.res?[indexPath.row].className
            return listCell
        case .MarksExamHeadList, .CBOTermList, .CBOUnitList, .HolisticTermList:
            listCell.listLabel.text = marksExamHeadObj?.response?.rest?[indexPath.row].head
            return listCell
        case .MarksExamTypeList:
            listCell.listLabel.text = marksExamTypeObj?.response?.rest?[indexPath.row].head
            return listCell
        case .MarksExamTestList:
            listCell.listLabel.text = marksExamTestObj?.response?.rest?[indexPath.row].test
            return listCell
        case .MarksExamPaperTypeList:
            listCell.listLabel.text = marksPaperTypeObj?.response?.rest?[indexPath.row].type
            return listCell
        case .MarksSubjectList:
            listCell.listLabel.text = marksSelectSubjectObj?.response?.rest?[indexPath.row].subjectName
            return listCell
        case .StudentType:
            listCell.listLabel.text = stType?.response?.rest?[indexPath.row].studentTypeName
            return listCell
        case .CircularClassesList:
            listCell.listLabel.text = stCircularObj?.response?.rest?[indexPath.row].class_name
            return listCell
//MARK: (04/OCT/2023)
        case .hostelList:
            listCell.listLabel.text = hostelListAppearObj?.response?.rest?[indexPath.row].hostelName
            return listCell
        case .floorList:
            listCell.listLabel.text = floorListAppearObj?.response?.rest?[indexPath.row].floorName
            return  listCell
        case .roomList:
            listCell.listLabel.text = roomListAppearObj?.response?.rest?[indexPath.row].room
            return listCell
        case .SendParameter:
            if let sendParameterObj = sendParameterObj {
                if indexPath.row == 0, let others = sendParameterObj.others {
                    listCell.listLabel.text = others
                } else {
                    let adjustedIndex = indexPath.row - (sendParameterObj.others != nil ? 1 : 0)
                    if let dataItem = sendParameterObj.response?.res?[adjustedIndex + 1] {
                        listCell.listLabel.text = dataItem.reasons
                    }
                }
            }
            //listCell.listLabel.text = sendParameterObj?.response?.res?[indexPath.row].reasons
            
            return listCell
            
        default:
             return listCell
        }
    }
}

extension ListAppearVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self.fullScreenView {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
