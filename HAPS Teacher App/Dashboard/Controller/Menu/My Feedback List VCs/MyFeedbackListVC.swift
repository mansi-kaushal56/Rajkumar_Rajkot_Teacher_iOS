//
//  MyFeedbackListVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 20/09/23.
//

import UIKit

class MyFeedbackListVC: UIViewController {
    
    var currentTabIndex = 0
    @IBOutlet weak var feedbackContainerView: UIView!
    @IBOutlet weak var frownyLbl: UILabel!
    @IBOutlet weak var frownyImgView: UIImageView!
    @IBOutlet weak var frownyView: UIView!
    @IBOutlet weak var smileyLbl: UILabel!
    @IBOutlet weak var amileyImgView: UIImageView!
    @IBOutlet weak var smileyView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "My Feedback List")
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationAction(_:)), name: .passNextVC, object: nil)
        smileyPage(type: .Smiley)
        tapGestureRecognizers()
        // Do any additional setup after loading the view.
    }
    
    @objc func NotificationAction(_ notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            if let index = userInfo["userInfo"] as? Int {
               
                var currentVc = String()
                switch index {
                case 1:
                    currentVc = AppStrings.ViewControllerIdentifiers.smileyFeedbackListvc.getIdentifier
                case 2:
                    currentVc = AppStrings.ViewControllerIdentifiers.frownyFeedbackListvc.getIdentifier
                default:
                    print("Unknown Selection")
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
                    embed(viewController: vc, inView: feedbackContainerView)
                }
            }
        }
    }
    func smileyPage(type:ScreenType) {
        switch type {
        case .Smiley:
            smileyView.backgroundColor = .AppSkyBlue
            frownyView.backgroundColor = .clear
            smileyLbl.textColor = .white
            frownyLbl.textColor = .black
            frownyImgView.image = .frownyBlkIcon
            amileyImgView.image = .smileyWhiteIcon
            currentTabIndex = 1
            NotificationCenter.default.post(name:.passNextVC , object: self, userInfo:["userInfo": currentTabIndex])
        case .Frowny:
            smileyView.backgroundColor = .clear
            frownyView.backgroundColor = .AppSkyBlue
            smileyLbl.textColor = .black
            frownyLbl.textColor = .white
            frownyImgView.image = .frownyWhtIcon
            amileyImgView.image = .smileyBlkIcon
            currentTabIndex = 2
            NotificationCenter.default.post(name:.passNextVC , object: self, userInfo:["userInfo": currentTabIndex])
        default:
            print("Unknown type")
        }
          
       }
    func tapGestureRecognizers() {
        smileyView.addTapGestureRecognizer {
            self.smileyPage(type: .Smiley)
        }
        frownyView.addTapGestureRecognizer {
            self.smileyPage(type: .Frowny)
        }
    }
    
}
