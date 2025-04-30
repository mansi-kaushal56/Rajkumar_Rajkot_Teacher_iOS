//
//  AppString.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 28/07/23.
//

import Foundation
import UIKit

struct AppFonts {
    static var Roboto_Regular = "Roboto-Regular"
    static var Roboto_Medium = "Roboto-Medium"
    static var Roboto_Bold = "Roboto-Bold"
}
struct SchoolName {
    static var HAPSchool = "Him Academy Public School."
    static var RKCRajkot = "Raj Kumar College"
}
struct FileOrPhotoKey {
    static var File = "file"
    static var Photo = "Photo"
}
enum AppStrings {
    
    //MARK: Segue Indentifier
    enum AppSegue {
        case dashboardSegue
        case splashToLoginSegue
        case splashToDashboardSegue
        case changePswdSegue
        case mySalarySegue
        case editProfileSegue
        case profileSegue
        case salaryRecieptSegue
        case applyLeaveSegue
        case leaveRecordSegue
        case taskManagementSegue
        case assignTaskSegue
        case taskAssignMeSegue
        case forwardScreenSegue
        case commentSegue
        case assignBymeSgue
        case leaveReportSegue
        case employeeCircularSegue
        case viewCircularSegue
        case documentForMeSegue
        case notificationSegue
        case taskAgendaSegue
        case leaveDetailsSegue
        case agendaSegue
        case attendanceSegue
        case viewAttendanceSegue
        case mainClassSegue
        case taskCommentSegue
        case homeWorkSegue
        case calenderSegue
        case schoolCalenderSegue
        case activityLogSegue
        case viewLogSegue
        case uploadDocumentSegue
        case ePTMSegue
        case ptmRecordSegue
        case hostelParentingSegue
        case assignmentHistorySegue
        case homeWorkHistorySegue
        case hostelListSegue
        case studentPortfolioSegue
        case sportsDetailSegue
        case activityDetailSegue
        case sportsEntrySegue
        case activityEntrySegue
        case circularSegue
        case circularViewSegue
        case circularStatusSegue
        case studentCircularSegue
        case disciplineSegue
        case feedBackSegue
        case medicalEntrySegue
        case medicalListSegue
        case roomAllocationSegue
        case roomAllocateDetailSegue
        case eComplaintSegue
        case postComplaintSegue
        case complaintRecordSegue
        case myComplaintSegue
        case requestForSegue
        case extraDaySegue
        case requestDetailSegue
        case feedbackListSegue
        case marksEntrySegue
        case showMarksSegue
        case holisticMarksSegue
        case showHolisticEntrySegue
        case cboEntrySegue
        case showCBOEntrySegue
        case employeeDALSegue
        case ePTMRecordSegue
        case empLeaveRecordSegue
        case empLeaveRequestSegue
        case forExtraDayRequestSegue
        case eComplaintRecordSegue
        case pandingComplaintSegue
        case empRequestSegue
        case suggestionSegue
        case gatePassSegue
        
