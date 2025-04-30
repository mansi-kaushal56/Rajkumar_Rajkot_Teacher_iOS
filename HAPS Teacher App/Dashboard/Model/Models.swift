//
//  CountAttendanceModel.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 02/08/23.
//

import Foundation
import UIKit
import ObjectMapper

struct CountAttendanceModel : Mappable {
    var image ,profil_pic, message, days : String?
    var status : Bool?
    var Presents, totaltakenLeaves, TotalPendingleaves, notification_count, onduty, absents, leaves : Int?
    
    init?(map:Map) {}
    
    mutating func mapping(map:Map) {
        image <- map["image"]
        profil_pic <- map["profil_pic"]
        status <- map["status"]
        message <- map["message"]
        Presents <- map["Presents"]
        totaltakenLeaves <- map["totaltakenLeaves"]
        TotalPendingleaves <- map["TotalPendingleaves"]
        notification_count <- map["notification_count"]
        onduty <- map["onduty"]
        absents <- map["absents"]
        leaves <- map["leaves"]
        days <- map["days"]
    }
}
struct MyProfileModel : Mappable {
    var mobileno, address, department, empImage, message : String?
    var status : Bool?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        mobileno <- map["mobileno"]
        address <- map["address"]
        department <- map["Department"]
        empImage <- map["EmpImage"]
        status <- map["status"]
        message <- map["message"]
    }
}
struct MySalaryModel : Mappable {
    var response : ResponseModel?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        response <- map["response"]
    }
}
struct ResponseModel : Mappable {
    var rest : [RestModel]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}
struct RestModel : Mappable {
    var month, year, netSalary, salaryID : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        month <- map["Month"]
        year <- map["Year"]
        netSalary <- map["NetSalary"]
        salaryID <- map["SalaryID"]
    }
}
struct MySalaryDetailModel : Mappable {
    var  empCode, empName, designationName, aCCNO, uANNo, employeeTypeName, totalWorkingDays, totalPresentDays, extraDays, actualBasicSalary, gradePay, extraDaysPay, file, month, year, grossPay, ePF, advSalary, tDS, eSI, totalDeductions, netSalary, status, message : String?
    var earnings : [Earnings]?
    
    
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        empCode <- map["EmpCode"]
        empName <- map["EmpName"]
        designationName <- map["DesignationName"]
        aCCNO <- map["ACCNO"]
        uANNo <- map["UANNo"]
        employeeTypeName <- map["EmployeeTypeName"]
        totalWorkingDays <- map["TotalWorkingDays"]
        totalPresentDays <- map["TotalPresentDays"]
        extraDays <- map["ExtraDays"]
        actualBasicSalary <- map["ActualBasicSalary"]
        gradePay <- map["GradePay"]
        extraDaysPay <- map["ExtraDaysPay"]
        file <- map["file"]
        month <- map["month"]
        year <- map["year"]
        earnings <- map["earnings"]
        grossPay <- map["GrossPay"]
        ePF <- map["EPF"]
        advSalary <- map["Adv Salary"]
        tDS <- map["TDS"]
        eSI <- map["ESI"]
        totalDeductions <- map["TotalDeductions"]
        netSalary <- map["NetSalary"]
        status <- map["status"]
        message <- map["message"]
    }
    
}
struct Earnings : Mappable {
    var name, value : String?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        
        name <- map["name"]
        value <- map["value"]
    }
}
struct LeaveRecordsModel  : Mappable {
    var status, message : String?
    var leaveCount : Int?
    var response : Response?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        leaveCount <- map["count"]
        message <- map["message"]
        response <- map["response"]
    }
}
struct Response : Mappable {
    var rest : [Rest]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}
