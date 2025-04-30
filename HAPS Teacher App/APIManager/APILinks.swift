//
//  APILinks.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 28/07/23.
//

import Foundation

//let BASE_URL = "https://himacademy.in/teacher/api/"
let BASE_URL = "https://dukeinfosys.com/rajkumar/teacher/api/"

//let BASE_URL = "https://www.sanawar.edu.in/teacher/api" // Sanawar teacher app base url

//let BASE_URL = "https://www.dukeinfosys.org/upss/teacher/api/" Testing  url
//let BASE_URL = "https://www.dukeinfosys.com/sanawarerp/teacher/api/" Testing  url

enum END_POINTS {
    case Api_Login
    case Api_Count_Attendance
    case Api_Update_Login
    case Api_Profile
    case Api_SalaryList
    case Api_GenerateSalary
    case Api_Update_Profile
    case Api_Leavelist
    case Api_Changepass
    case Api_Leavetype
    case Api_Today_Leave_Report_Admin
    case Api_Circular_List
    case Api_View_Circular_Staff
    case Api_Viewtask
    case Api_Pendingtasks
    case Api_Inprogress
    case Api_Complete_Task
    case Api_Upload_For_Me
    case Api_Upload_By_Me
    case Api_Notifications
    case Api_Assigntask
    case Api_OnLeaveEmployeeReport
    case Api_Showtask_Comments
    case Api_Save_Task_Communications
    case Api_fillclass
    case Api_Show_Section
    case Api_View_Attendence
    case Api_View_Coaching_Attendance
    case Api_Task_Assigned_By_All_Tasks
    case Api_By_Me_Pending_Task
    case Api_ByMe_In_Progress
    case Api_ByMe_Complete_Task
    case Api_Daily_Agenda
    case Api_Calendar
    case Api_Calendar_Month
    case Api_Daily_Activity_Log
    case Api_Daily_Activity
    case Api_Teachers_List
    case Api_Upload_Document
    case Api_Forword_Task
    case Api_Show_EPTM_Record
    case Api_Apply_Leave
    case Api_Show_Hostel_Parenting
    case Api_Hostel_Parenting_Remarks
    case Api_Homework_List
    case Api_Assignment_List
    case Api_Subject_List
    case Api_Assign_Homework
    case Api_Send_Assignment
    case Api_Studentlist
    case Api_Insertptm1
    case Api_Student_Search
    case Api_Student_Get_Sportslist
    case Api_Sports_Entry_List
    case Api_Activity_Entry_List
    case Api_Get_Level_List
    case Api_Sports_Entry_Delete
    case Api_Activity_Entry_Delete
    case Api_Save_Sports_Entry
    case Api_Send_By_Me_CircularList
    case Api_Info_Read_Status
    case Api_Save_Activity_Entry
    case Api_Activity_List
//MARK: MarksEntry screen Apis
    case Api_Marks_Class_Sec_List
    case Api_Exam_Head_List
    case Api_Exam_Type_List
    case Api_Get_Exam_Test_List
    case Api_Paper_Type_List
    case Api_Get_Subjects_List
    case Api_Get_Total_Marks
    case APi_Add_Marks
    case Api_Save_Marks
//MARK: Student Circular Screen Apis
    case Api_Student_Type
    case Api_Student_Circular_Classes
    case Api_Student_List_For_Circular
    case Api_Student_Circular
    case Api_Student_Circular_Send_By_Me
    case Api_Teacherlist_Filter
    case Api_Staff_Circular
//MARK: FeedbackList
    case Api_Feedback_List
//MARK: E-Complaint Record
    case Api_Panding_Resolved_List
    case Api_My_Pending_Resolved_Complaint
    case Api_Submit_EComplaint
//MARK: Request For
    case Api_Submit_Extra_Day
    case Api_Extra_Day_Request
//MARK: Medical Entry
    //  (28-SEP-2023)
    case Api_Medical_Entry_Leave
    case Api_Medical_Entries
//MARK: Holistic Screen Apis
    case Api_Get_Holistic_Term
    case Api_Get_Holistic_Header
    case Api_Get_Holistic_Sub_Header
    case Api_Get_Holistic_Student_Detail
    case Api_Get_Holistic_GM
    case Api_Get_Holistic_Remarks
    case Api_Save_Holistic_Marks
//MARK: CBO Screen Apis
    case Api_Get_CBO_Term
    case Api_Get_CBO_Unit
    case Api_Get_CBO_Subjects
    case APi_Save_CBO_Marks

//MARK: Feedback Type Api
    case Api_Send_Parameter
    case Api_Update_Discipline
    case Api_Get_All_Class
    
//MARK: Hostel List Api
    case Api_Hostel_List
    case Api_Floor_List
    case Api_Room_List
    
