//
//  TaskManagementVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 07/08/23.
//

import UIKit
import Kingfisher

class TaskManagementVC: UIViewController {

    @IBOutlet weak var assignTaskView: UIView!
    @IBOutlet weak var taskAssignBymeView: UIView!
    @IBOutlet weak var taskAssignTomeView: UIView!
    @IBOutlet weak var teacherNameLbl: UILabel!
    @IBOutlet weak var teacherImgView: UIImageView!
    @IBOutlet weak var tDesignationNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Task Management")
        setTeacherDetail()
        let assignTask = UITapGestureRecognizer()
        assignTaskView.addGestureRecognizer(assignTask)
        assignTask.addTarget(self, action: #selector(taskAssignScreen))
        
        let assignTome = UITapGestureRecognizer()
        taskAssignTomeView.addGestureRecognizer(assignTome)
        assignTome.addTarget(self, action: #selector(taskAssignMeScreen))
        
        let assignByme = UITapGestureRecognizer()
        taskAssignBymeView.addGestureRecognizer(assignByme)
        assignByme.addTarget(self, action: #selector(taskAssignBymeScreen))
        
        // Do any additional setup after loading the view.
    }
    func setTeacherDetail() {
        teacherNameLbl.text = UserDefaults.getUserDetail()?.name
        tDesignationNameLbl.text = UserDefaults.getUserDetail()?.DesignationName
        let img = UserDefaults.getUserDetail()?.profil_pic ?? ""
        let imgUrl = URL(string: img)
        teacherImgView.kf.setImage(with: imgUrl,placeholder: UIImage.placeHolderImg)
        
    }
    @objc func taskAssignScreen() {
        performSegue(withIdentifier: AppStrings.AppSegue.assignTaskSegue.getDescription, sender: nil)
    }
    @objc func taskAssignMeScreen() {
        performSegue(withIdentifier: AppStrings.AppSegue.taskAssignMeSegue.getDescription, sender: nil)
    }
    @objc func taskAssignBymeScreen() {
        performSegue(withIdentifier: AppStrings.AppSegue.assignBymeSgue.getDescription, sender: nil)
    }
}