        var getDescription : String {
            get {
                switch self {
                case .dashboardSegue:
                    return "dashboardSegue"
                case .splashToLoginSegue:
                    return "splashToLoginSegue"
                case .splashToDashboardSegue:
                    return "splashToDashboardSegue"
                case .changePswdSegue:
                    return "changePswdSegue"
                case .mySalarySegue:
                    return "mySalarySegue"
                case .editProfileSegue:
                    return "editProfileSegue"
                case .profileSegue:
                    return "profileSegue"
                case .salaryRecieptSegue:
                    return "salaryRecieptSegue"
                case .applyLeaveSegue:
                    return "applyLeaveSegue"
                case .leaveRecordSegue:
                    return "leaveRecordSegue"
                case .taskManagementSegue:
                    return "taskManagementSegue"
                case .assignTaskSegue:
                    return "assignTaskSegue"
                case .taskAssignMeSegue:
                    return "taskAssignMeSegue"
                case .forwardScreenSegue:
                    return "forwardScreenSegue"
                case .commentSegue:
                    return "commentSegue"
                case .assignBymeSgue:
                    return "assignBymeSgue"
                case .leaveReportSegue:
                    return "leaveReportSegue"
                case .employeeCircularSegue:
                    return "employeeCircularSegue"
                case .viewCircularSegue:
                    return "viewCircularSegue"
                case .documentForMeSegue:
                    return "documentForMeSegue"
                case .notificationSegue:
                    return "notificationSegue"
                case .taskAgendaSegue:
                    return "taskAgendaSegue"
                case .leaveDetailsSegue:
                    return "leaveDetailsSegue"
                case .agendaSegue:
                    return "agendaSegue"
                case .attendanceSegue:
                    return "attendanceSegue"
                case .viewAttendanceSegue:
                    return "viewAttendanceSegue"
                case .mainClassSegue:
                    return "mainClassSegue"
                case .taskCommentSegue:
                    return "taskCommentSegue"
                case .homeWorkSegue:
                    return "homeWorkSegue"
                case .calenderSegue:
                    return "calenderSegue"
                case .schoolCalenderSegue:
                    return "schoolCalenderSegue"
                case .activityLogSegue:
                    return "activityLogSegue"
                case .viewLogSegue:
                    return "viewLogSegue"
                case .uploadDocumentSegue:
                    return "uploadDocumentSegue"
                case .ePTMSegue:
                    return "ePTMSegue"
                case .ptmRecordSegue:
                    return "ptmRecordSegue"
                case .hostelParentingSegue:
                    return "hostelParentingSegue"
                case .assignmentHistorySegue:
                    return "assignmentHistorySegue"
                case .homeWorkHistorySegue:
                    return "homeWorkHistorySegue"
                case .hostelListSegue:
                    return "hostelListSegue"
                case .studentPortfolioSegue:
                    return "studentPortfolioSegue"
                case .sportsDetailSegue:
                    return "sportsDetailSegue"
                case .activityDetailSegue:
                    return "activityDetailSegue"
                case .sportsEntrySegue:
                    return "sportsEntrySegue"
                case .activityEntrySegue:
                    return "activityEntrySegue"
                case .circularSegue:
                    return "circularSegue"
                case .circularViewSegue:
                    return "circularViewSegue"
                case .circularStatusSegue:
                    return "circularStatusSegue"
                case .studentCircularSegue:
                    return "studentCircularSegue"
                case .disciplineSegue:
                    return "disciplineSegue"
                case .feedBackSegue:
                    return "feedBackSegue"
                case .medicalEntrySegue:
                    return "medicalEntrySegue"
                case .medicalListSegue:
                    return "medicalListSegue"
                case .roomAllocationSegue:
                    return "roomAllocationSegue"
                case .roomAllocateDetailSegue:
                    return "roomAllocateDetailSegue"
                case .eComplaintSegue:
                    return "eComplaintSegue"
                case .postComplaintSegue:
                    return "postComplaintSegue"
                case .complaintRecordSegue:
                    return "complaintRecordSegue"
                case .myComplaintSegue:
                    return "myComplaintSegue"
                case .requestForSegue:
                    return "requestForSegue"
                case .extraDaySegue:
                    return "extraDaySegue"
                case .requestDetailSegue:
                    return "requestDetailSegue"
                case .feedbackListSegue:
                    return "feedbackListSegue"
                case .marksEntrySegue:
                    return "marksEntrySegue"
                case .showMarksSegue:
                    return "showMarksSegue"
                case .holisticMarksSegue:
                    return "holisticMarksSegue"
                case .showHolisticEntrySegue:
                    return "showHolisticEntrySegue"
                case .cboEntrySegue:
                    return "cboEntrySegue"
                case .showCBOEntrySegue:
                    return "showCBOEntrySegue"
                case .employeeDALSegue:
                    return "employeeDALSegue"
                case .ePTMRecordSegue:
                    return "ePTMRecordSegue"
                case .empLeaveRecordSegue:
                    return "empLeaveRecordSegue"
                case .empLeaveRequestSegue:
                    return "empLeaveRequestSegue"
                case .forExtraDayRequestSegue:
                    return "forExtraDayRequestSegue"
                case .eComplaintRecordSegue:
                    return "eComplaintRecordSegue"
                case .pandingComplaintSegue:
                    return "pandingComplaintSegue"
                case .empRequestSegue:
                    return "empRequestSegue"
                case .suggestionSegue:
                    return "suggestionSegue"
                case .gatePassSegue:
                    return "gatePassSegue"
                }
            }
        }
    }
    enum AppNotificationSegue {
        case notificationToTaskAssignToMeSegue
        case myEComplaintsActSgue
        case forMeUploadDocSegue
        case empCircularsegue
        case taskbymeSegue
        case tasktomeSegue
        case leavesRecordSegue
        case princiComplaintSegue
        case princiAppliedLeaveSegue
        case princiExtraDaySegue
        case princiDailyAgendaSegue
        case princiActLogSegue
        