struct Rest : Mappable {
    var leaveId, empCode, empName, dateFrom, dateTo, reason, status, leaveTypeId, leaveType: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        leaveId <- map["LeaveId"]
        empCode <- map["EmpCode"]
        empName <- map["EmpName"]
        dateFrom <- map["DateFrom"]
        dateTo <- map["DateTo"]
        reason <- map["Reason"]
        status <- map["Status"]
        leaveTypeId <- map["LeaveTypeId"]
        leaveType <- map["LeaveType"]
    }
}
struct LeaveReportModel : Mappable {
    var totalEmployees, teachingEmployees, nonTeachingEmployees, toatalPresents, presentInschool, absentCount, fullDayCount, halfDayCount, teachingCount, nonTeachingCount, onDuty: Int?
    var status : Bool?
    var message : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        totalEmployees <- map["TotalEmployees"]
        teachingEmployees <- map["TeachingEmployees"]
        nonTeachingEmployees <- map["NonTeachingEmployees"]
        toatalPresents <- map["ToatalPresents"]
        presentInschool <- map["PresentInschool"]
        absentCount <- map["AbsentCount"]
        fullDayCount <- map["FullDayCount"]
        halfDayCount <- map["HalfDayCount"]
        teachingCount <- map["TeachingCount"]
        nonTeachingCount <- map["NonTeachingCount"]
        onDuty <- map["OnDuty"]
        status <- map["status"]
        message <- map["message"]
    }
}
struct CircularListModel : Mappable {
    var response : CircularListResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct CircularListResponse : Mappable {
    var res : [CircularListRes]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        res <- map["Res"]
    }
}
struct CircularListRes : Mappable {
    var id, attachment, file, title, staffcode, staff, description, created_Date: String?
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        attachment <- map["attachment"]
        file <- map["file"]
        title <- map["title"]
        staffcode <- map["staffcode"]
        staff <- map["staff"]
        description <- map["description"]
        created_Date <- map["Created_Date"]
    }
}
struct ViewCircularModel : Mappable {
    var status, msg, fileType, extraFile, file, empName, id, unique_id, description, created_Date : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        msg <- map["msg"]
        fileType <- map["FileType"]
        extraFile <- map["ExtraFile"]
        file <- map["file"]
        empName <- map["EmpName"]
        id <- map["id"]
        unique_id <- map["unique_id"]
        description <- map["description"]
        created_Date <- map["Created_Date"]
    }
}
struct DocumentsForMeModel : Mappable {
    var status : Bool?
    var msg : String?
    var response : DocumentsModelData?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        msg <- map["msg"]
        response <- map["response"]
    }
}
struct DocumentsModelData : Mappable {
    var rest : [DocumentsRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["Rest"]
    }
}
struct DocumentsRest : Mappable {
    var id, title, sendercode, fileType, file, extraFile, date, sendername: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        sendercode <- map["sendercode"]
        fileType <- map["FileType"]
        file <- map["file"]
        extraFile <- map["ExtraFile"]
        date <- map["date"]
        sendername <- map["sendername"]
    }
}
struct NotificationsModel : Mappable {
    var status : Bool?
    var msg : String?
    var response : [NotificationsResponse]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        msg <- map["msg"]
        response <- map["response"]
    }
}
struct NotificationsResponse : Mappable {
    var id, messages, type, view, taskid, taskname, sendby, createdate: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        messages <- map["messages"]
        type <- map["type"]
        view <- map["view"]
        taskid <- map["taskid"]
        taskname <- map["taskname"]
        sendby <- map["sendby"]
        createdate <- map["createdate"]
    }
}
struct TasksModel : Mappable {
    var response : TasksResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        response <- map["response"]
    }
}
struct TasksResponse : Mappable {
    var rest : [TasksRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}
struct TasksRest : Mappable {
    var id, taskname, assignedby, assignto, datefrom, deadline, priority, des, attachment, image, pdf, type, taskstatus: String?
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        taskname <- map["taskname"]
        assignedby <- map["assignedby"]
        assignto <- map["assignto"]
        datefrom <- map["datefrom"]
        deadline <- map["deadline"]
        priority <- map["priority"]
        des <- map["des"]
        attachment <- map["attachment"]
        image <- map["image"]
        pdf <- map["pdf"]
        type <- map["type"]
        taskstatus <- map["taskstatus"]
    }
}
struct LeaveDetailModel : Mappable {
    
    var response : [LeaveDetailRes]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
    
}
struct  LeaveDetailRes : Mappable {
    var empID : String?
    var empCode : String?
    var empName : String?
    var leaveDate : String?
    var leaveValue : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        empID <- map["EmpID"]
        empCode <- map["EmpCode"]
        empName <- map["EmpName"]
        leaveDate <- map["LeaveDate"]
        leaveValue <- map["LeaveValue"]
        
    }
}
struct ShowTaskCommentsModel : Mappable {
    var response : ShowTaskCommentsRes?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct ShowTaskCommentsRes : Mappable {
    var rest : [ShowTaskCommentsRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}
struct ShowTaskCommentsRest : Mappable {
    var type, loginname, msg, pic : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        type <- map["type"]
        loginname <- map["loginname"]
        msg <- map["msg"]
        pic <- map["Pic"]
    }
}
struct FillClassModel : Mappable {
    var response : FillClassResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct FillClassResponse : Mappable {
    var res : [FillClassRes]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        res <- map["Res"]
    }
}
struct FillClassRes : Mappable {
    var classId, className : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        classId <- map["Classid"]
        className <- map["ClassName"]
    }
}
struct ShowSectionModel : Mappable {
    var response : ShowSectionResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct ShowSectionResponse : Mappable {
    var rest : [ShowSectionRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["Rest"]
    }
}
struct ShowSectionRest : Mappable {
    var sectionId, sectionName : String?
    var isSelected: Bool = false
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        sectionId <- map["SectionId"]
        sectionName <- map["SectionName"]
    }
}

