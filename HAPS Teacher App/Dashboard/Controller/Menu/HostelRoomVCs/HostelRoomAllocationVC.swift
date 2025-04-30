//
//  HostelRoomAllocationVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 13/09/23.
//

import UIKit
import ObjectMapper

class HostelRoomAllocationVC: UIViewController {
    
// MARK: Student Search Api (03/oct/2023)
    var studentSearchObj: StudentSearchModel?
    
// MARK: Room List Api (04/OCT/2023)
    var hostelListObj: HostelListModel?
    var selectedHostel: HostelListRest?
    
    var floorListObj: FloorListModel?
    var selectedFloorList: FloorListRest?
    
    var roomListObj: RoomListModel?
    var selectedRoomList: RoomListRest?

    var stname: String?
    var stEnollno: String?
    var stClassName: String?

    @IBOutlet weak var searchByNameTxtFld: UITextField!
    @IBOutlet weak var statusTxtFld: UITextField!
    @IBOutlet weak var selectRoomTxtFld: UITextField!
    @IBOutlet weak var selectFloorTxtFld: UITextField!
    @IBOutlet weak var selectHostelTxtFld: UITextField!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var selectRoomView: UIView!
    @IBOutlet weak var slectFloorView: UIView!
    @IBOutlet weak var selectHostelView: UIView!
    @IBOutlet weak var allocationDateTxtFld: UITextField!
    @IBOutlet weak var studentAddressLbl: UILabel!
    @IBOutlet weak var mobileNoLbl: UILabel!
    @IBOutlet weak var studentfNameLbl: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var studentClassLbl: UILabel!
    @IBOutlet weak var studentDeatilView: UIView!
    @IBOutlet weak var searchStudentTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewRecordBtn()
        backBtn(title: "Hostel Room Allocation")
        tapGestureRecognizers()
        self.hostelListApi()
        self.floorListApi()
        self.studentDeatilView.clipsToBounds = true
        self.studentDeatilView.isHidden = true
        self.allocationDateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker))
        // Do any additional setup after loading the view.
    }
    @IBAction func searchBtnAction(_ sender: UIButton) {
        searchStudentApi()
    }
   
    @IBAction func allocateRoomBtnAction(_ sender: UIButton) {
    }
    
//MARK: (04/OCT/2023)
    @objc func datePicker(_ sender:UITapGestureRecognizer){
        if let datePicker = self.allocationDateTxtFld.inputView as? UIDatePicker {
            
            //MARK: - Date Format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.allocationDateTxtFld.text = dateFormatter.string(from: datePicker.date)
        }
        self.allocationDateTxtFld.resignFirstResponder()
    }
// MARK: (03/oct/2023)
    func showStudentdetail() {
        studentNameLbl.text = studentSearchObj?.name
        studentClassLbl.text = studentSearchObj?.className
        studentfNameLbl.text = studentSearchObj?.fatherName
        mobileNoLbl.text = studentSearchObj?.mobileNo
        studentAddressLbl.text = studentSearchObj?.address
        stname = studentSearchObj?.name
        stEnollno = studentSearchObj?.enrollNo
        stClassName = studentSearchObj?.className
    }
    func viewRecordBtn() {
        let viewRecordButton = UIBarButtonItem(image: UIImage.viewEyeIcon, style: .plain, target: self, action: #selector(ViewRecord))
        navigationItem.rightBarButtonItem = viewRecordButton
    }
    
    @objc func ViewRecord() {
        performSegue(withIdentifier: AppStrings.AppSegue.roomAllocateDetailSegue.getDescription, sender: nil)
    }
    
//MARK: (04/OCT/2023)
    func tapGestureRecognizers() {
        selectHostelView.addTapGestureRecognizer {
            self.listAppear(type: .hostelList)
        }
        slectFloorView.addTapGestureRecognizer {
            self.listAppear(type: .floorList)
        }
        selectRoomView.addTapGestureRecognizer {
            self.listAppear(type: .roomList)
        }
        statusView.addTapGestureRecognizer {
            self.statusListSelection()
        }
        
    }
    
//MARK: (04/OCT/2023)
    func statusListSelection() {
        let statusList = ["Active", "InActive", "Cancel"]
        showSelectionOptions(title: "Status", options: statusList) { [weak self] selectedOption in
            if selectedOption != "Cancel" {
                self?.statusTxtFld.text = selectedOption
            }
        }
    }
    
//MARK: (04/OCT/2023)
    func listAppear(type:ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStrings.AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppStrings.ViewControllerIdentifiers.listAppearVC.getIdentifier) as! ListAppearVC
        vc.modalPresentationStyle = .overFullScreen
        switch type {
        case .hostelList:
            vc.senderDelegate = self
            vc.hostelListAppearObj = hostelListObj
            vc.type = .hostelList
        case .floorList:
            vc.senderDelegate = self
            vc.floorListAppearObj = floorListObj
            vc.type = .floorList
        case .roomList:
            vc.senderDelegate = self
            vc.roomListAppearObj = roomListObj
            vc.type = .roomList
            
        default:
            print("Unkown List Type")
        }
        self.present(vc, animated: true)
    }
}

