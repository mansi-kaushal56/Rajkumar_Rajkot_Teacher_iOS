//
//  StudentCircularVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 07/09/23.
//

import UIKit

class StudentCircularVC: UIViewController {
    var currentTabIndex = 0
    var vcTitle = ""
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewCircularLbl: UILabel!
    @IBOutlet weak var viewCircularImg: UIImageView!
    @IBOutlet weak var viewCircularView: UIView!
    @IBOutlet weak var createCircularLbl: UILabel!
    @IBOutlet weak var createCircularView: UIView!
    @IBOutlet weak var createCircularImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Student Circular")
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationAction(_:)), name: .passNextVC, object: nil)
        createCircularPage(type: .CreateCircular)
        tapGestureRecognizers()
        // Do any additional setup after loading the view.
    }
    @objc func NotificationAction(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let index = userInfo["userInfo"] as? Int {
                var currentVc = String()
                switch index {
                case 1:
                    currentVc = AppStrings.ViewControllerIdentifiers.createStudentCircularvc.getIdentifier
                case 2:
                    currentVc = AppStrings.ViewControllerIdentifiers.viewStudentCircularvc.getIdentifier
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
    func createCircularPage(type:ScreenType) {
        switch type {
        case .CreateCircular:
            createCircularView.backgroundColor = .AppSkyBlue
            viewCircularView.backgroundColor = .clear
            createCircularLbl.textColor = .white
            viewCircularLbl.textColor = .black
            viewCircularImg.image = .eyeBlkIcon
            createCircularImg.image = .circularWhiteIcon
            currentTabIndex = 1
            NotificationCenter.default.post(name:.passNextVC , object: self, userInfo:["userInfo": currentTabIndex])
        case .ViewCircular:
            createCircularView.backgroundColor = .clear
            viewCircularView.backgroundColor = .AppSkyBlue
            createCircularLbl.textColor = .black
            viewCircularLbl.textColor = .white
            viewCircularImg.image = .eyeWhiteIcon
            createCircularImg.image = .circularBlkIcon
            currentTabIndex = 2
            NotificationCenter.default.post(name:.passNextVC , object: self, userInfo:["userInfo": currentTabIndex])
        default:
            print("Unknown type")
        }
          
       }
    func tapGestureRecognizers() {
    createCircularView.addTapGestureRecognizer {
        self.createCircularPage(type: .CreateCircular)
        }
        viewCircularView.addTapGestureRecognizer {
            self.createCircularPage(type: .ViewCircular)
        }
    }
    
}

