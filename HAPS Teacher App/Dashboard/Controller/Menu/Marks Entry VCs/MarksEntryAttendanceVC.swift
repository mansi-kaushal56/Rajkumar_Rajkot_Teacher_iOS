//
//  MarksEntryAttendanceVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 21/09/23.
//

import UIKit

protocol AttendenceDelegate {
    func attendence(index: Int?, data: StudentDetailListRest?)
}

class MarksEntryAttendanceVC: UIViewController {
    var delegate: AttendenceDelegate?
    var studentAttend: StudentDetailListRest?
    var index: Int?
    @IBOutlet weak var fullScreenStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(studentAttend ?? "")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func presentBtnAction(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true)
        sendData(attendence: "P")
    }
    @IBAction func absntBtnAction(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true)
        sendData(attendence: "A")

    }
    @IBAction func medicalBtnAction(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true)
        sendData(attendence: "M")

    }
    @IBAction func exemptedBtnAction(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true)
        sendData(attendence: "E")
    }
    
    func sendData(attendence: String){
        studentAttend?.attendence = attendence
        studentAttend?.savedmarks = "0"
        delegate?.attendence(index: index, data: studentAttend)

    }
}
extension MarksEntryAttendanceVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self.fullScreenStackView {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
