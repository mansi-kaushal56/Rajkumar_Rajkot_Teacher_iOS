//
//  DailyTaskAgendaVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 11/08/23.
//

import UIKit

class DailyTaskAgendaVC: UIViewController {

    @IBOutlet weak var viewAgendaView: ViewBorder!
    @IBOutlet weak var tskAgendaTxtView: UITextView!
    @IBOutlet weak var dateTxlFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Daily Task Agenda")
        let tap = UITapGestureRecognizer()
        viewAgendaView.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(viewAgenda))
        self.dateTxlFld.setDatePickerAsInputViewFor(target: self, selector: #selector(datePicker2))
        // Do any additional setup after loading the view.
    }
    @objc func viewAgenda() {
        performSegue(withIdentifier: AppStrings.AppSegue.agendaSegue.getDescription, sender: nil)
    }
    @objc func datePicker2(_ sender:UITapGestureRecognizer){
           if let datePicker = self.dateTxlFld.inputView as? UIDatePicker {
               
//               if datePicker.date.isGreater(Date()){
//                   CommonObject.shared.showToast(message: AppMessages.CANNOT_USE_FUTURE_DATE, controller: self)
//                   self.dobTxtFld.resignFirstResponder()
//                   return
//               }
   //MARK: - Date Format
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd-MM-yyyy"
               
               self.dateTxlFld.text = dateFormatter.string(from: datePicker.date)
           }
           self.dateTxlFld.resignFirstResponder()
       }
    @IBAction func submitBtnAction(_ sender: Any) {
    }
}

