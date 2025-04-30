//
//  HomeworkAssignmentVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 05/09/23.
//

import UIKit

class HomeworkAssignmentVC: UIViewController {
    var currentTabIndex = 0
    @IBOutlet weak var assignmentLbl: UILabel!
    @IBOutlet weak var homeworkLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var assignmentLabel: UILabel!
    @IBOutlet weak var homeworkLabel: UILabel!
    @IBOutlet weak var assignmentImg: UIImageView!
    @IBOutlet weak var homeworkImg: UIImageView!
    @IBOutlet weak var assignmentView: UIView!
    @IBOutlet weak var homeWorkView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Homework/Assignment")
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationAction(_:)), name: .passNextVC, object: nil)
        homeWorkPage(type: .Homework)
        tapGestureRecognizers()
        
        // Do any additional setup after loading the view.
    }

    @objc func NotificationAction(_ notification: NSNotification) {
        print(notification.userInfo?["userInfo"] as? [String:Any] ?? [:])
        if let userInfo = notification.userInfo {
            if let index = userInfo["userInfo"] as? Int {
                print(index)
                var currentVc = String()
                switch index {
                case 1:
                    currentVc = AppStrings.ViewControllerIdentifiers.homeWorkDetailvc.getIdentifier
                case 2:
                    currentVc = AppStrings.ViewControllerIdentifiers.assignmentDetailvc.getIdentifier
                default:
                    print("Unkown Selection")
                }
                
                if self.children.count > 0 {
                    let viewControllers:[UIViewController] = self.children
                    for viewContoller in viewControllers{
                        viewContoller.willMove(toParent: nil)
                        viewContoller.view.removeFromSuperview()
                        viewContoller.removeFromParent()
                    }
                }
                
                if !currentVc.isEmpty {
                    var storyBoard = String()
                    storyBoard = AppStrings.AppStoryboards.dashboard.getDescription
                    let vc = UIStoryboard(name: storyBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: currentVc)
                    embed(viewController: vc, inView: containerView)
                }
            }
        }
    }
    func homeWorkPage(type:ScreenType) {
        switch type {
        case .Homework:
            homeWorkView.backgroundColor = .AppSkyBlue
            assignmentView.backgroundColor = .clear
            homeworkLbl.textColor = .white
            assignmentLbl.textColor = .black
            assignmentImg.image = .assignmentBlackIcon
            homeworkImg.image = .homeworkWhiteIcon
            currentTabIndex = 1
            NotificationCenter.default.post(name:.passNextVC , object: self, userInfo:["userInfo": currentTabIndex])
        case .Assignment:
            homeWorkView.backgroundColor = .clear
            assignmentView.backgroundColor = .AppSkyBlue
            homeworkLbl.textColor = .black
            assignmentLbl.textColor = .white
            assignmentImg.image = .assignmentWhiteIcon
            homeworkImg.image = .homeworkBlackIcon
            currentTabIndex = 2
            NotificationCenter.default.post(name:.passNextVC , object: self, userInfo:["userInfo": currentTabIndex])
        default:
            print("Unknown type")
        }
          
       }
    func tapGestureRecognizers() {
        homeWorkView.addTapGestureRecognizer {
            self.homeWorkPage(type: .Homework)
        }
        assignmentView.addTapGestureRecognizer {
            self.homeWorkPage(type: .Assignment)
        }
    }
    
}