struct TeacherListModel : Mappable {
    var response : TeacherListResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct TeacherListResponse : Mappable {
    var rest : [TeacherListRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}
struct TeacherListRest : Mappable {
    var empCode : String?
    var empName : String?
    var isSelected : Bool = false
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        empCode <- map["EmpCode"]
        empName <- map["EmpName"]
    }
}

struct ViewAttendenceModel : Mappable {
    var total, present, absent, leave : Int?
    var response : ViewAttendenceResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        total <- map["Total"]
        present <- map["Present"]
        absent <- map["Absent"]
        leave <- map["Leave"]
        response <- map["response"]
    }
}

struct ViewAttendenceResponse : Mappable {
    var rest : [ViewAttendenceRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["Rest"]
    }
}
struct ViewAttendenceRest : Mappable {
    var enrollNo, rollNo, studentDetailId, studentName, attendence : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        enrollNo <- map["EnrollNo"]
        rollNo <- map["RollNo"]
        studentDetailId <- map["StudentDetailId"]
        studentName <- map["StudentName"]
        attendence <- map["Attendence"]
    }
}

struct LeaveTypeModel : Mappable {
    var response : LeaveTypeResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
    
}

struct LeaveTypeResponse : Mappable {
    var rest : [LeaveTypeRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}
struct LeaveTypeRest : Mappable {
    var leaveTypeId : String?
    var leaveTypeName : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        leaveTypeId <- map["LeaveTypeId"]
        leaveTypeName <- map["LeaveTypeName"]
    }
}
struct CalendarModel: Mappable {
    var response: [CalendarResponse]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct CalendarResponse : Mappable {
    var id, monthName, file, pic, createddate, description: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        monthName <- map["monthName"]
        file <- map["file"]
        pic <- map["pic"]
        createddate <- map["createddate"]
        description <- map["description"]
    }
}
struct DailyActLogModel : Mappable {
    var response : DailyActLogResponse?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}

struct DailyActLogResponse : Mappable {
    var rest : [DailyActLogRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        rest <- map["Rest"]
    }
}

struct DailyActLogRest : Mappable {
    var file, empName, id, empCode, description, date : String?
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        file <- map["file"]
        empName <- map["EmpName"]
        id <- map["id"]
        empCode <- map["EmpCode"]
        description <- map["description"]
        date <- map["date"]
    }
}
struct ShowPTMRecordModel : Mappable {
    var response : ShowPTMResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}

struct ShowPTMResponse : Mappable {
    var rest : [ShowPTMRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}

struct ShowPTMRest : Mappable {
    var rollNo, mode, area, psat, description, studentName, enrollNo, talkWith, mobile, date, className : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rollNo <- map["RollNo"]
        mode <- map["mode"]
        area <- map["area"]
        psat <- map["psat"]
        description <- map["Description"]
        studentName <- map["StudentName"]
        enrollNo <- map["EnrollNo"]
        talkWith <- map["TalkWith"]
        mobile <- map["Mobile"]
        date <- map["date"]
        className <- map["ClassName"]
    }
}
struct HomeworkListModel : Mappable {
    var response : HomeworkListResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct HomeworkListResponse : Mappable {
    var rest : [HomeworkListRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}
struct HomeworkListRest : Mappable {
    var className, sectionName, subjectName, empCode, due_date, desp : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        className <- map["ClassName"]
        sectionName <- map["SectionName"]
        subjectName <- map["SubjectName"]
        empCode <- map["EmpCode"]
        due_date <- map["due_date"]
        desp <- map["desp"]
    }
}

struct AssignmentListModel : Mappable {
    var response : AssignmentListResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct AssignmentListResponse : Mappable {
    var rest : [AssignmentListRest]?
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        rest <- map["rest"]
    }
}
struct AssignmentListRest : Mappable {
    var className, sectionName, filetype, pdfpath, subjectName, empCode, due_date, desp, imgpath  : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        className <- map["ClassName"]
        sectionName <- map["SectionName"]
        filetype <- map["filetype"]
        pdfpath <- map["pdfpath"]
        subjectName <- map["SubjectName"]
        empCode <- map["EmpCode"]
        due_date <- map["due_date"]
        desp <- map["desp"]
        imgpath <- map["imgpath"]
    }
}
struct ShowHostelParentingModel : Mappable {
    var response : ShowHostelParResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
    
}
struct ShowHostelParResponse : Mappable {
    var rest : [ShowHostelParRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}
struct ShowHostelParRest : Mappable {
    var empName, description, studentName, enrollNo, className, sectionName, date : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        empName <- map["EmpName"]
        description <- map["Description"]
        studentName <- map["StudentName"]
        enrollNo <- map["EnrollNo"]
        className <- map["ClassName"]
        sectionName <- map["SectionName"]
        date <- map["date"]
    }
}
struct SubjectListModel : Mappable {
    