    case Api_Update_Read_Status
//MARK: Principal Login Apis
//MARK: Daily Activity Log Employes Api
    case Api_Daily_Activity_Log_Employes
    case Api_Daily_Activity_Log_Filter
    case Api_Show_Ptm_Branch
    case Api_Search_Ptm
    
//MARK: Parent Suggestion Api (18-oct-2023)
    case Api_Feedback_Suggestion
    case Api_Request_For_Extra_Day
    case Api_Employee_Leave_Request
    case Api_Approved_Reject_Leave
    case Api_EComplaint_Principal_List
    
//MARK: Extra Day Leave(19-OCT-2023)
    case Api_Extra_Day_Leave_Apply
    case Api_Delete_Notification
    case Api_School_Dairy_Entry
    
    var getEndPoints : String {
        get {
            switch self {
            case .Api_Login:
                return "tlogin"
            case .Api_Count_Attendance:
                return "countattendance"
            case .Api_Update_Login:
                return "updatelogin"
            case .Api_Profile:
                return "get-profile"
            case .Api_SalaryList:
                return "SalaryList"
            case .Api_GenerateSalary:
                return "GenerateSalary"
            case .Api_Update_Profile:
                return "update-profile"
            case .Api_Leavelist:
                return "leavelist"
            case .Api_Changepass:
                return "changepass"
            case .Api_Leavetype:
                return "leavetype"
            case .Api_Today_Leave_Report_Admin:
                return "today_leave_report_admin"
            case .Api_Circular_List:
                return "CircularList"
            case .Api_View_Circular_Staff:
                return "ViewCircularStaff"
            case .Api_Viewtask:
                return "viewtask"
            case .Api_Pendingtasks:
                return "pendingtasks"
            case .Api_Inprogress:
                return "inprogress"
            case .Api_Complete_Task:
                return "completetask"
            case .Api_Upload_For_Me:
                return "upload-for-me"
            case .Api_Upload_By_Me:
                return "upload-by-me"
            case .Api_Notifications:
                return "notifications"
            case .Api_Assigntask:
                return "assigntask"
            case .Api_OnLeaveEmployeeReport:
                return "OnLeaveEmployeeReport"
            case .Api_Showtask_Comments:
                return "showtaskcomments"
            case .Api_Save_Task_Communications:
                return "savetaskcommunications"
            case .Api_fillclass:
                return "fillclass"
            case .Api_Show_Section:
                return "show_section"
            case .Api_View_Attendence:
                return "ViewAttendence"
            case .Api_View_Coaching_Attendance:
                return "ViewCoachingAttendance"
            case .Api_Task_Assigned_By_All_Tasks:
                return "taskassignedbyalltasks"
            case .Api_By_Me_Pending_Task:
                return "bymependingtask"
            case .Api_ByMe_In_Progress:
                return "bymeinprogress"
            case .Api_ByMe_Complete_Task:
                return "bymecompletetask"
            case .Api_Daily_Agenda:
                return "dailyagenda"
            case .Api_Calendar:
                return "calendar"
            case .Api_Calendar_Month:
                return "calendarmonth"
            case .Api_Daily_Activity_Log:
                return "DailyActivityLog"
            case .Api_Daily_Activity:
                return "DailyActivity"
            case .Api_Teachers_List:
                return "teacherslist"
            case .Api_Upload_Document:
                return "upload-document"
            case .Api_Forword_Task:
                return "forwordtask"
            case .Api_Show_EPTM_Record:
                return "showptm"
            case .Api_Apply_Leave:
                return "applyleave"
            case .Api_Show_Hostel_Parenting:
                return "showhostelparenting"
            case .Api_Hostel_Parenting_Remarks:
                return "hostelparentingremarks"
            case .Api_Homework_List:
                return "homeworklist"
            case .Api_Assignment_List:
                return "assignmentlist"
            case .Api_Subject_List:
                return "subject"
            case .Api_Assign_Homework:
                return "AssignHomework"
            case .Api_Send_Assignment:
                return "assignment"
            case .Api_Studentlist:
                return "studentlist"
            case .Api_Insertptm1:
                return "insertptm1"
            case .Api_Student_Search:
                return "student/studentsearch"
            case .Api_Student_Get_Sportslist:
                return "student/getsportslist"
            case .Api_Sports_Entry_List:
                return "student/SportsEntryList"
            case .Api_Activity_Entry_List:
                return "student/ActivityEntryList"
            case .Api_Get_Level_List:
                return "student/getlevellist"
            case .Api_Sports_Entry_Delete:
                return "student/SportsEntryDelete"
            case .Api_Activity_Entry_Delete:
                return "student/ActivityEntryDelete"
            case .Api_Save_Sports_Entry:
                return "student/savesportsentry"
            case .Api_Send_By_Me_CircularList:
                return "send-by-me-circularlist"
            case .Api_Info_Read_Status:
                return "info-read-status"
            case .Api_Save_Activity_Entry:
                return "student/saveactivityentry"
            case .Api_Activity_List:
                return "student/Activitylist"
//MarksEntry screen apis
            case .Api_Marks_Class_Sec_List:
                return "marksclasssec"
            case .Api_Exam_Head_List:
                return "examhead"
            case .Api_Exam_Type_List:
                return "examtype"
            case .Api_Get_Exam_Test_List:
                return "getexamtest"
            case .Api_Paper_Type_List:
                return "papertype"
            case .Api_Get_Subjects_List:
                return "getsubjects"
            case .Api_Get_Total_Marks:
                return "gettotalmarks"
            case .APi_Add_Marks:
                return "addmarks1"
            case .Api_Save_Marks:
                return "savemarks1"
//Student Circular Screen Apis
            case .Api_Student_Type:
                return "student-type"
            case .Api_Student_Circular_Classes:
                return "studentcircularclasses"
            case .Api_Student_List_For_Circular:
                return "StudentListForCircular"
            case .Api_Student_Circular:
                return "student_circular"
            case .Api_Student_Circular_Send_By_Me:
                return "student-circular-send-by-me"
            case .Api_Teacherlist_Filter:
                return "teacherlist-filter"
            case .Api_Staff_Circular:
                return "staff_circular"
//FeedbackList
            case .Api_Feedback_List:
                return "showparameter"
//E-Complaint Record List
            case .Api_Panding_Resolved_List:
                return "pending-resolved-list"
            case .Api_My_Pending_Resolved_Complaint:
                return "show-Ecomplaint"
            case .Api_Submit_EComplaint:
                return "submit_eComplaint"
//Request For (27-sep-2023)
            case .Api_Submit_Extra_Day:
                return "extra-day"
            case .Api_Extra_Day_Request:
                return "extra-day-entry-list"
                //Medical Entry (27-sep-2023)
            case .Api_Medical_Entry_Leave:
                return "medicalleaves"
                // Holistic Screen Apis
            case .Api_Get_Holistic_Term:
                return "getholisticterm"
            case .Api_Get_Holistic_Header:
                return "getholisticheader"
            case .Api_Get_Holistic_Sub_Header:
                return "getholisticsubheader"
            case .Api_Get_Holistic_Student_Detail:
                return "getholisticstudentdetail"
            case .Api_Get_Holistic_GM:
                return "getholisticgm"
            case .Api_Get_Holistic_Remarks:
                return "getholisticremarks"
            case .Api_Save_Holistic_Marks:
                return "saveholisticmarks"
//CBO Screen Apis
            case .Api_Get_CBO_Term:
                return "getcboterm"
            case .Api_Get_CBO_Unit:
                return "getcbounit"
            case .Api_Get_CBO_Subjects:
                return "getcbosubjects"
            case .APi_Save_CBO_Marks:
                return "savecbomarks"
            case .Api_Medical_Entries:
                return "medicalentries"
//Feedback Type Api
            case .Api_Send_Parameter:
                return "sendparameter"
            case .Api_Update_Discipline:
                return "updatediscipline"
            case .Api_Get_All_Class:
                return "get_all_class"
//Hostel List Api
            case .Api_Hostel_List:
                return "hostellist"
            case .Api_Floor_List:
                return "floorlist"
            case .Api_Room_List:
                return "roomlist"
                
            case .Api_Update_Read_Status:
                return "update-read-status"
//Daily Activity Log Employes Api
            case .Api_Daily_Activity_Log_Employes:
                return "DailyActivityLogEmployes"
            case .Api_Daily_Activity_Log_Filter:
                return "DailyActivityLogFilter"
//Show PTM Branch
            case .Api_Show_Ptm_Branch:
                return "showptmbranch"
            case .Api_Search_Ptm:
                return "searchptm"
  // Feedback Suggestion Api
            case .Api_Feedback_Suggestion:
                return "getFeedback"
            case .Api_Request_For_Extra_Day:
                return "emp-extra-day-entry-list"
            case .Api_Employee_Leave_Request:
                return "employe-leave-request"
            case .Api_Approved_Reject_Leave:
                return "approved-reject-leave"
            case .Api_EComplaint_Principal_List:
                return "ecomplaint_principal_list"
                
//Extra day leave
            case .Api_Extra_Day_Leave_Apply:
                return "approved-extra-day-status"
            case .Api_Delete_Notification:
                return "deletenotification"
            case .Api_School_Dairy_Entry:
                return "school-dairy-entry"
            }
        }
    }
}
