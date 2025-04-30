//
//  EComplaintRecordVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 14/09/23.
//

import UIKit

class EComplaintRecordVC: UIViewController {
    var currentTabIndex = 0
    @IBOutlet weak var recordContainerView: UIView!
    @IBOutlet weak var resolvedRecordLbl: UILabel!
    @IBOutlet weak var resolvedRecordImg: UIImageView!
    @IBOutlet weak var resolvedRecordView: UIView!
    @IBOutlet weak var pandingRecordLbl: UILabel!
    @IBOutlet weak var pandingRecordImg: UIImageView!
    @IBOutlet weak var pandingRecordView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "E-Complaint Record")
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationAction(_:)), name: .passNextVC, object: nil)
        homeWorkPage(type: .Pending)
        tapGestureRecognizers()
        // Do any additional setup after loading the view.
    }
    @objc func NotificationAction(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let index = userInfo["userInfo"] as? Int {
                var currentVc = String()
                switch index {
                case 1:
                    currentVc = AppStrings.ViewControllerIdentifiers.eComplaintPendingRecordVc.getIdentifier
                case 2:
                    currentVc = AppStrings.ViewControllerIdentifiers.eComplaintResolvedRecordvc.getIdentifier
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
                    embed(viewController: vc, inView: recordContainerView)
                }
            }
        }
    }
    func homeWorkPage(type:ScreenType) {
        switch type {
        case .Pending:
            pandingRecordView.backgroundColor = .AppSkyBlue
            resolvedRecordView.backgroundColor = .clear
            pandingRecordLbl.textColor = .white
            resolvedRecordLbl.textColor = .black
            resolvedRecordImg.image = .resolvedBlkIcon
            pandingRecordImg.image = .pandingWhiteIcon
            currentTabIndex = 1
            NotificationCenter.default.post(name:.passNextVC , object: self, userInfo:["userInfo": currentTabIndex])
        case .Resolved:
            pandingRecordView.backgroundColor = .clear
            resolvedRecordView.backgroundColor = .AppSkyBlue
            pandingRecordLbl.textColor = .black
            resolvedRecordLbl.textColor = .white
            resolvedRecordImg.image = .resolvedWhiteIcon
            pandingRecordImg.image = .pandingBlackIcon
            currentTabIndex = 2
            NotificationCenter.default.post(name:.passNextVC , object: self, userInfo:["userInfo": currentTabIndex])
        default:
            print("Unknown type")
        }
          
       }
    func tapGestureRecognizers() {
        pandingRecordView.addTapGestureRecognizer {
            self.homeWorkPage(type: .Pending)
        }
        resolvedRecordView.addTapGestureRecognizer {
            self.homeWorkPage(type: .Resolved)
        }
    }
}