    var response : SubjectListResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        response <- map["response"]
    }
}
struct SubjectListResponse : Mappable {
    var rest : [SubjectListRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["Rest"]
    }
}
struct SubjectListRest : Mappable {
    var subjectId, subjectName : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        subjectId <- map["SubjectId"]
        subjectName <- map["SubjectName"]
    }
}

struct StudentListModel : Mappable {
    var response : StudentListResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct StudentListResponse : Mappable {
    var res : [StudentListRes]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        res <- map["Res"]
    }
}
struct StudentListRes : Mappable {
    var studentId, enrollNo, studentName, sectionName, mobileNo, className, studentImage : String?
    var isSelected: Bool = false
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        studentId <- map["StudentId"]
        enrollNo <- map["EnrollNo"]
        studentName <- map["StudentName"]
        sectionName <- map["SectionName"]
        mobileNo <- map["MobileNo"]
        className <- map["ClassName"]
        studentImage <- map["StudentImage"]
    }
}
struct StudentSearchModel : Mappable {
    var className, enrollNo, name, fatherName, mobileNo, address : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        className <- map["Class"]
        enrollNo <- map["EnrollNo"]
        name <- map["Name"]
        fatherName <- map["FatherName"]
        mobileNo <- map["MobileNo"]
        address <- map["Address"]
    }
}
struct SportsListMobel : Mappable {
    var response : SportsListResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
    
}
struct SportsListResponse : Mappable {
    var rest : [SportsListRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["Rest"]
    }
}
struct SportsListRest : Mappable {
    var id : String?
    var sportsName : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["Id"]
        sportsName <- map["SportsName"]
    }
}
struct LevelListModel : Mappable {
    var response : LevelListResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct LevelListResponse : Mappable {
    var rest : [LevelListRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["Rest"]
    }
}
struct LevelListRest : Mappable {
    var id : String?
    var levelName : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["Id"]
        levelName <- map["LevelName"]
    }
}
struct ActivityListMobel : Mappable {
    var response : ActivityListResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct ActivityListResponse : Mappable {
    var rest : [ActivityListRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        rest <- map["Rest"]
    }
}
struct ActivityListRest : Mappable {
    var id : String?
    var activity : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["Id"]
        activity <- map["Activity"]
    }
}

struct ActivityEntryListModel : Mappable {
    var response : ActivityEntryListResponse?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}

struct ActivityEntryListResponse: Mappable {
    var rest : [ActivityEntryListRest]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        rest <- map["Rest"]
    }
}
struct ActivityEntryListRest: Mappable {
    
    var id, adminno, stname, category, classname, attachment, file, activityid, activity, year, level, prizeWon, des : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["Id"]
        adminno <- map["adminno"]
        stname <- map["stname"]
        category <- map["category"]
        classname <- map["classname"]
        attachment <- map["attachment"]
        file <- map["file"]
        activityid <- map["Activityid"]
        activity <- map["Activity"]
        year <- map["Year"]
        level <- map["Level"]
        prizeWon <- map["PrizeWon"]
        des <- map["des"]
    }
}
struct SportsEntryListModel : Mappable {
   
    var response : SportsEntryListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct SportsEntryListResponse : Mappable {
    var rest : [SportsEntryListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["Rest"]
    }
}

struct SportsEntryListRest : Mappable {
    var category,id,adminno,stname,classname,sportsId,sportsName,year,level,prizeWon,des,file,attachment: String?
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        
        category <- map["category"]
        id <- map["Id"]
        adminno <- map["adminno"]
        stname <- map["stname"]
        classname <- map["classname"]
        attachment <- map["attachment"]
        file <- map["file"]
        sportsId <- map["SportsId"]
        sportsName <- map["SportsName"]
        year <- map["Year"]
        level <- map["Level"]
        prizeWon <- map["PrizeWon"]
        des <- map["des"]
    }
}

//MARK: - Employee Circular model

