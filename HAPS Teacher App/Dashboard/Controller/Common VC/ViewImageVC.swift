//
//  ViewImageVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 11/08/23.
//

import UIKit
import Kingfisher

class ViewImageVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgScrollView: UIScrollView!
    var image : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUPScrollView()
        let img = image ?? ""
        let imgUrl = URL(string: img)
        imgView.kf.setImage(with: imgUrl)
        // Do any additional setup after loading the view.
    }
    func setUPScrollView() {
        imgScrollView.delegate = self
    }
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func shareBtn(_ sender: UIButton) {
        
        let activityViewController = UIActivityViewController(activityItems: [image ?? ""], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
}
extension ViewImageVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
}

