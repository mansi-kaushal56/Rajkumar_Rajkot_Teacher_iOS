//
//  Protocols.swift
//  HAPS Teacher App
//
//  Created by Vijay Sharma on 22/08/23.
//

import Foundation

protocol SenderViewControllerDelegate {
    func messageData(data: AnyObject?, type: ScreenType?, selClassIndex: Int, selSectionIndex:Int)
}
protocol SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?)
}
protocol DashboardVCBackDelegate {
    func dismissVC()
}

enum ScreenType {
    case MainClassAttendance, CoachingClassAttendance, OnDuty,FullDay, ShortLeave, ClassList, SectionList, UploadDocumentVC, AssignToList, IntimationList, ForwardToList, IntimationForwardTaskList, LeaveTypeList, Homework, Assignment, SubjectList,  SportsList, LevelList, CreateCircular, ViewCircular, Pending, Resolved, ActivityList, Smiley, Frowny, MarksClassSecList, MarksExamHeadList, MarksExamTypeList, MarksExamTestList, MarksExamPaperTypeList, MarksSubjectList, StudentType, CircularClassesList, StaffList,  CBOTermList, CBOUnitList, CBOSubjectList, HolisticTermList, SendParameter, hostelList, floorList, roomList, GetAllClass, Hiranagar, VikasNagar
}
enum ViewTypes {
    case UploadDocument, ViewDocument, TaskAssignToMe, TaskAssignByMe
}