struct EmployeeCircularListModel : Mappable {
    var response : EmployeeCircularListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct EmployeeCircularListResponse : Mappable {
    var res : [EmployeeCircularListRes]?

    init?(map: Map) {}
    mutating func mapping(map: Map) {

        res <- map["Res"]
    }
}
struct EmployeeCircularListRes : Mappable {
    var id ,attachment ,count ,unique_id ,title ,by ,description ,created_Date : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        attachment <- map["attachment"]
        count <- map["count"]
        unique_id <- map["unique_id"]
        title <- map["title"]
        by <- map["by"]
        description <- map["description"]
        created_Date <- map["Created_Date"]
    }
}
//MARK: - View Employee Circular model
struct ViewEmpCircularModel : Mappable {
    var file, extraFile, empName, id, unique_id, description, created_Date : String?
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {

        file <- map["file"]
        extraFile <- map["ExtraFile"]
        empName <- map["EmpName"]
        id <- map["id"]
        unique_id <- map["unique_id"]
        description <- map["description"]
        created_Date <- map["Created_Date"]
    }
}
//MARK: - Read Status Model
struct ReadStatusListModel : Mappable {
    var response : ReadStatusListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        response <- map["response"]
    }

}
struct ReadStatusListResponse : Mappable {
    var res : [ReadStatusListRes]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        res <- map["Res"]
    }

}
struct ReadStatusListRes : Mappable {
    var id : String?
    var status : String?
    var staff : String?
    var staffcode : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        status <- map["status"]
        staff <- map["staff"]
        staffcode <- map["staffcode"]
    }

}
//MARK: Student Circular Model
struct StudentCircularModel : Mappable {
    var response : StudentCircularResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct StudentCircularResponse : Mappable {
    var rest : [StudentCircularRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}
struct StudentCircularRest : Mappable {
    var count : Int?
    var id, enrollno, circular_date, title, description, className, sectionName, status, studentType, groupName, file, pdf : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        count <- map["count"]
        id <- map["id"]
        enrollno <- map["enrollno"]
        circular_date <- map["circular_date"]
        title <- map["title"]
        description <- map["description"]
        className <- map["ClassName"]
        sectionName <- map["SectionName"]
        status <- map["status"]
        studentType <- map["StudentType"]
        groupName <- map["GroupName"]
        file <- map["file"]
        pdf <- map["pdf"]
    }
}
//MARK: Hostel List Model
struct HostelListModel : Mappable {
    var response : HostelListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct HostelListResponse : Mappable {
    var rest : [HostelListRest]?
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        rest <- map["rest"]
    }
}
struct HostelListRest : Mappable {
    var hostelId : String?
    var hostelName : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        hostelId <- map["HostelId"]
        hostelName <- map["HostelName"]
    }
}
//MARK: Floor List Model
struct FloorListModel : Mappable {
    var response : FloorListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct FloorListResponse : Mappable {
    var rest : [FloorListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}
struct FloorListRest : Mappable {
    var floorID : String?
    var floorName : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        floorID <- map["FloorID"]
        floorName <- map["FloorName"]
    }
}

//MARK: Room List Model
struct RoomListModel : Mappable {
    var response : RoomListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct RoomListResponse : Mappable {
    var rest : [RoomListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}
struct RoomListRest : Mappable {
    var roomid : String?
    var room : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        roomid <- map["Roomid"]
        room <- map["Room"]
    }
}
//MARK: Daily Activity LogList Model
struct DailyActivityLogListModel : Mappable {
    var response : DALListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        response <- map["response"]
    }

}

struct  DALListResponse : Mappable {
    var rest : [DALListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["Rest"]
    }
}

struct  DALListRest : Mappable {
    var file : String?
    var empName : String?
    var id : String?
    var empCode : String?
    var description : String?
    var date : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        file <- map["file"]
        empName <- map["EmpName"]
        id <- map["id"]
        empCode <- map["EmpCode"]
        description <- map["description"]
        date <- map["date"]
    }
}
//MARK: Marks Entry Class List
struct  MarksClassSecListModel : Mappable {
    var response : MarksClassSecListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }

}

struct MarksClassSecListResponse : Mappable {
    var res : [MarksClassSecListRes]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        res <- map["Res"]
    }
}

struct MarksClassSecListRes : Mappable {
    var classid : String?
    var className : String?
    var sectionId : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        classid <- map["Classid"]
        className <- map["ClassName"]
        sectionId <- map["SectionId"]
    }

}
//MARK: Marks Entry Exam Head List

struct ExamHeadListModel : Mappable {
    var response : ExamHeadListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }

}

struct ExamHeadListResponse : Mappable {
    var rest : [ExamHeadListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}

struct ExamHeadListRest : Mappable {
    var id : String?
    var head : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        head <- map["head"]
    }

}
//MARK: Marks Entry Exam test List Model
struct ExamtestListModel : Mappable {
    var response : ExamtestListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        
        response <- map["response"]
    }
}
struct ExamtestListResponse : Mappable {
    var rest : [ExamtestListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}
struct ExamtestListRest : Mappable {
    var test : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        
        test <- map["test"]
    }
}