//MARK: (04/OCT/2023)
extension HostelRoomAllocationVC: SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .hostelList:
            selectedHostel = data as? HostelListRest
            selectHostelTxtFld.text = selectedHostel?.hostelName
            
        case .floorList:
            selectedFloorList = data as? FloorListRest
            selectFloorTxtFld.text = selectedFloorList?.floorName
            roomListApi()
            
        case .roomList:
            selectedRoomList = data as? RoomListRest
            selectRoomTxtFld.text = selectedRoomList?.room
       
        default :
            print("Unknown Type")
        }
    }
}

// MARK: (03/oct/2023)
extension HostelRoomAllocationVC {
    func searchStudentApi() {
        let studentSearch = searchStudentTxtFld.text ?? ""
        let searchByName = searchByNameTxtFld.text ?? ""
        if studentSearch.isEmpty && searchByName.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_STUDENT_EMPTY, controller: self)
            return
        }
        
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Student_Search.getEndPoints).php?BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")&SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&adminno=\(studentSearch)&name=\(searchByName)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Student_Search.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    func hostelListApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Hostel_List.getEndPoints).php"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Hostel_List.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    func floorListApi() {
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Floor_List.getEndPoints).php"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Floor_List.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    func roomListApi() {
        let hostelList = selectHostelTxtFld.text ?? ""
        if hostelList.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_HOSTEL_EMPTY, controller: self)
            return
        }
        let floorList = selectFloorTxtFld.text ?? ""
        if floorList.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FLOOR_EMPTY, controller: self)
            return
        }
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Room_List.getEndPoints).php?HostelId=\(selectedHostel?.hostelId ?? "")&FloorId=\(selectedFloorList?.floorID ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Room_List.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}

// MARK: (03/oct/2023)
extension HostelRoomAllocationVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Student_Search.getEndPoints {
            let status = response["status"] as! String
            if status == "true" {
                if let studentlistDictData = Mapper<StudentSearchModel>().map(JSONObject: response) {
                    studentSearchObj = studentlistDictData
                    DispatchQueue.main.async {
                        self.studentDeatilView.isHidden = false
                        self.showStudentdetail()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_STUDENT)
                }
            }
        }
        if api == END_POINTS.Api_Hostel_List.getEndPoints {
            let status = response["status"] as! Bool
            if status == true {
                if let hostelListDictData = Mapper<HostelListModel>().map(JSONObject: response) {
                    hostelListObj = hostelListDictData
                    
                }
            }
        }
        if api == END_POINTS.Api_Floor_List.getEndPoints {
            let status = response["status"] as! Bool
            if status == true {
                if let floorListDictData = Mapper<FloorListModel>().map(JSONObject: response) {
                    floorListObj = floorListDictData

                }
            }
        }
        if api == END_POINTS.Api_Room_List.getEndPoints {
            let status = response["status"] as! Bool
            if status == true {
                if let roomListDictData = Mapper<RoomListModel>().map(JSONObject: response) {
                    roomListObj = roomListDictData
                }
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR)
        }
    }
}
