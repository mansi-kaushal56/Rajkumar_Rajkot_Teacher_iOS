//
//  SplashScreenVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 03/08/23.
//

import UIKit

class SplashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(splashScreen), with: nil, afterDelay: 1.5)
        // Do any additional setup after loading the view.
    }
    @objc func splashScreen() {
        performSegue(withIdentifier: AppStrings.AppSegue.splashToLoginSegue.getDescription, sender: nil)
    }
}