        var getIdentifier: String {
            get {
                switch self {
                case .notificationToTaskAssignToMeSegue:
                    return "notificationToTaskAssignToMeSegue"
                case .myEComplaintsActSgue:
                    return "myEComplaintsActSgue"
                case .forMeUploadDocSegue:
                    return "forMeUploadDocSegue"
                case .empCircularsegue:
                    return "empCircularsegue"
                case .taskbymeSegue:
                    return "taskbymeSegue"
                case .tasktomeSegue:
                    return "tasktomeSegue"
                case .leavesRecordSegue:
                    return "leavesRecordSegue"
                case .princiComplaintSegue:
                    return "princiComplaintSegue"
                case .princiAppliedLeaveSegue:
                    return "princiAppliedLeaveSegue"
                case .princiExtraDaySegue:
                    return "princiExtraDaySegue"
                case .princiDailyAgendaSegue:
                    return "princiDailyAgendaSegue"
                case .princiActLogSegue:
                    return "princiActLogSegue"
                    
                }
            }
        }
    }
    //MARK: Storyboard Name
    enum AppStoryboards {
        case main
        case dashboard
        
        var getDescription: String {
            get {
                switch self {
                case .main:
                    return "Main"
                case .dashboard:
                    return "Dashboard"
                }
            }
        }
    }
    
    //MARK: View Controller Identifier
    enum ViewControllerIdentifiers {
        case loginVC
        case splashScreenVc
        case dashboardVC
        case navigationVC
        case viewImagevc
        case listAppearVC
        case teachersListvc
        case menuBarvc
        case multipleSelListvc
        case assignmentDetailvc
        case homeWorkDetailvc
        case createStudentCircularvc
        case viewStudentCircularvc
        case eComplaintPendingRecordVc
        case eComplaintResolvedRecordvc
        case myComplaintPendingRecordVc
        case myComplaintResolvedRecordvc
        case smileyFeedbackListvc
        case frownyFeedbackListvc
        case marksEntryAttendancevc
        case vikasnagarLeaveRecordvc
        case hiranagarLeaveRecordvc
        