//MARK: Marks Entry Exam Type List Model
struct ExamTypeListModel : Mappable {
    var response : ExamTypeListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        response <- map["response"]
    }
}
struct ExamTypeListResponse : Mappable {
    var rest : [ExamTypeListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}
struct ExamTypeListRest : Mappable {
    var type : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        type <- map["Type"]
    }
}

//MARK: Marks Entry Get Subjects list
struct SubjectsListModel : Mappable {
    var response : SubjectsListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}

struct SubjectsListResponse : Mappable {
    var rest : [SubjectsListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}

struct SubjectsListRest : Mappable {
    var subjectId : String?
    var subjectName : String?
    var examid : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        subjectId <- map["SubjectId"]
        subjectName <- map["SubjectName"]
        examid <- map["examid"]
    }

}
//MARK: Get Total Marks
struct TotalMarksModel : Mappable {
    var status : String?
    var msg : String?
    var examdate : String?
    var total : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["status"]
        msg <- map["msg"]
        examdate <- map["examdate"]
        total <- map["total"]
    }
}
//MARK: Student Detail List
struct StudentDetailListModel  : Mappable {
    var count : Int?
    var sno : String?
    var status : String?
    var message : String?
    var locked : String?
    var response : StudentDetailListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        count <- map["count"]
        sno <- map["sno"]
        status <- map["status"]
        message <- map["message"]
        locked <- map["locked"]
        response <- map["response"]
    }

}
struct StudentDetailListResponse : Mappable {
    var rest : [StudentDetailListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }

}
struct StudentDetailListRest : Mappable {
    var studentId, studentDetailId, enrollNo, rollNo, studentName, studentImage,
        fatherName, attendence, savedmarks, max, locked : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        studentId <- map["StudentId"]
        studentDetailId <- map["StudentDetailId"]
        enrollNo <- map["EnrollNo"]
        rollNo <- map["RollNo"]
        studentName <- map["StudentName"]
        studentImage <- map["StudentImage"]
        fatherName <- map["FatherName"]
        attendence <- map["Attendence"]
        savedmarks <- map["savedmarks"]
        max <- map["Max"]
        locked <- map["locked"]
    }
}
//MARK: Student Type Model
struct StudentTypeListModel : Mappable {
    var response : StudentTypeListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct StudentTypeListResponse : Mappable {
    var rest : [StudentTypeListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}
struct StudentTypeListRest : Mappable {
    var studentTypeID : String?
    var studentTypeName : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        studentTypeID <- map["StudentTypeID"]
        studentTypeName <- map["StudentTypeName"]
    }
}
//MARK: Student Circular Classes list
struct StCircularClListModel : Mappable {
    var response : StCircularClListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct StCircularClListResponse : Mappable {
    var rest : [StCircularClListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}
struct StCircularClListRest : Mappable {
    var class_id, class_name, section_id: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        class_id <- map["class_id"]
        class_name <- map["class_name"]
        section_id <- map["section_id"]
    }
}
//MARK: Student List For Circular

struct CircularStudentListModel : Mappable {
    var response : CircularStudentListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}

struct CircularStudentListResponse : Mappable {
    var rest : [CircularStudentListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}
struct CircularStudentListRest : Mappable {
    var admission_no, studentName, fatherName, mobileNo, studentImage, classId, className, sectionName, sectionId   : String?
    var isSelected: Bool = false
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        admission_no <- map["Admission_no"]
        studentName <- map["StudentName"]
        fatherName <- map["FatherName"]
        mobileNo <- map["MobileNo"]
        studentImage <- map["StudentImage"]
        classId <- map["ClassId"]
        className <- map["ClassName"]
        sectionName <- map["SectionName"]
        sectionId <- map["SectionId"]
    }

}
//MARK: FeedbackList Model
//(26/sep/2023)
struct FeedbackListModel : Mappable {
    var response : FeedbackListModelResponse?
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct FeedbackListModelResponse : Mappable {
    var res : [FeedbackListModelTRes]?
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {

        res <- map["Res"]
    }
    
}
struct FeedbackListModelTRes : Mappable {
    var student_id, type, enrollNo, parameter, studentMarks, studentName, studentImage, studentClass, mobileNo, studentSection, created_Date : String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        
        student_id <- map["id"]
        type <- map["Type"]
        enrollNo <- map["EnrollNo"]
        parameter <- map["Parameter"]
        studentMarks <- map["Marks"]
        studentName <- map["StudentName"]
        studentImage <- map["StudentImage"]
        studentClass <- map["Class"]
        mobileNo <- map["MobileNo"]
        studentSection <- map["Section"]
        created_Date <- map["Created_Date"]
        
    }
}
//MARK: E-Complaint Record List
//(26/sep/2023)
struct PendingResolvedModel : Mappable {
    var response : PandingResolvedResponse?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        
        response <- map["response"]
    }
    
}
struct PandingResolvedResponse : Mappable {
    var rest : [PandingResolvedRest]?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}
struct PandingResolvedRest : Mappable {
    var empCode, id, description, locationName, status, resolveReason, date : String?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        
        empCode <- map["EmpCode"]
        id <- map["id"]
        description <- map["description"]
        locationName <- map["LocationName"]
        status <- map["status"]
        resolveReason <- map["ResolveReason"]
        date <- map["date"]
    }
}
//MARK:  Extra Day Entry List
struct ExtraDayEntryListModel : Mappable {
    var response : ExtraDayEntryListResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }

}
struct ExtraDayEntryListResponse : Mappable {
    var rest : [ExtraDayEntryListRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["Rest"]
    }

}
struct ExtraDayEntryListRest : Mappable {
    var id, date, reason, empCode, status, empName : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        date <- map["date"]
        reason <- map["reason"]
        empCode <- map["EmpCode"]
        status <- map["status"]
        empName <- map["EmpName"]
    }
}

