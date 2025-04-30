//
//  UserModel.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/07/23.
//

import Foundation
import ObjectMapper

struct UserModel : Mappable {
    var EmpCode : String?
    var name : String?
    var EmpTypeID : String?
    var JobType : String?
    var SessionName : String?
    var DepartmentName : String?
    var LoginTypeName : String?
    var DesignationName : String?
    var DOB : String?
    var DOJ : String?
    var ResidentialAddress : String?
    var MobileNo : String?
    var EmpCategory : String?
    var Gender : String?
    var response : String?
    var Session : String?
    var image : String?
    var profil_pic : String?
    var BranchId : String?
    var branchName : String?
    var SectionName : String?
    var SectionId : String?
    var Classid : String?
    var ClassName : String?
    var IsCoordinator : String?
    var IsIncharge : String?
    
    init?(map:Map) {}
    
    mutating func mapping(map:Map) {
        EmpCode <- map["EmpCode"]
        name <- map["name"]
        EmpTypeID <- map["EmpTypeID"]
        SessionName <- map["SessionName"]
        DepartmentName <- map["DepartmentName"]
        LoginTypeName <- map["LoginTypeName"]
        DesignationName <- map["DesignationName"]
        DOB <- map["DOB"]
        DOJ <- map["DOJ"]
        ResidentialAddress <- map["ResidentialAddress"]
        MobileNo <- map["MobileNo"]
        EmpCategory <- map["EmpCategory"]
        Gender <- map["Gender"]
        response <- map["response"]
        Session <- map["Session"]
        image <- map["image"]
        profil_pic <- map["profil_pic"]
        BranchId <- map["BranchId"]
        branchName <- map["branchName"]
        SectionName <- map["SectionName"]
        Classid <- map["Classid"]
        ClassName <- map["ClassName"]
        IsCoordinator <- map["IsCoordinator"]
        IsIncharge <- map["IsIncharge"]
    }
}