        var getStoryboardID : String {
            get {
                switch self {
                case .loginVC:
                    return AppStoryboards.main.getDescription
                case .splashScreenVc:
                    return AppStoryboards.main.getDescription
                case .dashboardVC:
                    return AppStoryboards.dashboard.getDescription
                case .navigationVC:
                    return AppStoryboards.dashboard.getDescription
                case .viewImagevc:
                    return AppStoryboards.dashboard.getDescription
                case .listAppearVC:
                    return AppStoryboards.dashboard.getDescription
                case .teachersListvc:
                    return AppStoryboards.dashboard.getDescription
                case .menuBarvc:
                    return AppStoryboards.dashboard.getDescription
                case .multipleSelListvc:
                    return AppStoryboards.dashboard.getDescription
                case .assignmentDetailvc:
                    return AppStoryboards.dashboard.getDescription
                case .homeWorkDetailvc:
                    return AppStoryboards.dashboard.getDescription
                case .createStudentCircularvc:
                    return AppStoryboards.dashboard.getDescription
                case .viewStudentCircularvc:
                    return AppStoryboards.dashboard.getDescription
                case .eComplaintPendingRecordVc:
                    return AppStoryboards.dashboard.getDescription
                case .eComplaintResolvedRecordvc:
                    return AppStoryboards.dashboard.getDescription
                case .myComplaintPendingRecordVc:
                    return AppStoryboards.dashboard.getDescription
                case .myComplaintResolvedRecordvc:
                    return AppStoryboards.dashboard.getDescription
                case .smileyFeedbackListvc:
                    return AppStoryboards.dashboard.getDescription
                case .frownyFeedbackListvc:
                    return AppStoryboards.dashboard.getDescription
                case .marksEntryAttendancevc:
                    return AppStoryboards.dashboard.getDescription
                case .vikasnagarLeaveRecordvc:
                    return AppStoryboards.dashboard.getDescription
                case .hiranagarLeaveRecordvc:
                    return AppStoryboards.dashboard.getDescription
                }
            }
        }
        
        var getIdentifier : String {
            get {
                switch self {
                case .loginVC:
                    return "logInvc"
                case .splashScreenVc:
                    return "splashScreenVc"
                case .dashboardVC:
                    return "dashboardvc"
                case .navigationVC:
                    return "navigationvc"
                case .viewImagevc:
                    return "viewImagevc"
                case .listAppearVC:
                    return "listAppearvc"
                case .teachersListvc:
                    return "teachersListvc"
                case .menuBarvc:
                    return "menuBarvc"
                case .multipleSelListvc:
                    return "multipleSelListvc"
                case .assignmentDetailvc:
                    return "assignmentDetailvc"
                case .homeWorkDetailvc:
                    return "homeWorkDetailvc"
                case .createStudentCircularvc:
                    return "createStudentCircularvc"
                case .viewStudentCircularvc:
                    return "viewStudentCircularvc"
                case .eComplaintPendingRecordVc:
                    return "eComplaintPendingRecordVc"
                case .eComplaintResolvedRecordvc:
                    return "eComplaintResolvedRecordvc"
                case .myComplaintPendingRecordVc:
                    return "myComplaintPendingRecordVc"
                case .myComplaintResolvedRecordvc:
                    return "myComplaintResolvedRecordvc"
                case .smileyFeedbackListvc:
                    return "smileyFeedbackListvc"
                case .frownyFeedbackListvc:
                    return "frownyFeedbackListvc"
                case .marksEntryAttendancevc:
                    return "marksEntryAttendancevc"
                case .vikasnagarLeaveRecordvc:
                    return "vikasnagarLeaveRecordvc"
                case .hiranagarLeaveRecordvc:
                    return "hiranagarLeaveRcordvc"
                }
            }
        }
    }
    //MARK: Tableview Identifier
    enum AppTblVIdentifiers {
        case menuCell
        case mySalaryCell
        case earningDetailCell
        case recordCell
        case viewTskTblCell
        case commentCell
        case myTaskCell
        case circularListCell
        case viewCircularCell
        case documentCell
        case notificationCell
        case leaveDetailsCell
        case agendaCell
        case mainClassCell
        case listTblCell
        case schoolCalendarCell
        case viewActiveLogCell
        case teacherListCell
        case viewDocumentCell
        case ptmRecordCell
        case hostelListCell
        case HWHistoryCell
        case assignHistoryCell
        case listSearchStudent
        case hostelStudentList
        case multiListCell
        case sportsCell
        case activityCell
        case circularCell
        case circularStatusCell
        case studentCircularCell
        case viewStudentCircularCell
        case disciplineListCell
        case medicalHistoryCell
        case medicalListCell
        case roomAllocateDetailCell
        case pendingRecordCell
        case resolvedRecordCell
        case myPendingRecordCell
        case myResolvedRecordCell
        case requestDetailCell
        case smileyListCell
        case frownyListCell
        case marksEntryCell
        case holisticEntryCell
        case showCBOEntryCell
        case employeeDALCell
        case ePTMRecordCell
        case leaveCell
        case extraDayForRequestCell
        case complaintListCell
        case suggestionCell
        case gatePassCell
        
