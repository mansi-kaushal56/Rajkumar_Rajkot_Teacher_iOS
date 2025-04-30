//
//  CommonObject.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 28/07/23.
//

import Foundation
import Toast_Swift
import SVProgressHUD
import ObjectMapper
//25/10/2023

struct CommonObjects {
    static let shared = CommonObjects()
    func showToast(message : String,controller : UIViewController) {
        controller.view.makeToast(message)
    }
    func showToast(message:String) {
        let windows = UIApplication.shared.windows
        windows.last?.makeToast(message,duration: 3.0, position: .bottom)
    }
    func showProgress() {
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor(.AppLoaderPink)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.appearance().ringRadius = 10
        SVProgressHUD.appearance().ringThickness = 5
        SVProgressHUD.show()
    }
    
    func stopProgress() {
        SVProgressHUD.dismiss()
    }
}
class DataManager: RequestApiDelegate {
    var classListObj: FillClassModel?
    var classId: String? // Add classId property
    var selectedSectionArr = [ShowSectionRest]()
    
    static let shared = DataManager()
    private init() {
        // Private initializer to enforce singleton pattern
    }

    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_fillclass.getEndPoints {
            let status = response["status"] as! String
            let message = response["msg"] as! String
            if status == "true" {
                if let classListDictData = Mapper<FillClassModel>().map(JSONObject: response) {
                    classListObj = classListDictData
                    DispatchQueue.main.async {
                        // Handle success and update UI here
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message)
                }
            }
        }
    }

    func failure() {
        // Handle failure
    }

    

    private var classesData: FillClassModel?
    private var sectionsData: ShowSectionModel?
    private var subjectsData: SubjectListModel?

    private var hasFetchedClassesData = false
    private var hasFetchedSectionsData = false
    private var hasFetchedSubjectsData = false

    func fetchClassesDataIfNeeded(completion: @escaping (Result<FillClassModel, Error>) -> Void) {
        if hasFetchedClassesData {
            if let data = classesData {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "Data not available", code: 0, userInfo: nil)))
            }
        } else {
            // Fetch classes data from the API
            CommonObjects.shared.showProgress()
            let strUrl = "\(BASE_URL)\(END_POINTS.Api_fillclass.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")"
            let obj = ApiRequest()
            obj.delegate = self
            obj.requestAPI(apiName: END_POINTS.Api_fillclass.getEndPoints, apiRequestURL: strUrl)
           // { (result: Result<FillClassModel,Error>) in // Explicitly specify the type
//                switch result {
//                case .success(let data):
//                    self.classesData = data
//                    self.hasFetchedClassesData = true
//
//                    // Set classId when you have access to it
//                    self.classId = data.response?.res?.first?.classid
//
//                    completion(.success(data))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
                
           // }
        }
    }


    func fetchSectionsDataIfNeeded(completion: @escaping (Result<ShowSectionModel, Error>) -> Void) {
        if hasFetchedSectionsData {
            if let data = sectionsData {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "Data not available", code: 0, userInfo: nil)))
            }
        } else {
            // Fetch sections data from the API
            CommonObjects.shared.showProgress()
            let strUrl = "\(BASE_URL)\(END_POINTS.Api_Show_Section.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&ClassId=\(classListObj?.response?.res?[0].classId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
            let obj = ApiRequest()
            obj.delegate = self
            obj.requestAPI(apiName: END_POINTS.Api_Show_Section.getEndPoints, apiRequestURL: strUrl)
        }
    }

    func fetchSubjectsDataIfNeeded(completion: @escaping (Result<SubjectListModel, Error>) -> Void) {
        if hasFetchedSubjectsData {
            if let data = subjectsData {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "Data not available", code: 0, userInfo: nil)))
            }
        } else {
            // Fetch subjects data from the API
            var temlistArr = [String]()
            for listaData in selectedSectionArr {
                temlistArr.append(listaData.sectionId ?? "")
            }
            let selSectionIds = temlistArr.joined(separator: ",")

            CommonObjects.shared.showProgress()
            let strUrl = "\(BASE_URL)\(END_POINTS.Api_Subject_List.getEndPoints).php?EmpCode=\(UserDefaults.getUserDetail()?.EmpCode ?? "")&SectionId=\(selSectionIds)&ClassId=\(classId ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")"
            let obj = ApiRequest()
            obj.delegate = self
            obj.requestAPI(apiName: END_POINTS.Api_Subject_List.getEndPoints, apiRequestURL: strUrl)
        }
    }
}
