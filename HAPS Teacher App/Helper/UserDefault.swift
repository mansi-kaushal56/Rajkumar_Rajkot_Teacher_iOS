//
//  UserDefault.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 31/07/23.
//

import Foundation
import ObjectMapper

extension UserDefaults {
    
    static func setDetails(_ value: String, keyName : String) {
        standard.set(getArchived(data: value), forKey: "userId")
        
    }

    static func getDetails(keyName:String) -> String? {
        if let value =  getUnArchived(data: standard.value(forKey:"userId") as? Data) as? String {
             return value
         }
        return nil
    }

    static func setUserDetail(_ detail: UserModel) {
        if let userJSON = Mapper<UserModel>().toJSONString(detail) {
            standard.set(getArchived(data: userJSON), forKey: "userdata")
        }
    }

    static func getUserDetail() -> UserModel? {
        if let userJSON =  getUnArchived(data: standard.value(forKey: "userdata") as? Data) as? String {
             return Mapper<UserModel>().map(JSONString: userJSON)
         }
        return nil
    }
    
    static func removeAppData() {
        let fcmToken = getDetails(keyName: "userId") ?? ""
        standard.removeObject(forKey: "userdata")
        setDetails(fcmToken, keyName: "userId")
    }
}

private func getArchived(data:Any) -> Data {
    var encodedData = Data()

    do {
        if let data = data as? String {
            encodedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
        } else  if let data = data as? Int {
            encodedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
        } else  if let data = data as? Bool {
            encodedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
        }
        return encodedData
        
    } catch {
        print("Couldn't write file")
    }
    
    return encodedData
}

private func getUnArchived(data:Data?) -> Any? {
    
    do {
        if data != nil {
            let decodedData =  try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!)
            return decodedData
        }
    } catch {
        print("Couldn't read file.")
    }
    
    return nil
}