//MARK: Medical Entry List Model
struct MedicalEntryLeavesModel : Mappable {
    var response : MedicalEntryLeavesResponse?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        
        response <- map["response"]
    }
}
struct MedicalEntryLeavesResponse : Mappable {
    var rest : [MedicalEntryLeavesRest]?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        
        rest <- map["rest"]
    }
}
struct MedicalEntryLeavesRest : Mappable {
    var enrollNo, studentName, className, section, allergies, medicalHistory, hospitaldatefrom, hospitaldateto, date, temperature, bp, diagnosis, medicine, days, dose, rate, doseqty  : String?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        
        enrollNo <- map["enrollNo"]
        studentName <- map["StudentName"]
        className <- map["className"]
        section <- map["section"]
        allergies <- map["allergies"]
        medicalHistory <- map["medicalHistory"]
        hospitaldatefrom <- map["hospitaldatefrom"]
        hospitaldateto <- map["hospitaldateto"]
        date <- map["date"]
        temperature <- map["temperature"]
        bp <- map["bp"]
        diagnosis <- map["diagnosis"]
        medicine <- map["medicine"]
        days <- map["days"]
        dose <- map["dose"]
        rate <- map["rate"]
        doseqty <- map["doseqty"]
    }
}
//MARK: Medical Entry Model
struct MedicalEntryModel : Mappable {
    var status, msg : String?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        status <- map["status"]
        msg <- map["msg"]
    }
    
}
//MARK: Send Parameter Model
struct SendParameterModel : Mappable {
    var others : String?
    var response : SendParameterResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        others <- map["others"]
        response <- map["response"]
    }
}
struct SendParameterResponse : Mappable {
    var res : [SendParameterRes]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        res <- map["Res"]
    }
}

struct SendParameterRes : Mappable {
    var id : String?
    var reasons : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        reasons <- map["Reasons"]
    }
}
//MARK: Principal Login Models
//MARK: Daily Activity Log Employes model
struct DailyActLogEmpModel : Mappable {
    var status : String?
    var msg : String?
    var empCode : String?
    var response : DailyActLogEmpResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        status <- map["status"]
        msg <- map["msg"]
        empCode <- map["EmpCode"]
        response <- map["response"]
    }
}
struct DailyActLogEmpResponse : Mappable {
    var rest : [DailyActLogEmpRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["Rest"]
    }
}
struct DailyActLogEmpRest : Mappable {
    var file : String?
    var empName : String?
    var empCode : String?
    var id : String?
    var description : String?
    var date : String?
    var fileType : String?
    var extraFile : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        file <- map["file"]
        empName <- map["EmpName"]
        empCode <- map["EmpCode"]
        id <- map["id"]
        description <- map["description"]
        date <- map["date"]
        fileType <- map["FileType"]
        extraFile <- map["ExtraFile"]
    }
}
//MARK: Show Ptm Branch Model
struct ShowPTMBranchModel : Mappable {
    var status : String?
    var message : String?
    var response : ShowPTMBranchResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        status <- map["status"]
        message <- map["message"]
        response <- map["response"]
    }

}
struct ShowPTMBranchResponse : Mappable {
    var rest : [ShowPTMBranchRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}
struct ShowPTMBranchRest : Mappable {
    var rollNo : String?
    var description : String?
    var studentName : String?
    var empCode : String?
    var name : String?
    var jobType : String?
    var departmentName : String?
    var enrollNo : String?
    var talkWith : String?
    var mobile : String?
    var date : String?
    var className : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rollNo <- map["RollNo"]
        description <- map["Description"]
        studentName <- map["StudentName"]
        empCode <- map["EmpCode"]
        name <- map["name"]
        jobType <- map["JobType"]
        departmentName <- map["DepartmentName"]
        enrollNo <- map["EnrollNo"]
        talkWith <- map["TalkWith"]
        mobile <- map["Mobile"]
        date <- map["date"]
        className <- map["ClassName"]
    }
}
//MARK: Parent Suggestion Model (18-oct-2023)