        var getIdentifier : String {
            get {
                switch self {
                case .menuCell:
                    return "menuCell"
                case .mySalaryCell:
                    return "mySalaryCell"
                case .earningDetailCell:
                    return "earningDetailCell"
                case .recordCell:
                    return "recordCell"
                case .viewTskTblCell:
                    return "viewTskTblCell"
                case .commentCell:
                    return "commentCell"
                case .myTaskCell:
                    return "myTaskCell"
                case .circularListCell:
                    return "circularListCell"
                case .viewCircularCell:
                    return "viewCircularCell"
                case .documentCell:
                    return "documentCell"
                case .notificationCell:
                    return "notificationCell"
                case .leaveDetailsCell:
                    return "leaveDetailsCell"
                case .agendaCell:
                    return "agendaCell"
                case .mainClassCell:
                    return "mainClassCell"
                case .listTblCell:
                    return "listTblCell"
                case .schoolCalendarCell:
                    return "schoolCalendarCell"
                case .viewActiveLogCell:
                    return "viewActiveLogCell"
                case .teacherListCell:
                    return "teacherListCell"
                case .viewDocumentCell:
                    return "viewDocumentCell"
                case .ptmRecordCell:
                    return "ptmRecordCell"
                case .hostelListCell:
                    return "hostelListCell"
                case .HWHistoryCell:
                    return "HWHistoryCell"
                case .assignHistoryCell:
                    return "assignHistoryCell"
                case .listSearchStudent:
                    return "listSearchStudent"
                case .hostelStudentList:
                    return "hostelStudentList"
                case .multiListCell:
                    return "multiListCell"
                case .sportsCell:
                    return "sportsCell"
                case .activityCell:
                    return "activityCell"
                case .circularCell:
                    return "circularCell"
                case .circularStatusCell:
                    return "circularStatusCell"
                case .studentCircularCell:
                    return "studentCircularCell"
                case .viewStudentCircularCell:
                    return "viewStudentCircularCell"
                case .disciplineListCell:
                    return "disciplineListCell"
                case .medicalHistoryCell:
                    return "medicalHistoryCell"
                case .medicalListCell:
                    return "medicalListCell"
                case .roomAllocateDetailCell:
                    return "roomAllocateDetailCell"
                case .pendingRecordCell:
                    return "pendingRecordCell"
                case .resolvedRecordCell:
                    return "resolvedRecordCell"
                case .myPendingRecordCell:
                    return "myPendingRecordCell"
                case .myResolvedRecordCell:
                    return "myResolvedRecordCell"
                case .requestDetailCell:
                    return "requestDetailCell"
                case .smileyListCell:
                    return "smileyListCell"
                case .frownyListCell:
                    return "frownyListCell"
                case .marksEntryCell:
                    return "marksEntryCell"
                case .holisticEntryCell:
                    return "holisticEntryCell"
                case .showCBOEntryCell:
                    return "showCBOEntryCell"
                case .employeeDALCell:
                    return "employeeDALCell"
                case .ePTMRecordCell:
                    return "ePTMRecordCell"
                case .leaveCell:
                    return "leaveCell"
                case .extraDayForRequestCell:
                    return "extraDayForRequestCell"
                case .complaintListCell:
                    return "complaintListCell"
                case .suggestionCell:
                    return "suggestionCell"
                case .gatePassCell:
                    return "gatePassCell"
                }
            }
        }
    }
    //MARK: Collection View Identifier
    enum AppCViewIdentifiers {
        case collectCell
        case viewTaskCell
        case myTaskCVCell
        
        var getIdentifier : String {
            get {
                switch self {
                case .collectCell:
                    return "collectCell"
                case .viewTaskCell:
                    return "viewTaskCell"
                case .myTaskCVCell:
                    return "myTaskCVCell"
                }
            }
        }
    }
}