struct FeedbackSuggestionModel : Mappable {
    var status : String?
    var message : String?
    var res : [FeedbackSuggestionRes]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        status <- map["status"]
        message <- map["message"]
        res <- map["res"]
    }
}
struct FeedbackSuggestionRes: Mappable {
    var FeedbackId, EnrollNo, feedback, phone, email, relation, gurdianname, Reply, Status: String?

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        FeedbackId <- map["FeedbackId"]
        EnrollNo <- map["EnrollNo"]
        feedback <- map["feedback"]
        phone <- map["phone"]
        email <- map["email"]
        relation <- map["relation"]
        gurdianname <- map["gurdianname"]
        Reply <- map["Reply"]
        Status <- map["Status"]
        
    }
    
}
//MARK: Emp Leave Request Model (18-oct-2023)
struct RequestForExtraDayModel : Mappable {
    var status : String?
    var message : String?
    var response : RequestForExtraDayResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        status <- map["status"]
        message <- map["msg"]
        response <- map["response"]
    }

}
struct RequestForExtraDayResponse : Mappable {
    var rest : [RequestForExtraDayRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["Rest"]
    }
}
struct RequestForExtraDayRest : Mappable {
    var id : String?
    var date : String?
    var reason : String?
    var EmpCode : String?
    var status : String?
    var EmpName : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        date <- map["date"]
        reason <- map["reason"]
        EmpCode <- map["EmpCode"]
        status <- map["status"]
        EmpName <- map["EmpName"]
       
    }
}
struct EmployeeLeaveRequestModel : Mappable {
    var response : EmployeeLeaveRequestResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
struct EmployeeLeaveRequestResponse : Mappable {
    var rest : [EmployeeLeaveRequestRest]?
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        rest <- map["rest"]
    }
}
struct EmployeeLeaveRequestRest : Mappable {
    var leaveId : String?
    var empCode : String?
    var empName : String?
    var dateFrom : String?
    var dateTo : String?
    var days : String?
    var leaveType : String?
    var reason : String?
    var status : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        leaveId <- map["LeaveId"]
        empCode <- map["EmpCode"]
        empName <- map["EmpName"]
        dateFrom <- map["DateFrom"]
        dateTo <- map["DateTo"]
        days <- map["Days"]
        leaveType <- map["LeaveType"]
        reason <- map["Reason"]
        status <- map["Status"]
    }
}
//E Complaint For Principal List
struct EComplaintPrincipalListModel : Mappable {
    var response : EComplaintPrincipalListModelResponse?
    init?(map: Map) {}

    mutating func mapping(map: Map) {

        response <- map["response"]
    }
}
struct EComplaintPrincipalListModelResponse : Mappable {
    var rest : [EComplaintPrincipalListModelRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        rest <- map["rest"]
    }
}
struct EComplaintPrincipalListModelRest : Mappable {
    var ecomplaint_by : String?
    var ecomplaint_to : String?
    var id : String?
    var description : String?
    var locationName : String?
    var status : String?
    var resolveReason : String?
    var date : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        ecomplaint_by <- map["ecomplaint_by"]
        ecomplaint_to <- map["ecomplaint_to"]
        id <- map["id"]
        description <- map["description"]
        locationName <- map["LocationName"]
        status <- map["status"]
        resolveReason <- map["ResolveReason"]
        date <- map["date"]
    }
}
// Daily Agenda Model
struct DailyAgendaModel : Mappable {
    var response : DailyAgendaModelResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        response <- map["response"]
    }

}
struct DailyAgendaModelResponse : Mappable {
    var data : [DailyAgendaModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        data <- map["data"]
    }
}
struct DailyAgendaModelData : Mappable {
    var date : String?
    var item : [DailyAgendaModelItem]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        date <- map["date"]
        item <- map["item"]
    }
}
struct DailyAgendaModelItem : Mappable {
    var id : String?
    var activity : String?
    var officeResponsibilty : String?
    var circularno : String?
    var staffid : String?
    var staff_name : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        activity <- map["activity"]
        officeResponsibilty <- map["OfficeResponsibilty"]
        circularno <- map["circularno"]
        staffid <- map["staffid"]
        staff_name <- map["staff_name"]
    }
}
